%% analysis model data

%% FFT (using fieldtrip version 2018 12 31)
clear all
close all
addpath('\Users\UKWHome\Desktop\Johannes\fieldtrip-20181231\')
ft_defaults

whichelectrode=1;  % 1=distant, 2=proximate
if whichelectrode==1
    cd \Users\UKWHome\Desktop\Johannes\grating7
    load distant_electrode30  % elctrode with part overlapp to the stimulus
    tmean=data;
elseif whichelectrode==2 % elctrode with total overlapp to the stimulus
    cd \Users\UKWHome\Desktop\Johannes\grating9
    %cd \Users\UKWHome\Desktop\Johannes\garting6
    load proximate_electrode.mat
    tmean=proximate_electrode;
    %tmean=proximate_stimulus;
else
    cd \Users\UKWHome\Desktop\Johannes\grating7
    load distant_electrode80  % elctrode with no overlapp to the stimulus
    tmean=data;
end

Fs=1000;

%% induced
clear dataMEG
for i=1:100
    dataMEG.trial{i}=tmean(:,i)';
    dataMEG.time{i}=[1/Fs:1/Fs:size(tmean,1)/Fs]-1;
end
dataMEG.label{1}='MEG';
dataMEG.fsample=Fs;

clear datadownsampledandclean_han
cfg              = [];
cfg.channel = {'MEG'};
cfg.output       = 'pow';
cfg.method       = 'mtmconvol';
cfg.taper        = 'hanning';
cfg.foi          = 100:10:500;
cfg.toi          =[-0.9:0.01:2];
cfg.t_ftimwin    = ones(length(cfg.foi),1).*0.1; % ones(length(cfg.foi),1).*0.5;
cfg.pad=5;%'maxperlen';
cfg.keeptrials = 'yes';
cfg.keeptapers = 'no';
cfg.polyremoval =    0; %number (default = 0), specifying the order of the
%                      polynome which is fitted and subtracted from the
%                      time domain data prior to the spectral analysis. For example, a
%                      value of 1 corresponds to a linear trend. The default is a mean
%                      subtraction, thus a value of 0. If no removal is requested,
%                      specify -1.
datadownsampledandclean_han=ft_freqanalysis(cfg,dataMEG);

figure % Fig 6
cfg=[];
cfg.baseline       = [-0.25 -0.1];%[0.75 0.9];%'yes','no' or  (default = 'no'), see FT_FREQBASELINE
cfg.baselinetype   = 'relchange';%'absolute', 'relative', 'relchange' or 'db' (default = 'absolute')
cfg.xlim           =[-0.25 0.5];%[0.75 1.5];% %   cfg.xlim           = 'maxmin' or [xmin xmax] (default = 'maxmin')
%   cfg.ylim           = 'maxmin' or [ymin ymax] (default = 'maxmin')
if whichelectrode==1
    cfg.zlim           = [-2.5 2.5];%[-10 10];% plotting limits for color dimension, 'maxmin', 'maxabs', 'zeromax', 'minzero', or [zmin zmax] (default = 'maxmin')
elseif whichelectrode==2
    cfg.zlim           = [-30 30];%[-10 10];% plotting limits for color dimension, 'maxmin', 'maxabs', 'zeromax', 'minzero', or [zmin zmax] (default = 'maxmin')
else       cfg.zlim           = [-2 2];%[-10 10];% plotting limits for color dimension, 'maxmin', 'maxabs', 'zeromax', 'minzero', or [zmin zmax] (default = 'maxmin')
end
ft_singleplotTFR(cfg,datadownsampledandclean_han);
set(gcf,'color','w');




%% evoked
clear dataMEG
tmean;
dataMEG.trial{1}=mean(tmean(:,:),2)';
dataMEG.time{1}=[1/Fs:1/Fs:size(tmean,1)/Fs]-1;
dataMEG.label{1}='MEG';
dataMEG.fsample=Fs;

clear datadownsampledandclean_hanAVG
cfg              = [];
cfg.channel = {'MEG'};
cfg.output       = 'pow';
cfg.method       = 'mtmconvol';
cfg.taper        = 'hanning';
cfg.foi          = 100:10:500;
cfg.toi          =[-0.9:0.01:2];
cfg.t_ftimwin    = ones(length(cfg.foi),1).*0.1; % ones(length(cfg.foi),1).*0.5;
cfg.pad=5;%'maxperlen';
cfg.keeptrials = 'yes';
cfg.keeptapers = 'no';
cfg.polyremoval =    0; %number (default = 0), specifying the order of the
%                      polynome which is fitted and subtracted from the
%                      time domain data prior to the spectral analysis. For example, a
%                      value of 1 corresponds to a linear trend. The default is a mean
%                      subtraction, thus a value of 0. If no removal is requested,
%                      specify -1.
datadownsampledandclean_hanAVG=ft_freqanalysis(cfg,dataMEG);

figure % Fig 6
cfg=[];
cfg.baseline       = [-0.25 -0.1];%[0.75 1];%'yes','no' or  (default = 'no'), see FT_FREQBASELINE
cfg.baselinetype   = 'relchange';%'absolute', 'relative', 'relchange' or 'db' (default = 'absolute')
cfg.xlim           =[-0.25 0.5];%[0.8 1.5];% 'maxmin' or [xmin xmax] (default = 'maxmin')
if whichelectrode==1
    cfg.zlim           = [-60 60];%[-10 10];% plotting limits for color dimension, 'maxmin', 'maxabs', 'zeromax', 'minzero', or [zmin zmax] (default = 'maxmin')
elseif whichelectrode==2
    cfg.zlim           = [-6000 6000];%[-10 10];% plotting limits for color dimension, 'maxmin', 'maxabs', 'zeromax', 'minzero', or [zmin zmax] (default = 'maxmin')
else       cfg.zlim           = [-100 100];%[-10 10];% plotting limits for color dimension, 'maxmin', 'maxabs', 'zeromax', 'minzero', or [zmin zmax] (default = 'maxmin')
end
ft_singleplotTFR(cfg,datadownsampledandclean_hanAVG);
set(gcf,'color','w');



%% timing power
clear hilbfiltered
hilbfiltered(:,:)=squeeze(nanmean(datadownsampledandclean_han.powspctrm(:,1,...
    ft_nearest(datadownsampledandclean_han.freq,400):ft_nearest(datadownsampledandclean_han.freq,400),...
    :),3));


clear hilbfilteredAVG
hilbfilteredAVG(1,:)=squeeze(nanmean(datadownsampledandclean_hanAVG.powspctrm(:,1,...
    ft_nearest(datadownsampledandclean_hanAVG.freq,400):ft_nearest(datadownsampledandclean_han.freq,400),:),3));
clear hilbfiltered_norm hilbfilteredAVG_norm
for i=1:size(hilbfiltered,1)
    hilbfiltered_norm(i,:)=((hilbfiltered(i,:))-nanmin(hilbfiltered(i,:)))/(nanmax(hilbfiltered(i,:))-nanmin(hilbfiltered(i,:)));
end
hilbfilteredAVG_norm=((hilbfilteredAVG(1,:))-min(hilbfilteredAVG(1,:)))/(max(hilbfilteredAVG(1,:))-min(hilbfilteredAVG(1,:)));
figure % Fig 6
plot(datadownsampledandclean_hanAVG.time,nanmean(hilbfiltered_norm)','g')
hold on
plot(datadownsampledandclean_hanAVG.time,(hilbfilteredAVG_norm)','k')
set(gcf,'color','w');
xlim([-0.2 0.5])




%% phase amplitude
cd ..
clear freqou*
fsnew=Fs;% 1/timesteps;
fsnew=1/0.01;
[freqoutputA freqoutfreq]=BH_do_matlab_fft(hilbfiltered_norm(:,ft_nearest(datadownsampledandclean_hanAVG.time,-0.1):ft_nearest(datadownsampledandclean_hanAVG.time,0.5)),'g','fft(500 Hz)',0,fsnew); % [input(trials, timepoint); xx= color e.g. 'r', titlex='string', 1=figure, fs=samplingrate]
Frequ=freqoutputA;
freqoutfreqt=freqoutfreq;

clear freqoutputB
[freqoutputB freqoutfreq]=BH_do_matlab_fft(hilbfilteredAVG_norm(:,ft_nearest(datadownsampledandclean_hanAVG.time,-0.1):ft_nearest(datadownsampledandclean_hanAVG.time,0.5)),'g','fft(500 Hz)',0,fsnew); % [input(trials, timepoint); xx= color e.g. 'r', titlex='string', 1=figure, fs=samplingrate]
Frequ_AVG=freqoutputB;

figure % Fig 7
BH_figurefill_onefile(freqoutputA',(freqoutfreqt),1,'g'); %% [input (trial, time), frequency, 1= standard error/ 2= STD, color]
hold on
BH_figurefill_onefile(freqoutputB',(freqoutfreq),1,'r')
legend([], '400Hz','', '400Hz(avg)')
set(gcf,'color','w');
title(' power (normalized)')




