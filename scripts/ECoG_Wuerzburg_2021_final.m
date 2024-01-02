%% ECoG data

clear all
addpath('/opt/fieldtrip/');
addpath('/mnt/hpx/home/haendelb/matlab/BH_extrafiles');

cd /mnt/pns/home/haendelb/Data_recalled/stopp/Conrado/all_pelechan
initial_directory=pwd;

load Pele_allchannels_s39_TFRtaper_32k_uni  % all channels, % session 39
load TFR_taperPelefft  % only channel 253, % session 39
load TFR_taperPelefftAVG.mat % only channel 253, % session 39

fs=32000;

channel_of_interest=253;
summedover=0.05;  %in ms
timesteps=0.001;  % in ms



% rawdata
for trialn=1:size(data2.trial,2)
    temp(trialn,:)=data2.trial{trialn}(channel_of_interest,:);
end

BH_do_matlab_fft(temp(:,ft_nearest(data2.time{1},0.4):ft_nearest(data2.time{1},0.5)),temp(:,ft_nearest(data2.time{1},0.5):ft_nearest(data2.time{1},0.6)),fs)


% summed raw
clear sumraw
xx=floor((summedover/2)*fs);
for time=1:length(TFR_taper.time)
    timex=ft_nearest(data2.time{1},TFR_taper.time(time));
    sumraw(time,:)=sum(temp(:,timex-xx:timex+xx),2);
end


%% Fig 6b
 figure
        hold on
        clear x
        x=squeeze(nanmean(nanmean(TFR_taper.powspctrm(:,1,ft_nearest(TFR_taper.freq,500),:),1),3));
        plot(TFR_taper.time-0.5,(x-min(x))/(max(x)-min(x)),'g')
        hold on
        clear x
        x=squeeze(nanmean(nanmean(TFR_taperAVG.powspctrm(:,1,ft_nearest(TFR_taperAVG.freq,500),:),1),3));
        plot(TFR_taper.time-0.5,(x-min(x))/(max(x)-min(x)),'k')
        legend([],'500Hz power','500Hz(avg)')
        xlim([-0.2 0.5])
        ylim([-0.1 1.1])
        set(gcf, 'Color', 'white') % makes background of figure white

        
        
%% freq of power mdulation (amplitude phase)
clear ALL500
for i=1:size(TFR_taper.powspctrm,1)
clear x
x=squeeze(nanmean(TFR_taper.powspctrm(i,1,ft_nearest(TFR_taper.freq,500),ft_nearest(TFR_taper.time,0.3):ft_nearest(TFR_taper.time,1)),3));  %dimord: 'rpt_chan_freq_time'
ALL500(i,:)=(x-min(x))/(max(x)-min(x));
end
clear ALL500AVG
clear x
x=squeeze(TFR_taperAVG.powspctrm(:,1,ft_nearest(TFR_taperAVG.freq,500),ft_nearest(TFR_taperAVG.time,0.3):ft_nearest(TFR_taperAVG.time,1)));
ALL500AVG(:,:)=(x-min(x))/(max(x)-min(x));

figure
plot(mean(ALL500))
hold on
plot(ALL500AVG,'r')

%timesteps=0.005;  % in ms
fsnew= 1/mean(diff(TFR_taper.time));
clear freqout*
    [freqoutputA freqoutfreq]=BH_do_matlab_fft2(ALL500,'g','fft(500 Hz)',0,fsnew);
    [freqoutputB freqoutfreq]=BH_do_matlab_fft2(ALL500AVG','g','fft(500 Hz)',0,fsnew);


%% Fig 6c
figure
hold on
BH_figurefill_onefile((freqoutputA'),(freqoutfreq),1,'g')
BH_figurefill_onefile((freqoutputB'),(freqoutfreq),1,'r')
legend([], '500Hz','', '500Hz(avg)')

xlim([0 60])
ylim([-0.00001 18*10e-4])
set(gcf, 'Color', 'white') % makes background of figure white







%% plot over freq
freq1=200; freq2=1000;
time1=0;time2=0.5;
clear x xx
x=squeeze(nanmean(TFR_taper.powspctrm(:,1,ft_nearest(TFR_taper.freq,freq1):ft_nearest(TFR_taper.freq,freq2),ft_nearest(TFR_taper.time,0):ft_nearest(TFR_taper.time,0.5)),4));
xx=squeeze(nanmean(TFR_taper.powspctrm(:,1,ft_nearest(TFR_taper.freq,freq1):ft_nearest(TFR_taper.freq,freq2),ft_nearest(TFR_taper.time,0.5):ft_nearest(TFR_taper.time,1)),4));
BH_figurefill_gen(x,xx,TFR_taper.freq(ft_nearest(TFR_taper.freq,freq1):ft_nearest(TFR_taper.freq,freq2)))
title(sprintf('HF SE, %0.5g-%0.5g(s), -%0.5g- -%0.5g(s)',time1,time2,time2,time1))
legend([], 'before stimulus', 'during stimulus')
set(gcf, 'Color', 'white') % makes background of figure white

TFR_taperAVG
clear x xx
x=squeeze(nanmean(TFR_taperAVG.powspctrm(1,:,ft_nearest(TFR_taperAVG.freq,freq1):ft_nearest(TFR_taperAVG.freq,freq2),ft_nearest(TFR_taperAVG.time,0):ft_nearest(TFR_taperAVG.time,0.5)),4));
xx=squeeze(nanmean(TFR_taperAVG.powspctrm(1,:,ft_nearest(TFR_taperAVG.freq,freq1):ft_nearest(TFR_taperAVG.freq,freq2),ft_nearest(TFR_taperAVG.time,0.5):ft_nearest(TFR_taperAVG.time,1)),4));
BH_figurefill_gen(x',xx',TFR_taperAVG.freq(ft_nearest(TFR_taperAVG.freq,freq1):ft_nearest(TFR_taperAVG.freq,freq2)))
title(sprintf('HF_AVG SE, %0.5g-%0.5g(s), -%0.5g- -%0.5g(s)',time1,time2,time2,time1))
legend([], 'before stimulus', 'during stimulus')
set(gcf, 'Color', 'white') % makes background of figure white





%% topoplot 
 load Pele_allchannels_s39_TFRtaper_32k_uni  % all channels, % session 39

clear temp*
temp=[];
temp=TFR_taper;
load('pele_montage_rename_plx2elec')
[x y]=find(montage.tra);
temp.label=montage.labelnew;
temp.powspctrm=temp.powspctrm(:,y,:,:);


%% strange channels
temp.powspctrm(:,9,:,:)=1*10e-10;
temp.powspctrm(:,5,:,:)=1*10e-10;
temp.powspctrm(:,12,:,:)=1*10e-10;
temp.powspctrm(:,197,:,:)=1*10e-10;
temp.powspctrm(:,211,:,:)=1*10e-10;


temp.time=temp.time-0.5;

%% plot topo (Figure 6A )
load pele_layout_realistic_common_final
figure
cfg=[];
cfg.colorbar='yes';
cfg.zparam  ='powspctrm';
cfg.zlim='maxabs';
cfg.interactive='yes';
cfg.layout        =layout;%'ecog256bipolar.lay'; %'CTF275.lay'; %??
cfg.baselinetype='relchange';

cfg.ylim=[100 1000]; %freq
cfg.xlim=[0 1]; %time
cfg.baseline=[-0.25 0];
ft_topoplotTFR(cfg,temp);
set(gcf, 'Color', 'white') % makes background of figure white

cfg=[];
cfg.colorbar='yes';
cfg.zparam  ='powspctrm';
cfg.zlim='absmax';
cfg.interactive='yes';
cfg.layout        =layout;%'ecog256bipolar.lay'; %'CTF275.lay'; %??
cfg.ylim=[200 1000]; %freq
cfg.xlim=[-0.25 0.5]; %time
cfg.baseline=[-0.25 0];
cfg.zlim=[-0.25 0.25];
cfg.baselinetype='relchange';
cfg.channel=251;
figure
ft_singleplotTFR(cfg,temp)
set(gcf, 'Color', 'white') % makes background of figure white




load Pele_allchannels_TFRtaperAVG_32k_uni.mat
clear temp*
temp=[];
temp=TFR_taper_avg;
load('pele_montage_rename_plx2elec')
[x y]=find(montage.tra);
temp.label=montage.labelnew;
temp.powspctrm=temp.powspctrm(:,y,:,:);



%% strange channels
temp.powspctrm(:,9,:,:)=1*10e-10;
temp.powspctrm(:,5,:,:)=1*10e-10;
temp.powspctrm(:,12,:,:)=1*10e-10;
temp.powspctrm(:,197,:,:)=1*10e-10;
temp.powspctrm(:,211,:,:)=1*10e-10;


temp.time=temp.time-0.5;

%% plot topo (Figure suppplement)
load pele_layout_realistic_common_final
figure
cfg=[];
cfg.colorbar='yes';
cfg.zparam  ='powspctrm';
cfg.zlim='maxabs';
cfg.interactive='yes';
cfg.layout        =layout;%'ecog256bipolar.lay'; %'CTF275.lay'; %??
cfg.baselinetype='relchange';
cfg.zlim=[-4 4];
cfg.ylim=[100 1000]; %freq
cfg.xlim=[0 1]; %time
cfg.baseline=[-0.25 0];
ft_topoplotTFR(cfg,temp);
set(gcf, 'Color', 'white') % makes background of figure white

cfg=[];
cfg.colorbar='yes';
cfg.zparam  ='powspctrm';
cfg.zlim='absmax';
cfg.interactive='yes';
cfg.layout        =layout;%'ecog256bipolar.lay'; %'CTF275.lay'; %??
cfg.ylim=[200 1000]; %freq
cfg.xlim=[-0.25 0.5]; %time
cfg.baseline=[-0.25 0];
cfg.zlim=[-15 15];
cfg.baselinetype='relchange';
cfg.channel=251;
figure
ft_singleplotTFR(cfg,temp)
set(gcf, 'Color', 'white') % makes background of figure white