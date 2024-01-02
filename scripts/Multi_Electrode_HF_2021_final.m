
clear all
addpath('/opt/fieldtrip/');
addpath('/mnt/hpx/home/haendelb/matlab/BH_extrafiles');

set(gcf, 'Color', 'white') % makes background of figure white

for sessions=1:22
    
    
    cd /mnt/pns/home/haendelb/m-files/stopp/Thilo
    initial_directory=pwd;
    filenametxt='Thilo.txt';
    dcfg = DATASETS_actr; % all datasets with subsessions
    dirfiles = '//mnt/gs/home/haendelb/Data_recalled/stopp/Thilo/SDMA/Preproc/';  %where to save the output
    fs=32556; %32000;%3000;%
    firstfilter=8000; %old:14000;
    
    summedover=0.05;  %in ms
    timesteps=0.001;  % in ms
    
    
    newfile=dcfg(sessions).DNAME{length(dcfg(sessions).DNAME)};
    newfile2=sprintf('%sf',dcfg(sessions).DNAME{length(dcfg(sessions).DNAME)}(1:end-2));
    
    dataset = sprintf('%s_ds',newfile);
    
    load(sprintf('%s%s_append_arte_sess%d',dirfiles,dataset,sessions))
    load(sprintf('%s%s_spikes_sess%d',dirfiles,dataset,sessions))
    
    
    %% avg  
    cfg=[];
    cfg.inputfile=sprintf('%s%s_append_arte_sess%d',dirfiles,dataset,sessions);
    cfg.channel            = 'all';
    cfg.trials             = 'all' ;
    cfg.covariance         = 'no' ;
    cfg.keeptrials         = 'no';
    cfg.removemean         = 'no'; %or 'yes' for covariance computation (default = 'yes')
    [timelock] = ft_timelockanalysis(cfg);
    
    cfg              = [];
    cfg.output       = 'pow';
    cfg.method       = 'mtmconvol';
    cfg.taper        = 'dpss';
    cfg.foi          = [10 : 10 : 100, 200 : 100:500, 1000];% [100:100:2000];
    cfg.t_ftimwin    = ones(length(cfg.foi),1).*summedover;
    cfg.toi          = [-0.5:timesteps:0.5];%[0.35:0.025:1.75];
    cfg.tapsmofrq    = ones(length(cfg.foi),1).*100;
    cfg.pad='maxperlen'
    cfg.keeptrials = 'yes';
    cfg.keeptapers = 'no';
    TFR_taper_avg = ft_freqanalysis(cfg, timelock);
    
    % save Thilo_taper_fftavg TFR_taper_avg
    
    
    %% freq data high  
    cfg              = [];
    %cfg.trials=[1];
    cfg.output       = 'pow';
    cfg.channel      = datanew.label;
    cfg.method       = 'mtmconvol';
    cfg.taper        = 'dpss';
    cfg.foi          = [100 500 1000];% orig:  [100:100:2000];
    cfg.t_ftimwin    = ones(length(cfg.foi),1).*summedover;
    cfg.toi          = [-0.5:timesteps:0.5];%[0.35:0.025:1.75];
    cfg.tapsmofrq    = ones(length(cfg.foi),1).*100;
    cfg.pad='maxperlen'
    cfg.keeptrials = 'yes';
    cfg.keeptapers = 'no';
    TFR_taper = ft_freqanalysis(cfg, datanew);
    % save Thilo_taper_fft TFR_taper
    %save(sprintf('%s%s_TFRtaper_sess%d',dirfiles,dataset,sessions),'TFR_taper', '-v7.3')
    
    %% freq data low (60Hz)   % quick
    cfg              = [];
    cfg.channel = datanew.label;
    cfg.output       = 'pow';
    cfg.method       = 'mtmconvol';
    cfg.taper        = 'hanning';
    cfg.foi          = [60];
    cfg.toi          =[-0.5:timesteps:0.5];%[0.35:0.1:1.75];
    cfg.t_ftimwin    = ones(length(cfg.foi),1).*summedover; % ones(length(cfg.foi),1).*0.5;
    cfg.pad ='maxperlen';
    cfg.keeptrials = 'yes';
    cfg.keeptapers = 'no';
    TFR_hanning = ft_freqanalysis(cfg, datanew);
    
    
    
    %% rawdata
    for trialn=1:size(datanew.trial,2)
        temp(trialn,:)=datanew.trial{trialn}(1,:);
    end
    
      
    %% summed spikes
    clear sumspike
    clear sumraw
    xx=floor((summedover/2)*fs);
    for time=1:length(TFR_taper.time)
        timex=ft_nearest(datanew.time{1},TFR_taper.time(time));
        sumspike(time,:)=sum(spike.binaryspike(1,:,timex-xx:timex+xx),3);
        sumraw(time,:)=nanmean(temp(:,timex-xx:timex+xx),2);
    end
    
    
     
    %% MUA using fieldtrip
    clear tmp_bandpass
    cfg = [];
    cfg.dftfilter          = 'no';%'yes';
    cfg.dftfreq            = [50 :50:500];%[50 :50:firstfilter];
    cfg.padding            = 0; 
    cfg.dftfilter  = 'yes';
    cfg.demean        = 'no';%'yes';
    cfg.hpfilter      = 'yes';% 'no' or highpass filter (default = 'no')
    cfg.hpfreq        = [750];%highpass  frequency in Hz
    cfg.lpfilter      = 'yes';% 'no' or highpass filter (default = 'no')
    cfg.lpfreq        = [8000];%highpass  frequency in Hz
    tmp_bandpass     = ft_preprocessing(cfg,datanew);
   
 %% filter
    filterMUA=0;
    if filterMUA==1
        [B,A] = butter(2,100/(fs/2),'low'); %lowpass, filter order=2, 100 Hz
        for trialn=1:size(tmp_bandpass.trial,2)
            MUA_data_FT(trialn,:)=filtfilt(B,A,abs(hilbert(tmp_bandpass.trial{trialn}(1,:))));%abs(hilbert(LFP_data));
        end
    else
        for trialn=1:size(tmp_bandpass.trial,2)
            MUA_data_FT(trialn,:)=abs(hilbert(tmp_bandpass.trial{trialn}(1,:)));%abs(hilbert(LFP_data));
        end
    end
    
    
    
 
    %% LFP using fieldtrip
    clear tmp_highpass
    cfg = [];
    cfg.dftfilter          = 'no';%'yes';
    cfg.dftfreq            = [50 :50:500];%[50 :50:firstfilter];
    cfg.padding            = 0; %Conrado=10, Craig=5
    cfg.dftfilter  = 'yes';
    cfg.demean        = 'no';%'yes';
    cfg.lpfilter      = 'yes';% 'no' or highpass filter (default = 'no')
    cfg.lpfreq        = [500];%highpass  frequency in Hz
    tmp_highpass     = ft_preprocessing(cfg,datanew);
    for trialn=1:size(tmp_highpass.trial,2)
        LFP_data_FT(trialn,:)=tmp_highpass.trial{trialn}(1,:);%abs(hilbert(LFP_data));
    end
    
    
    ALLsumspike(sessions,:)=squeeze((nanmean(sumspike,2)- min(nanmean(sumspike,2)))/(max(nanmean(sumspike,2))- min(nanmean(sumspike,2))));
    
    clear x; x=nanmean(MUA_data_FT(:,ft_nearest(tmp_bandpass.time{1},-0.5):ft_nearest(tmp_bandpass.time{1},0.5)),1);
    clear B; B = smoothdata(x,'movmean',summedover*fs); clear x; x=B;
    ALLmua(sessions,:)=(x-min(x))/(max(x)-min(x));
    
    clear x; x=nanmean(LFP_data_FT(:,ft_nearest(tmp_highpass.time{1},-0.5):ft_nearest(tmp_highpass.time{1},0.5)),1);
    ALLlfp(sessions,:)=(x-min(x))/(max(x)-min(x));
    
    clear x; x=squeeze(nanmean(nanmean(TFR_taper.powspctrm(:,1,ft_nearest(TFR_taper.freq,500),:),1),3));
    ALL500(sessions,:)=(x-min(x))/(max(x)-min(x));
    clear x; x=squeeze(nanmean(nanmean(TFR_taper.powspctrm(:,1,ft_nearest(TFR_taper.freq,100),:),1),3));
    ALL100(sessions,:)=(x-min(x))/(max(x)-min(x));
    clear x; x=squeeze(nanmean(nanmean(TFR_taper.powspctrm(:,1,ft_nearest(TFR_taper.freq,1000),:),1),3));
    ALL1000(sessions,:)=(x-min(x))/(max(x)-min(x));
    
    clear x; x=squeeze(nanmean(nanmean(TFR_hanning.powspctrm(:,1,1,:),1),3));
    ALLgamma(sessions,:)=(x-min(x))/(max(x)-min(x));  %60 Hz
    
    clear x; x=squeeze(nanmean(nanmean(TFR_taper_avg.powspctrm(:,1,ft_nearest(TFR_taper_avg.freq,500),:),1),3));
    ALL500AVG(sessions,:)=(x-min(x))/(max(x)-min(x));
    clear x; x=squeeze(nanmean(nanmean(TFR_taper_avg.powspctrm(:,1,1:ft_nearest(TFR_taper_avg.freq,100),:),1),3));
    ALLfreqallAVG(sessions,:)=(x-min(x))/(max(x)-min(x));
    clear x; x=squeeze(nanmean(nanmean(TFR_taper_avg.powspctrm(:,1,ft_nearest(TFR_taper_avg.freq,100),:),1),3));
    ALL100AVG(sessions,:)=(x-min(x))/(max(x)-min(x));
    clear x; x=squeeze(nanmean(nanmean(TFR_taper_avg.powspctrm(:,1,ft_nearest(TFR_taper_avg.freq,1000),:),1),3));
    ALL1000AVG(sessions,:)=(x-min(x))/(max(x)-min(x));
    clear x; x=squeeze(nanmean(nanmean(TFR_taper_avg.powspctrm(:,1,ft_nearest(TFR_taper_avg.freq,20),:),1),3));
    ALL20AVG(sessions,:)=(x-min(x))/(max(x)-min(x));
    
    ALL2trialnum(sessions,1)=size(TFR_hanning.trialinfo,1);
    save('2021_Thilofiles.mat','A*','-v7.3','-nocompression')

    figya=0;
    if figya==1
        
        figure
        plot(TFR_taper.time,squeeze((nanmean(sumspike,2)- min(nanmean(sumspike,2)))/(max(nanmean(sumspike,2))- min(nanmean(sumspike,2)))),'r')
        
        hold on
       
        clear x
        x=nanmean(MUA_data_FT(:,ft_nearest(tmp_bandpass.time{1},-0.5):ft_nearest(tmp_bandpass.time{1},0.5)),1);
        B = smoothdata(x,'movmean',summedover*fs); clear x; x=B;
        plot(tmp_bandpass.time{1}(ft_nearest(tmp_bandpass.time{1},-0.5):ft_nearest(tmp_bandpass.time{1},0.5)),...
            (x-min(x))/(max(x)-min(x)),'b')
        
       
        clear x
        x=nanmean(LFP_data_FT(:,ft_nearest(tmp_highpass.time{1},-0.5):ft_nearest(tmp_highpass.time{1},0.5)),1);
        plot(tmp_highpass.time{1}(ft_nearest(tmp_highpass.time{1},-0.5):ft_nearest(tmp_highpass.time{1},0.5)),...
            (x-min(x))/(max(x)-min(x)),'c')
        
        clear x
        x=squeeze(nanmean(nanmean(TFR_taper.powspctrm(:,1,3,:),1),3));
        plot(TFR_taper.time,(x-min(x))/(max(x)-min(x)),'g')
        clear x
        x=squeeze(nanmean(nanmean(TFR_hanning.powspctrm(:,1,1,:),1),3));
        plot(TFR_hanning.time,(x-min(x))/(max(x)-min(x)),'m') %60 Hz
        clear x
        x=squeeze(nanmean(nanmean(TFR_taper_avg.powspctrm(:,1,5,:),1),3));
        plot(TFR_taper.time,(x-min(x))/(max(x)-min(x)),'k')
        legend([],'spike', 'MUAe', 'LFP','500Hz power','gamma power','500Hz(avg)')
        xlim([-0.2 0.5])
        ylim([-0.1 1.1])
    end
    
    time_short=TFR_taper_avg.time;
    time_long=datanew.time{1};
    %     save('2021_time.mat','time_*','-v7.3','-nocompression')

    clear -sessions -time_* -ALL*
    clearvars -except sessions time_* ALL*
end
return


% load 2021_Thilofiles
% load 2021_time
bb=[1:20]; % to average over all sessions
%% Figure 5B
bb=4; % using session 1 for Fiig 5 in paper
figure
hold on

plot(time_short,nanmean(ALLsumspike(bb,:),1),'r')
plot(time_long(ft_nearest(time_long,-0.5):ft_nearest(time_long,0.5)),nanmean(ALLmua(bb,:),1),'b')
plot(time_long(ft_nearest(time_long,-0.5):ft_nearest(time_long,0.5)),1-nanmean(ALLlfp(bb,:),1),'c')
plot(time_short,nanmean(ALL500(bb,:),1),'g');
plot(time_short,nanmean(ALLgamma(bb,:),1),'m');
plot(time_short,nanmean(ALL500AVG(bb,:),1),'k');
legend([],'spike', 'MUA', 'LFP','500Hz power','gamma power','500Hz(avg)')
xlim([-0.2 0.5])
ylim([-0.1 1.1])
set(gcf, 'Color', 'white') % makes background of figure white



figure
hold on
plot(time_short,nanmean(ALL100(bb,:),1),'c');
plot(time_short,nanmean(ALL500(bb,:),1),'g');
plot(time_short,nanmean(ALL1000(bb,:),1),'m');

plot(time_short,nanmean(ALL100AVG(bb,:),1),'b');
plot(time_short,nanmean(ALL500AVG(bb,:),1),'k');
plot(time_short,nanmean(ALL1000AVG(bb,:),1),'r');

legend([],'100Hz', '500Hz', '1000Hz','100Hz(avg)','500Hz(avg)','1000Hz(avg)')
set(gcf, 'Color', 'white') % makes background of figure white
xlim([-0.2 0.5])
ylim([-0.1 1.1])





%% freq of power mdulation (amplitude phase)
%timesteps=0.001;  % in ms
fsnew= 1/timesteps;


%
time1=-0.2;%-0.5;
time2=0.5;
clear ALL500AVG_norm
clear ALL500_norm
for i=1:size(bb,2)
clear x
x=squeeze(ALL500(i,ft_nearest(time_short,time1):ft_nearest(time_short,time2)));  %dimord: 'rpt_chan_freq_time'
ALL500_norm(i,:)=(x-min(x))/(max(x)-min(x));
clear x
x=squeeze(ALL500AVG(i,ft_nearest(time_short,time1):ft_nearest(time_short,time2)));  %dimord: 'rpt_chan_freq_time'
ALL500AVG_norm(i,:)=(x-min(x))/(max(x)-min(x));
end


 
    [freqoutputA freqoutfreq]=BH_do_matlab_fft2(ALL500_norm,'g','fft(500 Hz)',0,fsnew);
    [freqoutputB freqoutfreq]=BH_do_matlab_fft2(ALL500AVG_norm,'g','fft(500 Hz)',0,fsnew);

%% Figure 5C
figure
hold on
BH_figurefill_onefile((freqoutputA'),(freqoutfreq),1,'g')
BH_figurefill_onefile((freqoutputB'),(freqoutfreq),1,'r')
legend([], '500Hz','', '500Hz(avg)')
set(gcf, 'Color', 'white') % makes background of figure white
xlim([0 60])
ylim([-0.0001 1*10e-3])



figure
[freqoutputA freqoutfreq]=BH_do_matlab_fft2(ALLlfp,'g','fft(500 Hz)',0,fs);
BH_figurefill_onefile((freqoutputA'),(freqoutfreq),1,'g')








%% TF plot AVG
% taper
clear all
addpath('/opt/fieldtrip/');
addpath('/mnt/hpx/home/haendelb/matlab/BH_extrafiles');

set(gcf, 'Color', 'white') % makes background of figure white
for I=1
for sessions=1:22
    cd /mnt/pns/home/haendelb/m-files/stopp/Thilo
    initial_directory=pwd;
    filenametxt='Thilo.txt';
    dcfg = DATASETS_actr; % all datasets with subsessions
    dirfiles = '//mnt/gs/home/haendelb/Data_recalled/stopp/Thilo/SDMA/Preproc/';  %where to save the output
    fs=32556; %32000;%3000;%
    firstfilter=8000; %old:14000;
    
    summedover=0.05;  %in ms
    timesteps=0.001;  % in ms
    
    newfile=dcfg(sessions).DNAME{length(dcfg(sessions).DNAME)};
    newfile2=sprintf('%sf',dcfg(sessions).DNAME{length(dcfg(sessions).DNAME)}(1:end-2));
    
    dataset = sprintf('%s_ds',newfile);
    load(sprintf('%s%s_append_arte_sess%d',dirfiles,dataset,sessions))
    
    %% avg  % not too much time
    clear timelock
    cfg=[];
    cfg.inputfile=sprintf('%s%s_append_arte_sess%d',dirfiles,dataset,sessions);
    cfg.channel            = 'all';
    cfg.trials             = 'all' ;
    cfg.covariance         = 'no' ;
    cfg.keeptrials         = 'no';
    cfg.removemean         = 'no'; %or 'yes' for covariance computation (default = 'yes')
    [timelock] = ft_timelockanalysis(cfg);
    AVG_all(sessions,:)=timelock.avg(1,:);
    clear datanew
end

TFR_avgtoplot=timelock;
for i=1:22
TFR_avgtoplot.label{i}=num2str(i);
end
TFR_avgtoplot.avg=AVG_all;

    cfg              = [];
    cfg.output       = 'pow';
    cfg.method       = 'mtmconvol';
    cfg.taper        = 'dpss';
    cfg.foi          = [100 : 100: 1000];% [100:100:2000];
    cfg.t_ftimwin    = ones(length(cfg.foi),1).*summedover;
    cfg.toi          = [-0.5:timesteps:0.5];%[0.35:0.025:1.75];
    cfg.tapsmofrq    = ones(length(cfg.foi),1).*100;
    cfg.pad='maxperlen'
    cfg.keeptrials = 'yes';
    cfg.keeptapers = 'no';
    ALLTFR_taper_avg = ft_freqanalysis(cfg, TFR_avgtoplot);


    figure %% FIg 5d
    set(gcf, 'Color', 'white') % makes background of figure white
cfg=[];
cfg.channel      = {'all'};
cfg.zparam        = 'powspctrm';
cfg.zlim='absmax';
cfg.interactive='no';
cfg.baseline      = [-0.25 0];%[0 2];%'no';%
cfg.baselinetype   =  'relchange';%, 'relchange','absolute',
cfg.xlim=[-0.25 1];%[TFR_hanning.time(5) TFR_hanning.time(end-5)];%
cfg.ylim=[200 1000];
ft_singleplotTFR(cfg,ALLTFR_taper_avg);
title(sprintf('TFR %s','AVG'))
end



%% TF plot 500
% taper
clear all
addpath('/opt/fieldtrip/');
addpath('/mnt/hpx/home/haendelb/matlab/BH_extrafiles');

for sessions=1:22
    cd /mnt/pns/home/haendelb/m-files/stopp/Thilo
    initial_directory=pwd;
    filenametxt='Thilo.txt';
    dcfg = DATASETS_actr; % all datasets with subsessions
    dirfiles = '//mnt/gs/home/haendelb/Data_recalled/stopp/Thilo/SDMA/Preproc/';  %where to save the output
    fs=32556; %32000;%3000;%
    firstfilter=8000; %old:14000;
    summedover=0.05;  %in ms
    timesteps=0.025;  % in ms
    
    newfile=dcfg(sessions).DNAME{length(dcfg(sessions).DNAME)};
    newfile2=sprintf('%sf',dcfg(sessions).DNAME{length(dcfg(sessions).DNAME)}(1:end-2));
    dataset = sprintf('%s_ds',newfile);
    load(sprintf('%s%s_append_arte_sess%d',dirfiles,dataset,sessions))
    
    %% avg  
    cfg              = [];
    cfg.output       = 'pow';
    cfg.channel      = datanew.label;
    cfg.method       = 'mtmconvol';
    cfg.taper        = 'dpss';
    cfg.foi          = [100 :100: 1000];% orig:  [100:100:2000];
    cfg.t_ftimwin    = ones(length(cfg.foi),1).*summedover;
    cfg.toi          = [-0.5:timesteps:0.5];%[0.35:0.025:1.75];
    cfg.tapsmofrq    = ones(length(cfg.foi),1).*100;
    cfg.pad='maxperlen'
    cfg.keeptrials = 'yes';
    cfg.keeptapers = 'no';
    TFR_taper = ft_freqanalysis(cfg, datanew);
    TFR_all(sessions,:,:)=squeeze(nanmean(TFR_taper.powspctrm(:,1,:,:),1));%'rpt_chan_freq_time'
    clear datanew
end

TFR_taper = rmfield( TFR_taper, 'powspctrm' );
TFR_taper.powspctrm(:,:,:)=TFR_all;
TFR_taper.dimord='chan_freq_time';
for i=1:22
TFR_taper.label{i}=num2str(i);
end
TFR_taper = rmfield( TFR_taper, 'trialinfo' );

    figure
    set(gcf, 'Color', 'white') % makes background of figure white
cfg=[];
cfg.channel      = {'all'};
cfg.zparam        = 'powspctrm';
cfg.zlim='absmax';
cfg.interactive='no';
cfg.baseline      = [-0.25 0];%[0 2];%'no';%
cfg.baselinetype   = 'relchange';%relchange';% 'relative';%, ,'absolute',normchange', 'db' or 'zscore'
cfg.xlim=[-0.25 1];%[TFR_hanning.time(5) TFR_hanning.time(end-5)];%
cfg.ylim=[200 1000];
ft_singleplotTFR(cfg,TFR_taper);
title(sprintf('TFR %s','fft(trials)'))

% save TFR_taper2021 TFR_taper -v7.3
% save TFR_taper2021_B TFR_taper -v7.3



%% plot over freq
cd '/mnt/pns/home/haendelb/m-files/stopp/Thilo'
load TFR_taper2021
freq1=200; freq2=1000;
time1=0;time2=0.5;
clear x xx
x=squeeze(nanmean(TFR_taper.powspctrm(:,ft_nearest(TFR_taper.freq,freq1):ft_nearest(TFR_taper.freq,freq2),ft_nearest(TFR_taper.time,-1*time2):ft_nearest(TFR_taper.time,time1)),3));
xx=squeeze(nanmean(TFR_taper.powspctrm(:,ft_nearest(TFR_taper.freq,freq1):ft_nearest(TFR_taper.freq,freq2),ft_nearest(TFR_taper.time,time1):ft_nearest(TFR_taper.time,time2)),3));
BH_figurefill_gen(x,xx,TFR_taper.freq(2:end))
title(sprintf('HF SE, %0.5g-%0.5g(s), -%0.5g- -%0.5g(s)',time1,time2,time2,time1))
legend([], 'before stimulus', 'during stimulus')
set(gcf, 'Color', 'white') % makes background of figure white

figure
ALLTFR_taper_avg
clear x xx
x=squeeze(nanmean(ALLTFR_taper_avg.powspctrm(1,:,ft_nearest(ALLTFR_taper_avg.freq,freq1):ft_nearest(ALLTFR_taper_avg.freq,freq2),ft_nearest(ALLTFR_taper_avg.time,-1*time2):ft_nearest(ALLTFR_taper_avg.time,time1)),4));
xx=squeeze(nanmean(ALLTFR_taper_avg.powspctrm(1,:,ft_nearest(ALLTFR_taper_avg.freq,freq1):ft_nearest(ALLTFR_taper_avg.freq,freq2),ft_nearest(ALLTFR_taper_avg.time,time1):ft_nearest(ALLTFR_taper_avg.time,time2)),4));
BH_figurefill_gen(x,xx,ALLTFR_taper_avg.freq(2:end))
title(sprintf('HF_AVG SE, %0.5g-%0.5g(s), -%0.5g- -%0.5g(s)',time1,time2,time2,time1))
legend([], 'before stimulus', 'during stimulus')
set(gcf, 'Color', 'white') % makes background of figure white



%% other plots
figure
plot(TFR_taper.time,squeeze(nansum(sumspike,2)),'r')
hold on
plot(datanew.time{1},nanmean(temp,1)*10,'b') % raw data
plot(TFR_taper.time,nanmean(sumraw,2)./100,'c')
plot(datanew.time{1},nanmean(tempmuax_data,1)*100,'r')
plot(datanew.time{1},nanmean(LFP_data_data,1)*10,'b')

plot(TFR_taper.time,squeeze(nanmean(nanmean(TFR_taper.powspctrm(:,1,1,:),1),3))*300,'g')
plot(TFR_hanning.time,squeeze(nanmean(nanmean(TFR_hanning.powspctrm(:,1,1,:),1),3))*10,'m') %60%
plot(TFR_taper.time,squeeze(nanmean(nanmean(TFR_taper_avg.powspctrm(:,1,5,:),1),3))*5000+250,'y')

grid on
title('green=pow 500Hz, mag=pow 60Hz,blue=raw data, red=summed binary spike over 0.05s (same as power), cyan=summed raw, yellow= fft(avg) 500Hz')


% make max and latency (For timeperiod)
timestart=0; %in sec
timeend=0.5; %in sec


for i=1:size(sumspike,2)
    [x y]=max(TFR_taper.powspctrm(i,1,1,ft_nearest(TFR_taper.time,timestart):ft_nearest(TFR_taper.time,timeend)));
    maxtfrT(i,1)=x;
    lattfrT(i,1)=TFR_taper.time(ft_nearest(TFR_taper.time,timestart)+y-1);
    
    [x y]=max(TFR_hanning.powspctrm(i,1,1,ft_nearest(TFR_hanning.time,timestart):ft_nearest(TFR_hanning.time,timeend)));
    maxtfrH(i,1)=x;
    lattfrH(i,1)=TFR_taper.time(ft_nearest(TFR_hanning.time,timestart)+y-1);
    
    [x y]=max(sumspike(ft_nearest(TFR_taper.time,timestart):ft_nearest(TFR_taper.time,timeend),i));
    maxspike(i,1)=x;
    latspike(i,1)=TFR_taper.time(ft_nearest(TFR_taper.time,timestart)+y-1);
 
    [x y]=min(sumraw(ft_nearest(TFR_taper.time,timestart):ft_nearest(TFR_taper.time,timeend),i));
    
    maxraw(i,1)=x;
    latraw(i,1)=TFR_taper.time(ft_nearest(TFR_taper.time,timestart)+y-1);
end

