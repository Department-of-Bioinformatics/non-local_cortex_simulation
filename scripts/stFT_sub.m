%If you have the Signal Processing Toolbox software, you can compute the short-time Fourier transform.
%https://www.quora.com/How-can-I-compute-a-short-time-Fourier-transform-STFT-in-MATLAB

%%%%%%%%%%%%%%
%% spectrum widow size 1000
%% cut highest value or lower freq area
%% imagesc with static values
%% no log plot
%% compare to real schizophrenia measures
%% delta plot
%% 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% delta plot of schizophrenia analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Analysis of control
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ax = figure;
%ax1 = subplot(1,3,1);
%ax2 = subplot(1,3,2);
%ax3 = subplot(1,3,3);


%Activate Perl Module --> Parser
perl('parserwavepattern.pl');

%Import Data
wavepattern0 = dlmread('eegsignal4.txt',';');
%wavepattern0 = dlmread('wavepattern00.txt',';');
testplot0 = wavepattern0(:,2);
testplot0 = testplot0(1:6000);


%% averaging signal in time space
windowSize = 50;
runav = ones(1,windowSize)/windowSize;
halfSize = floor(windowSize/2);

%t0 = testplot0;
%testplot0 = conv(t0,runav);
%testplot0 = testplot0(halfSize+1:end-halfSize);


%% FFT or Spectrogram
%set some parameters for fft analysis and peakfinder
L = length(testplot0);                      % Lenght of Signal
Fs = 1000;                            % Sampling frequency
T = 1/Fs;                             % Sample Time
t = (0:L-1)*T;                        % Time Vector
NFFT = 2^nextpow2(L);                 % Next power of 2 from length of y
f = Fs/2*linspace(0,1,NFFT/2+1);      % frequency




windowsize = 500;
window = hanning(windowsize);
noverlap = windowsize-1;
%f = Fs/2*linspace(0,1,windowsize/2+1);      % frequency
%[s,f,t] = spectrogram(x,window,noverlap,f,fs) returns the spectrogram at the cyclical frequencies specified in f.
%
%
%[S,F,T] = spectrogram(testplot0,window,noverlap,length(window),Fs);
%[S,F,T] = spectrogram(testplot0,window,noverlap,NFFT,Fs);
[S,F,T] = spectrogram(testplot0,window,noverlap,f,Fs);

%S = abs(S(1:length(F(F(F<=100)>50)),:));




%Use running Average for frequency space
windowSize = 4;
runav = ones(1,windowSize)/windowSize;
halfSize = floor(windowSize/2);

t0f = ones(length(S(:,1)),length(S(1,:)));

t0 = abs(S);
for i = 1:length(t0(1,:))
    vec = conv(t0(:,i),runav);
	t0f(:,i) = vec(halfSize:end-halfSize);
	%t0f(:,i) = t0f(:,i)./max(t0f(:,i));
end

%{
t0 = abs(S);
for i = 1:length(t0(:,1))
    vec = conv(t0(i,:),runav);
	t0f(i,:) = vec(halfSize:end-halfSize);
	%t0f(:,i) = t0f(:,i)./max(t0f(:,i));
end
%}


%Normalize signal
S1 = S./t0f;

%t0f = conv(t0,runav);
%t0f = t0f(halfSize+1:end-halfSize);




control = figure;

normalize = length(window);

%imagesc(T,F(F(F<=500)>0.01),abs(S(length(F(F<=0.01)):length(F(F<=500)),:))/normalize);
%imagesc(T,F(F(F<=500)>0.01),abs(S1(length(F(F<=1)):length(F(F<500)),:))/normalize);
imagesc(T,F(F(F<=500)>0.01),abs(t0f(1:length(F(F(F<=500)>0.01)),:))/normalize);




% Defaults for this blog post
width = 3;     % Width in inches
height = 3;    % Height in inches
alw = 2;     % AxesLineWidth
fsz = 12;      % Fontsize
lw = 2;      % LineWidth
msz = 10;       % MarkerSize




set(gca,'YDir','Normal')
xlabel('Time (s)','FontSize',fsz,'FontWeight','bold','Fontname','Calibri')
ylabel('Frequency (Hz)','FontSize',fsz,'FontWeight','bold','Fontname','Calibri')
%title('Short-time Fourier Transform spectrum','FontWeight','bold','FontSize',12,'Fontname','Calibri')


set(gca, 'FontSize', fsz,'LineWidth', alw, 'FontWeight','bold','Fontname','Calibri'); %<- Set properties
set(findall(gcf,'type','text'),'LineWidth', alw,'FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
set(gca, 'box', 'off');
set(gcf,'color','w');
set(gca,'XTick',[0:0.5:20]);
set(gca,'YTick',[0:20:500]);
caxis([0 50]);
xlim([0.5 6.5]);
ylim([0 500]);


% Here we preserve the size of the image when we save it.
set(gcf,'PaperUnits', 'inches');
set(gcf, 'PaperSize', [width height]);         %<-set size of figure
set(gcf, 'PaperPositionMode', 'manual');

pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size of displayed figure

set(gcf,'InvertHardcopy','on');

papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);




c = colorbar('location','EastOutside');
p = get(c,'Position');
%set(c,'Position',[p(1)+0.1 p(2)+0.045 0.02 0.77]);
%set(get(c,'title'),'string','Amplitude (µV)','Rotation',90,'FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
%set(get(c,'title'),'Position',[5 14]);
set(c,'FontSize',fsz);
set(c,'FontWeight','bold');
set(c,'Fontname','Calibri');


print(control,'-dpng','schizo_control.png','-r1000');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Analysis of test 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Activate Perl Module --> Parser
perl('parserwavepattern.pl');

%Import Data
wavepattern0 = dlmread('eegsignal3.txt',';');
%wavepattern0 = dlmread('wavepattern00.txt',';');
testplot0 = wavepattern0(:,2);
testplot0 = testplot0(1:6000);


%% averaging signal in time space
windowSize = 50;
runav = ones(1,windowSize)/windowSize;
halfSize = floor(windowSize/2);

%t0 = testplot0;
%testplot0 = conv(t0,runav);
%testplot0 = testplot0(halfSize+1:end-halfSize);


%% FFT or Spectrogram
%set some parameters for fft analysis and peakfinder
L = length(testplot0);                      % Lenght of Signal
Fs = 1000;                            % Sampling frequency
T = 1/Fs;                             % Sample Time
t = (0:L-1)*T;                        % Time Vector
NFFT = 2^nextpow2(L);                 % Next power of 2 from length of y
f = Fs/2*linspace(0,1,NFFT/2+1);      % frequency




windowsize = 500;
window = hanning(windowsize);
noverlap = windowsize-1;
%f = Fs/2*linspace(0,1,windowsize/2+1);      % frequency
%[s,f,t] = spectrogram(x,window,noverlap,f,fs) returns the spectrogram at the cyclical frequencies specified in f.
%
%
%[S2,F2,T2] = spectrogram(testplot0,window,noverlap,length(window),Fs);
%[S2,F2,T2] = spectrogram(testplot0,window,noverlap,NFFT,Fs);
[S2,F2,T2] = spectrogram(testplot0,window,noverlap,f,Fs);

%S = abs(S(1:length(F(F(F<=100)>50)),:));




%Use running Average in frequency space
windowSize = 4;
runav = ones(1,windowSize)/windowSize;
halfSize = floor(windowSize/2);

t0f2 = ones(length(S2(:,1)),length(S2(1,:)));

t0 = abs(S2);
for i = 1:length(t0(1,:))
    vec = conv(t0(:,i),runav);
	t0f2(:,i) = vec(halfSize:end-halfSize);
	%t0f2(:,i) = t0f(:,i)./max(t0f(:,i));
end

%{
t0 = abs(S2);
for i = 1:length(t0(:,1))
    vec = conv(t0(i,:),runav);
	t0f2(i,:) = vec(halfSize:end-halfSize);
	%t0f2(:,i) = t0f2(:,i)./max(t0f2(:,i));
end
%}


S3 = S2./t0f2;

%t0f = conv(t0,runav);
%t0f = t0f(halfSize+1:end-halfSize);




test = figure;

normalize = length(window);

%imagesc(T2,F2(F2(F2<=500)>0.01),abs(S2(length(F2(F2<=0.01)):length(F2(F2<500)),:))/normalize);
%imagesc(T2,F2(F2(F2<=500)>0.01),abs(S3(length(F2(F2<=1)):length(F2(F2<500)),:))/normalize);
imagesc(T2,F2(F2(F2<=500)>0.01),abs(t0f2(1:length(F2(F2(F2<=500)>0.01)),:))/normalize);





set(gca,'YDir','Normal')
xlabel('Time (s)','FontSize',fsz,'FontWeight','bold','Fontname','Calibri')
ylabel('Frequency (Hz)','FontSize',fsz,'FontWeight','bold','Fontname','Calibri')
%title('Short-time Fourier Transform spectrum','FontWeight','bold','FontSize',12,'Fontname','Calibri')


set(gca, 'FontSize', fsz,'LineWidth', alw, 'FontWeight','bold','Fontname','Calibri'); %<- Set properties
set(findall(gcf,'type','text'),'LineWidth', alw,'FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
set(gca, 'box', 'off');
set(gcf,'color','w');
set(gca,'XTick',[0:0.5:20]);
set(gca,'YTick',[0:20:500]);
caxis([0 50]);
xlim([0.5 7.5]);
ylim([0 500]);




% Here we preserve the size of the image when we save it.
set(gcf,'PaperUnits', 'inches');
set(gcf, 'PaperSize', [width height]);         %<-set size of figure
set(gcf, 'PaperPositionMode', 'manual');

pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size of displayed figure

set(gcf,'InvertHardcopy','on');

papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);




c = colorbar('location','EastOutside');
p = get(c,'Position');
%set(c,'Position',[p(1)+0.1 p(2)+0.045 0.02 0.77]);
%set(get(c,'title'),'string','Amplitude (µV)','Rotation',90,'FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
%set(get(c,'title'),'Position',[5 14]);
set(c,'FontSize',fsz);
set(c,'FontWeight','bold');
set(c,'Fontname','Calibri');


print(test,'-dpng','schizo_test.png','-r1000');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Analysis of delta plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Sdev = abs(S) - abs(S2);




%Use running Average in frequency space
windowSize = 10;
runav = ones(1,windowSize)/windowSize;
halfSize = floor(windowSize/2);

t0f3 = ones(length(Sdev(:,1)),length(Sdev(1,:)));

t0 = abs(Sdev);
for i = 1:length(t0(1,:))
    vec = conv(t0(:,i),runav);
	t0f3(:,i) = vec(halfSize:end-halfSize);
	%t0f3(:,i) = t0f3(:,i)./max(t0f3(:,i));
end




dev1 = figure;


%imagesc(T2,F2(F2(F2<=500)>0.01),Sdev(length(F2(F2<=0.01)):length(F2(F2<500)),:)/normalize);
imagesc(T2,F2(F2(F2<=500)>0.01),abs(t0f3(1:length(F2(F2(F2<=500)>0.01)),:))/normalize);





set(gca,'YDir','Normal')
xlabel('Time (s)','FontSize',fsz,'FontWeight','bold','Fontname','Calibri')
ylabel('Frequency (Hz)','FontSize',fsz,'FontWeight','bold','Fontname','Calibri')
%title('Short-time Fourier Transform spectrum','FontWeight','bold','FontSize',12,'Fontname','Calibri')


set(gca, 'FontSize', fsz,'LineWidth', alw, 'FontWeight','bold','Fontname','Calibri'); %<- Set properties
set(findall(gcf,'type','text'),'LineWidth', alw,'FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
set(gca, 'box', 'off');
set(gcf,'color','w');
set(gca,'XTick',[0:0.5:20]);
set(gca,'YTick',[0:20:500]);
caxis([0 50]);
xlim([0.5 7.5]);
ylim([0 100]);




% Here we preserve the size of the image when we save it.
set(gcf,'PaperUnits', 'inches');
set(gcf, 'PaperSize', [width height]);         %<-set size of figure
set(gcf, 'PaperPositionMode', 'manual');

pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size of displayed figure

set(gcf,'InvertHardcopy','on');

papersize = get(gcf, 'PaperSize');
left = (papersize(1)- width)/2;
bottom = (papersize(2)- height)/2;
myfiguresize = [left, bottom, width, height];
set(gcf,'PaperPosition', myfiguresize);




c = colorbar('location','EastOutside');
p = get(c,'Position');
set(c,'Position',[p(1)+0.1 p(2)+0.045 0.02 0.77]);
%set(get(c,'title'),'string','Amplitude (µV)','Rotation',90,'FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
%set(get(c,'title'),'Position',[5 14]);
set(c,'FontSize',fsz);
set(c,'FontWeight','bold');
set(c,'Fontname','Calibri');


print(dev1,'-dpng','schizo_deviation.png','-r1000');

%print(ax,'-dpng','schizo_deviation.png','-r1000');