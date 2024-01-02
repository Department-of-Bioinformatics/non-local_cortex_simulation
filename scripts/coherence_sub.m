%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% data input


%Activate Perl Module --> Parser
perl('parserwavepattern.pl');

%Import Data
wavepattern0 = dlmread('wavepattern00.txt',';');
testplot0 = wavepattern0(:,2);
testplot0 = testplot0(1000:4000);
%testplot0 = testplot0 + (-1 * min(testplot0));
%testplot0 = ((testplot0-mean(testplot0))/std(testplot0));
%testplot0 = (testplot0.^2).^0.5;

wavepattern1 = dlmread('wavepattern01.txt',';');
testplot1 = wavepattern1(:,2);
testplot1 = testplot1(1000:4000);
%testplot1 = testplot1 + (-1 * min(testplot1));
%testplot1 = ((testplot1-mean(testplot1))/std(testplot1));
%testplot1 = (testplot1.^2).^0.5;

wavepattern2 = dlmread('wavepattern02.txt',';');
testplot2 = wavepattern2(:,2);
testplot2 = testplot2(1000:4000);
%testplot2 = testplot2 + (-1 * min(testplot2));
%testplot2 = ((testplot2-mean(testplot2))/std(testplot2));
%testplot2 = (testplot2.^2).^0.5;

wavepattern3 = dlmread('wavepattern03.txt',';');
testplot3 = wavepattern3(:,2);
testplot3 = testplot3(1000:4000);
%testplot3 = testplot3 + (-1 * min(testplot3));
%testplot3 = ((testplot3-mean(testplot3))/std(testplot3));
%testplot3 = (testplot3.^2).^0.5;

wavepattern4 = dlmread('wavepattern04.txt',';');
testplot4 = wavepattern4(:,2);
testplot4 = testplot4(1000:4000);
%testplot4 = testplot4 + (-1 * min(testplot4));
%testplot4 = ((testplot4-mean(testplot4))/std(testplot4));
%testplot4 = (testplot4.^2).^0.5;

wavepattern5 = dlmread('wavepattern05.txt',';');
testplot5 = wavepattern5(:,2);
testplot5 = testplot5(1000:4000);
%testplot5 = testplot5 + (-1 * min(testplot5));
%testplot5 = ((testplot5-mean(testplot5))/std(testplot5));
%testplot5 = (testplot5.^2).^0.5;

waveeeg0 = dlmread('eegsignal.txt',';');
eeg0 = waveeeg0(:,2);
eeg0 = eeg0(1000:4000);
%eeg0 = eeg0 + (-1 * min(eeg0));
%eeg0 = ((eeg0-mean(eeg0))/std(eeg0));
%eeg0 = (eeg0.^2).^0.5;

waveeeg1 = dlmread('eegsignal2.txt',';');
eeg1 = waveeeg1(:,2);
eeg1 = eeg1(1000:4000);
%eeg1 = eeg1 + (-1 * min(eeg1));
%eeg1 = ((eeg1-mean(eeg1))/std(eeg1));
%eeg1 = (eeg1.^2).^0.5;

waveeeg2 = dlmread('eegsignal3.txt',';');
eeg2 = waveeeg2(:,2);
eeg2 = eeg2(1000:4000);
%eeg0 = eeg0 + (-1 * min(eeg0));
%eeg0 = ((eeg0-mean(eeg0))/std(eeg0));
%eeg0 = (eeg0.^2).^0.5;

waveeeg3 = dlmread('eegsignal4.txt',';');
eeg3 = waveeeg3(:,2);
eeg3 = eeg3(1000:4000);
%eeg1 = eeg1 + (-1 * min(eeg1));
%eeg1 = ((eeg1-mean(eeg1))/std(eeg1));
%eeg1 = (eeg1.^2).^0.5;

waveeeg4 = dlmread('eegsignal5.txt',';');
eeg4 = waveeeg4(:,2);
eeg4 = eeg4(1000:4000);
%eeg0 = eeg0 + (-1 * min(eeg0));
%eeg0 = ((eeg0-mean(eeg0))/std(eeg0));
%eeg0 = (eeg0.^2).^0.5;

waveeeg5 = dlmread('eegsignal6.txt',';');
eeg5 = waveeeg5(:,2);
eeg5 = eeg5(1000:4000);
%eeg1 = eeg1 + (-1 * min(eeg1));
%eeg1 = ((eeg1-mean(eeg1))/std(eeg1));
%eeg1 = (eeg1.^2).^0.5;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%set some parameters for fft analysis and peakfinder
L = length(testplot0);                % Lenght of Signal
Fs = 1000;                            % Sampling frequency
T = 1/Fs;                             % Sample Time
t = (0:L-1)*T;                        % Time Vector
NFFT = 2^nextpow2(L);                 % Next power of 2 from length of y
f = Fs/2*linspace(0,1,NFFT/2+1);      % frequency




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% smooth data - calculate running average
% data are smoothed for plotting the signal and running average, but not for analysis

windowSize = 120;
runav = ones(1,windowSize)/windowSize;
halfSize = floor(windowSize/2);

windowSizeEEG = 50;
runavEEG = ones(1,windowSizeEEG)/windowSizeEEG;
halfSizeEEG = floor(windowSizeEEG/2);


t0 = testplot0;
t0f = conv(t0,runav);
t0f = t0f(halfSize+1:end-halfSize);

t1 = testplot1;
t1f = conv(t1,runav);
t1f = t1f(halfSize+1:end-halfSize);

t2 = testplot2;
t2f = conv(t2,runav);
t2f = t2f(halfSize+1:end-halfSize);

t3 = testplot3;
t3f = conv(t3,runav);
t3f = t3f(halfSize+1:end-halfSize);

t4 = testplot4;
t4f = conv(t4,runav);
t4f = t4f(halfSize+1:end-halfSize);

t5 = testplot5;
t5f = conv(t5,runav);
t5f = t5f(halfSize+1:end-halfSize);

t6 = eeg0;
t6f = conv(t6,runavEEG);
t6f = t6f(halfSizeEEG+1:end-halfSizeEEG);

t7 = eeg1;
t7f = conv(t7,runavEEG);
t7f = t7f(halfSizeEEG+1:end-halfSizeEEG);



%% Example

%% [cxy,fc] = mscohere(x,y,hamming(512),500,2048);
%% [cxy,f] = mscohere(x,y,window,noverlap,f,fs)
%% plot(fc/pi,cxy)


%x = t6f;
%y = t7f;

%mean(Cxy(80:length(fc(fc < 100))))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% coherence of MEA signals


% Defaults for this blog post
width = 7;     % Width in inches
height = 3;    % Height in inches
alw = 2;     % AxesLineWidth
fsz = 10;      % Fontsize
lw = 2;      % LineWidth
msz = 8;       % MarkerSize



h1 = figure;

x = testplot0;
y = testplot1;
[Cxy,fc] = mscohere(x,y,hamming(512),400,f,Fs);

Cxy_ra = Cxy;
Cxy_raf = conv(Cxy_ra,runav);
Cxy_raf = Cxy_raf(halfSize+1:end-halfSize);

plot(fc(1:length(Cxy_raf)),Cxy_raf,'color',[1 0 0],'LineWidth',lw);

hold all


x = testplot0;
y = testplot2;
[Cxy,fc] = mscohere(x,y,hamming(512),400,f,Fs);

Cxy_ra = Cxy;
Cxy_raf = conv(Cxy_ra,runav);
Cxy_raf = Cxy_raf(halfSize+1:end-halfSize);

plot(fc(1:length(Cxy_raf)),Cxy_raf,'color',[0 1 0],'LineWidth',lw);

hold all


x = testplot0;
y = testplot3;
[Cxy,fc] = mscohere(x,y,hamming(512),400,f,Fs);

Cxy_ra = Cxy;
Cxy_raf = conv(Cxy_ra,runav);
Cxy_raf = Cxy_raf(halfSize+1:end-halfSize);

plot(fc(1:length(Cxy_raf)),Cxy_raf,'color',[0 0 1],'LineWidth',lw);

hold all


x = testplot0;
y = testplot4;
[Cxy,fc] = mscohere(x,y,hamming(512),400,f,Fs);

Cxy_ra = Cxy;
Cxy_raf = conv(Cxy_ra,runav);
Cxy_raf = Cxy_raf(halfSize+1:end-halfSize);

plot(fc(1:length(Cxy_raf)),Cxy_raf,'color',[0 1 1],'LineWidth',lw);

hold all 


x = testplot0;
y = testplot5;
[Cxy,fc] = mscohere(x,y,hamming(512),400,f,Fs);

Cxy_ra = Cxy;
Cxy_raf = conv(Cxy_ra,runav);
Cxy_raf = Cxy_raf(halfSize+1:end-halfSize);

plot(fc(1:length(Cxy_raf)),Cxy_raf,'color',[1 0 1],'LineWidth',lw);

hold all 




%{
x = eeg0;
y = eeg1;
[Cxy,fc] = mscohere(x,y,hamming(512),400,f,Fs);

Cxy_ra = Cxy;
Cxy_raf = conv(Cxy_ra,runav);
Cxy_raf = Cxy_raf(halfSize+1:end-halfSize);

plot(fc(1:length(Cxy_raf)),Cxy_raf,'color',[0.5 0.5 0.2],'LineWidth',lw);
%}




title('Coherence MEA','FontSize',12,'FontWeight','bold','Fontname','Calibri');
xlabel('Frequency (Hz)','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
ylabel('Magnitude-Squared Coherence','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
xlim([0 200]);
ylim([0 1.1]);

ll = legend('MEA1-2','MEA1-3','MEA1-4','MEA1-5','MEA1-6');
set(ll,'FontSize',fsz);
set(ll,'FontWeight','bold');
set(ll,'Fontname','Calibri');
legend('Location','Northeast');
legend('boxoff');

ax = gca;
ax.XTick = 0:50:500;
ax.YTick = 0:0.2:1;
ax.YLabel.String = [];


% Determine the style
set(gca, 'FontSize', fsz, 'LineWidth', alw, 'FontWeight','bold','Fontname','Calibri'); %<- Set properties
set(gca, 'box', 'off');
set(gcf,'color','w');   %background of figure is white when printing.
set(gcf,'InvertHardcopy','on');   %background of figure is white when printing independet of current color


% Here we preserve the size of the image when we save it.
set(gcf,'PaperUnits', 'inches');
set(gcf, 'PaperSize', [width height]);         %<-set size of figure
set(gcf, 'PaperPositionMode', 'manual');


pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size of displayed figure
papersize = get(gcf, 'PaperSize');             %<- Set size of displayed figure
left = (papersize(1)- width)/2;                %<- Set size of displayed figure
bottom = (papersize(2)- height)/2;             %<- Set size of displayed figure
myfiguresize = [left, bottom, width, height];  %<- Set size of displayed figure
set(gcf,'PaperPosition', myfiguresize);        %<- Set size of displayed figure




print(h1,'-dpng','coherenceMEA1.png','-r1000');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% coherence of EEG signals

h2 = figure;

x = eeg0;
y = eeg1;
[Cxy,fc] = mscohere(x,y,hamming(512),400,f,Fs);

Cxy_ra = Cxy;
Cxy_raf = conv(Cxy_ra,runav);
Cxy_raf = Cxy_raf(halfSize+1:end-halfSize);

plot(fc(1:length(Cxy_raf)),Cxy_raf,'color',[1 0 0],'LineWidth',lw);

hold all


x = eeg0;
y = eeg2;
[Cxy,fc] = mscohere(x,y,hamming(512),400,f,Fs);

Cxy_ra = Cxy;
Cxy_raf = conv(Cxy_ra,runav);
Cxy_raf = Cxy_raf(halfSize+1:end-halfSize);

plot(fc(1:length(Cxy_raf)),Cxy_raf,'color',[0 1 0],'LineWidth',lw);

hold all


x = eeg0;
y = eeg3;
[Cxy,fc] = mscohere(x,y,hamming(512),400,f,Fs);

Cxy_ra = Cxy;
Cxy_raf = conv(Cxy_ra,runav);
Cxy_raf = Cxy_raf(halfSize+1:end-halfSize);

plot(fc(1:length(Cxy_raf)),Cxy_raf,'color',[0 0 1],'LineWidth',lw);

hold all


x = eeg0;
y = eeg4;
[Cxy,fc] = mscohere(x,y,hamming(512),400,f,Fs);

Cxy_ra = Cxy;
Cxy_raf = conv(Cxy_ra,runav);
Cxy_raf = Cxy_raf(halfSize+1:end-halfSize);

plot(fc(1:length(Cxy_raf)),Cxy_raf,'color',[0 1 1],'LineWidth',lw);

hold all 


x = eeg0;
y = eeg5;
[Cxy,fc] = mscohere(x,y,hamming(512),400,f,Fs);

Cxy_ra = Cxy;
Cxy_raf = conv(Cxy_ra,runav);
Cxy_raf = Cxy_raf(halfSize+1:end-halfSize);

plot(fc(1:length(Cxy_raf)),Cxy_raf,'color',[1 0 1],'LineWidth',lw);


hold all 




title('Coherence EEG','FontSize',12,'FontWeight','bold','Fontname','Calibri');
xlabel('Frequency (Hz)','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
ylabel('Magnitude-Squared Coherence','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
xlim([0 200]);
ylim([0 1.1]);

ll = legend('EEG1-2','EEG1-3','EEG1-4','EEG1-5','EEG1-6');
set(ll,'FontSize',fsz);
set(ll,'FontWeight','bold');
set(ll,'Fontname','Calibri');
legend('Location','Northeast');
legend('boxoff');

ax = gca;
ax.XTick = 0:50:500;
ax.YTick = 0:0.2:1;
ax.YLabel.String = [];


% Determine the style
set(gca, 'FontSize', fsz, 'LineWidth', alw, 'FontWeight','bold','Fontname','Calibri'); %<- Set properties
set(gca, 'box', 'off');
set(gcf,'color','w');   %background of figure is white when printing.
set(gcf,'InvertHardcopy','on');   %background of figure is white when printing independet of current color


% Here we preserve the size of the image when we save it.
set(gcf,'PaperUnits', 'inches');
set(gcf, 'PaperSize', [width height]);         %<-set size of figure
set(gcf, 'PaperPositionMode', 'manual');


pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size of displayed figure
papersize = get(gcf, 'PaperSize');             %<- Set size of displayed figure
left = (papersize(1)- width)/2;                %<- Set size of displayed figure
bottom = (papersize(2)- height)/2;             %<- Set size of displayed figure
myfiguresize = [left, bottom, width, height];  %<- Set size of displayed figure
set(gcf,'PaperPosition', myfiguresize);        %<- Set size of displayed figure



print(h2,'-dpng','coherenceEEG.png','-r1000');









