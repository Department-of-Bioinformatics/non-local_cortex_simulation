%Activate Perl Module --> Parser
perl('parserwavepattern.pl');

%Import Data
wavepattern0 = dlmread('wavepattern00.txt',';');
testplot0 = wavepattern0(:,2);
%testplot0 = testplot0(1100:end-1000);

wavepattern1 = dlmread('wavepattern01.txt',';');
testplot1 = wavepattern1(:,2);
%testplot1 = testplot1(1100:end-1000);

wavepattern2 = dlmread('wavepattern02.txt',';');
testplot2 = wavepattern2(:,2);
%testplot2 = testplot2(1100:end-1000);

wavepattern3 = dlmread('wavepattern03.txt',';');
testplot3 = wavepattern3(:,2);
%testplot3 = testplot3(1100:end-1000);

wavepattern4 = dlmread('wavepattern04.txt',';');
testplot4 = wavepattern4(:,2);
%testplot4 = testplot4(1100:end-1000);

wavepattern5 = dlmread('wavepattern05.txt',';');
testplot5 = wavepattern5(:,2);
%testplot5 = testplot5(1100:end-1000);

waveeeg0 = dlmread('eegsignal.txt',';');
eeg0 = waveeeg0(:,2);
%eeg0 = eeg0(1100:end-1000);

waveeeg1 = dlmread('eegsignal2.txt',';');
eeg1 = waveeeg1(:,2);
%eeg1 = eeg1(1100:end-1000);


%set some parameters for fft analysis and peakfinder
L = length(testplot0);                % Lenght of Signal
Fs = 1000;                            % Sampling frequency
T = 1/Fs;                             % Sample Time
t = (0:L-1)*T;                        % Time Vector
NFFT = 2^nextpow2(L);                 % Next power of 2 from length of y
f = Fs/2*linspace(0,1,NFFT/2+1);      % frequency


%%%%%%%%%%%%%%%DESCRIPTION%%%%%%%%%%%%%%%%%%%%
%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% smooth data - calculate running average
% data are smoothed for plotting the signal and running average, but not for analysis
windowSize = 5;
runav = ones(1,windowSize)/windowSize;
halfSize = floor(windowSize/2);

windowSizeEEG = 13;
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


% find the peaks in the signal

% findpeaks.pm
% peak finder
% function P=findpeaks(x,y,SlopeThreshold,AmpThreshold,SmoothWidth,FitWidth,smoothtype)
% x=[0:.01:50];y=cos(x);findpeaks(x,y,0,-1,5,5)
% output: peak, position, size, width, area
p0 = findpeaks(1:1:L, testplot0, 0.01, 0.01, 3, 3, 1);
p1 = findpeaks(1:1:L, testplot1, 0.01, 0.01, 3, 3, 1);
p2 = findpeaks(1:1:L, testplot2, 0.01, 0.01, 3, 3, 1);
p3 = findpeaks(1:1:L, testplot3, 0.01, 0.01, 3, 3, 1);
p4 = findpeaks(1:1:L, testplot4, 0.01, 0.01, 3, 3, 1);
p5 = findpeaks(1:1:L, testplot5, 0.01, 0.01, 3, 3, 1);
p6 = findpeaks(1:1:L, eeg0, 0.01, 1, 5, 3, 1);
p7 = findpeaks(1:1:L, eeg1, 0.01, 1, 5, 3, 1);

x0 = p0(:,2); y0 = p0(:,3);
x1 = p1(:,2); y1 = p1(:,3);
x2 = p2(:,2); y2 = p2(:,3);
x3 = p3(:,2); y3 = p3(:,3);
x4 = p4(:,2); y4 = p4(:,3);
x5 = p5(:,2); y5 = p5(:,3);
x6 = p6(:,2); y6 = p6(:,3);
x7 = p7(:,2); y7 = p7(:,3);


%% Signal example
%% Plot Original Output of NetLogo Simulation 
%% Signal is plotted and Peaks are marked
%% Running average is added

% Defaults for this blog post
width = 7;     % Width in inches
height = 3;    % Height in inches
alw = 2;     % AxesLineWidth
fsz = 10;      % Fontsize
lw = 2;      % LineWidth
msz = 8;       % MarkerSize




h7 = figure;

plot(Fs*t,testplot0,'linewidth',1,'color',[0 0 0],'LineWidth',lw,'MarkerSize',msz)
hold all
plot(Fs*t,t0f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz)
%hold all
%plot(x0,y0,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz)


axis([1000 length(testplot0) min(testplot0(1000:length(testplot0)))*1.8 max(testplot0(1000:length(testplot0)))*1.8])
%set(gca,'XTick',[0:100:15000])
%set(gca,'YTick',[-55:5:55])
title('Signal  MEA 1','FontWeight','bold', 'FontSize',12,'Fontname','Calibri')
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeigth','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (\muV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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

print(h7,'-dpng','MEA1.png','-r1000');




h8 = figure;

plot(Fs*t,testplot1,'linewidth',1,'color',[0 0 0],'LineWidth',lw,'MarkerSize',msz)
hold all
plot(Fs*t,t1f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz)
%hold all
%plot(x1,y1,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz)


axis([1000 length(testplot1) min(testplot1(1000:length(testplot1)))*1.8 max(testplot1(1000:length(testplot1)))*1.8])
%set(gca,'XTick',[0:100:15000])
%set(gca,'YTick',[-55:5:55])
title('Signal  MEA 2','FontWeight','bold', 'FontSize',12,'Fontname','Calibri')
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeigth','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (\muV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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

print(h8,'-dpng','MEA2.png','-r1000');




h9 = figure;

plot(Fs*t,testplot2,'linewidth',2,'color',[0 0 0],'LineWidth',lw,'MarkerSize',msz)
hold all
plot(Fs*t,t2f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz)
%hold all
%plot(x2,y2,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz)


axis([1000 length(testplot2) min(testplot2(1000:length(testplot2)))*1.8 max(testplot2(1000:length(testplot2)))*1.8])
%set(gca,'XTick',[0:100:15000])
%set(gca,'YTick',[-55:5:55])
title('Signal  MEA 3','FontWeight','bold', 'FontSize',12,'Fontname','Calibri')
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeigth','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (\muV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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

print(h9,'-dpng','MEA3.png','-r1000');




h10 = figure;

plot(Fs*t,testplot3,'linewidth',2,'color',[0 0 0],'LineWidth',lw,'MarkerSize',msz)
hold all
plot(Fs*t,t3f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz)
%hold all
%plot(x3,y3,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz)


axis([1000 length(testplot3) min(testplot3(1000:length(testplot3)))*1.8 max(testplot3(1000:length(testplot3)))*1.8])
%set(gca,'XTick',[0:100:15000])
%set(gca,'YTick',[-55:5:55])
title('Signal  MEA 4','FontWeight','bold', 'FontSize',12,'Fontname','Calibri')
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeigth','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (\muV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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

print(h10,'-dpng','MEA4.png','-r1000');




h11 = figure;

plot(Fs*t,testplot4,'linewidth',2,'color',[0 0 0],'LineWidth',lw,'MarkerSize',msz)
hold all
plot(Fs*t,t4f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz)
%hold all
%plot(x4,y4,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz)


axis([1000 length(testplot4) min(testplot4(1000:length(testplot4)))*1.8 max(testplot4(1000:length(testplot4)))*1.8])
%set(gca,'XTick',[0:100:15000])
%Sset(gca,'YTick',[-55:5:55])
title('Signal  MEA 5','FontWeight','bold', 'FontSize',12,'Fontname','Calibri')
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeigth','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (\muV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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

print(h11,'-dpng','MEA5.png','-r1000');




h12 = figure;

plot(Fs*t,testplot5,'linewidth',2,'color',[0 0 0],'LineWidth',lw,'MarkerSize',msz)
hold all
plot(Fs*t,t5f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz)
%hold all
%plot(x5,y5,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz)


axis([1000 length(testplot5) min(testplot5(1000:length(testplot5)))*1.8 max(testplot5(1000:length(testplot5)))*1.8])
%set(gca,'XTick',[0:100:15000])
%set(gca,'YTick',[-55:5:55])
title('Signal  MEA 6','FontWeight','bold', 'FontSize',12,'Fontname','Calibri')
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeigth','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (\muV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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

print(h12,'-dpng','MEA6.png','-r1000');





h13 = figure;

plot(Fs*t,eeg0,'linewidth',2,'color',[0 0 0],'LineWidth',lw,'MarkerSize',msz);
hold all;
plot(Fs*t,t6f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz);
%hold all;
%plot(x6,y6,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz);


axis([1000 length(eeg0) min(eeg0(1000:length(eeg0)))*1.8 max(eeg0(1000:length(eeg0)))*1.8]);
%axis([1000 length(testplot0) -100000 100000]);
%set(gca,'XTick',[0:100:15000]);
set(gca,'YTick',[-1000000:25000:1000000])
title('Signal EEG 1','FontWeight','bold','FontSize',12,'Fontname','Calibri');
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeigth','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (\muV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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

print(h13,'-dpng','eegplot1.png','-r1000');





h14 = figure;

plot(Fs*t,eeg1,'linewidth',2,'color',[0 0 0],'LineWidth',lw,'MarkerSize',msz);
hold all;
plot(Fs*t,t7f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz);
%hold all;
%plot(x7,y7,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz);


axis([1000 length(eeg1) min(eeg1(1000:length(eeg1)))*1.8 max(eeg1(1000:length(eeg1)))*1.8]);
%axis([1000 length(testplot0) -100000 100000]);
%set(gca,'XTick',[0:100:15000]);
set(gca,'YTick',[-1000000:25000:1000000])
title('Signal EEG 2','FontWeight','bold','FontSize',12,'Fontname','Calibri');
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeigth','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (\muV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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


print(h14,'-dpng','eegplot2.png','-r1000');





