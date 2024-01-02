%Activate Perl Module --> Parser
perl('parserwavepattern.pl');

%Import Data
wavepattern0 = dlmread('wavepattern00.txt',';');
testplot0 = wavepattern0(:,2);
testplot0 = testplot0(500:4500);

wavepattern1 = dlmread('wavepattern01.txt',';');
testplot1 = wavepattern1(:,2);
testplot1 = testplot1(500:4500);

wavepattern2 = dlmread('wavepattern02.txt',';');
testplot2 = wavepattern2(:,2);
testplot2 = testplot2(500:4500);

wavepattern3 = dlmread('wavepattern03.txt',';');
testplot3 = wavepattern3(:,2);
testplot3 = testplot3(500:4500);

wavepattern4 = dlmread('wavepattern04.txt',';');
testplot4 = wavepattern4(:,2);
testplot4 = testplot4(500:4500);

wavepattern5 = dlmread('wavepattern05.txt',';');
testplot5 = wavepattern5(:,2);
testplot5 = testplot5(500:4500);

waveeeg0 = dlmread('eegsignal.txt',';');
eeg0 = waveeeg0(:,2);
eeg0 = eeg0(500:4500);

waveeeg1 = dlmread('eegsignal6.txt',';');
eeg1 = waveeeg1(:,2);
eeg1 = eeg1(500:4500);


%set some parameters for fft analysis and peakfinder
L = length(testplot0);                % Lenght of Signal
Fs = 1000;                            % Sampling frequency
T = 1/Fs;                             % Sample Time
t = (0:L-1)*T;                        % Time Vector
NFFT = 2^nextpow2(L);                 % Next power of 2 from length of y
f = Fs/2*linspace(0,1,NFFT/2+1);      % Frequency

%%%%%%%%%%%%%%%DESCRIPTION%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% smooth signals in some cases
% normalize EEG signals in some cases / cut EEG Signals? / EEG signals auf null schneiden / EEG signals auslaufen lassen
% find peaks of fft signal
% first calculate fft
% second find peaks in eeg signal and show them
% analyse peaks of fft
%% general single analysis of each plot /peaks width vs. occurence, peaks height vs. occurences, intervals between peaks vs occurence, peak area vs. occurences
%% analysis of selectivity of signal
%%% peak position vs. peak width, oder peak width vs. intervals between peaks
%%% auswertung für krankheiten influence of schizo vs. number of peaks by created number of inputs ( 6 )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%{
% smooth data - calculate running average
windowSize = 9;
runav = ones(1,windowSize)/windowSize;
halfSize = floor(windowSize/2);

windowSizeEEG = 11;
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
%}

% normalize with mean 
%{
testplot0 = testplot0 - mean(testplot0);
testplot1 = testplot1 - mean(testplot1);
testplot2 = testplot2 - mean(testplot2);
testplot3 = testplot3 - mean(testplot3);
testplot4 = testplot4 - mean(testplot4);
testplot5 = testplot5 - mean(testplot5);
eeg0 = eeg0 - mean(eeg0);
eeg1 = eeg1 - mean(eeg1);
%}



%% fft analysis
%FastFourierTransformation 
A = fft(testplot0,NFFT)/L;
B = fft(testplot1,NFFT)/L;
C = fft(testplot2,NFFT)/L;
D = fft(testplot3,NFFT)/L;
E = fft(testplot4,NFFT)/L;
F = fft(testplot5,NFFT)/L;
G = fft(eeg0,NFFT)/L;
H = fft(eeg1,NFFT)/L;

%{
%% fft analysis- smoothed signal
%FastFourierTransformation 
A = fft(t0f,NFFT)/L;
B = fft(t1f,NFFT)/L;
C = fft(t2f,NFFT)/L;
D = fft(t3f,NFFT)/L;
E = fft(t4f,NFFT)/L;
F = fft(t5f,NFFT)/L;
G = fft(t6f,NFFT)/L;
H = fft(t7f,NFFT)/L;
%}


%% einseitige darstellung der fft und absolute value of complex numbers
yp0 = 2*abs(A(1:NFFT/2+1));
yp1 = 2*abs(B(1:NFFT/2+1));
yp2 = 2*abs(C(1:NFFT/2+1));
yp3 = 2*abs(D(1:NFFT/2+1));
yp4 = 2*abs(E(1:NFFT/2+1));
yp5 = 2*abs(F(1:NFFT/2+1));
yp6 = 2*abs(G(1:NFFT/2+1));
yp7 = 2*abs(H(1:NFFT/2+1));




%% begrenz den analysierten frequenz bereich

f = f(f <= 500);
%f = f(f >= 5);
yp0 = yp0(1:length(f));
yp1 = yp1(1:length(f));
yp2 = yp2(1:length(f));
yp3 = yp3(1:length(f));
yp4 = yp4(1:length(f));
yp5 = yp5(1:length(f));
yp6 = yp6(1:length(f));
yp7 = yp7(1:length(f));





% smooth data - calculate running average (fuer einen linearen tiefpassfilter)

windowSize = 600;
runav = ones(1,windowSize)/windowSize;
halfSize = floor(windowSize/2);
%{

t0 = yp0;
t0f = conv(t0,runav);
t0f = t0f(halfSize+1:end-halfSize);

t1 = yp1;
t1f = conv(t1,runav);
t1f = t1f(halfSize+1:end-halfSize);

t2 = yp2;
t2f = conv(t2,runav);
t2f = t2f(halfSize+1:end-halfSize);

t3 = yp3;
t3f = conv(t3,runav);
t3f = t3f(halfSize+1:end-halfSize);

t4 = yp4;
t4f = conv(t4,runav);
t4f = t4f(halfSize+1:end-halfSize);

t5 = yp5;
t5f = conv(t5,runav);
t5f = t5f(halfSize+1:end-halfSize);

t6 = yp6;
t6f = conv(t6,runav);
t6f = t6f(halfSize+1:end-halfSize);

t7 = yp7;
t7f = conv(t7,runav);
t7f = t7f(halfSize+1:end-halfSize);


% benutze den running average das signal durch den eigen running averag zu teilen
%
yp0 = yp0(1:end-1)./t0f;
yp0(end+1) = 0;

yp1 = yp1(1:end-1)./t1f;
yp1(end+1) = 0;

yp2 = yp2(1:end-1)./t2f;
yp2(end+1) = 0;

yp3 = yp3(1:end-1)./t3f;
yp3(end+1) = 0;

yp4 = yp4(1:end-1)./t4f;
yp4(end+1) = 0;

yp5 = yp5(1:end-1)./t5f;
yp5(end+1) = 0;

yp6 = yp6(1:end-1)./t6f;
yp6(end+1) = 0;

yp7 = yp7(1:end-1)./t7f;
yp7(end+1) = 0;
%}
%{
t0 = yp0;
t0f = conv(t0,runav);
t0f = t0f(halfSize+1:end-halfSize);

t1 = yp1;
t1f = conv(t1,runav);
t1f = t1f(halfSize+1:end-halfSize);

t2 = yp2;
t2f = conv(t2,runav);
t2f = t2f(halfSize+1:end-halfSize);

t3 = yp3;
t3f = conv(t3,runav);
t3f = t3f(halfSize+1:end-halfSize);

t4 = yp4;
t4f = conv(t4,runav);
t4f = t4f(halfSize+1:end-halfSize);

t5 = yp5;
t5f = conv(t5,runav);
t5f = t5f(halfSize+1:end-halfSize);

t6 = yp6;
t6f = conv(t6,runav);
t6f = t6f(halfSize+1:end-halfSize);

t7 = yp7;
t7f = conv(t7,runav);
t7f = t7f(halfSize+1:end-halfSize);
%}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% hier die frequency analyse mit peakstats
%>> x=[0:.1:1000];y=5+5.*cos(x)+randn(size(x));PS=peakstats(x,y,0,-1,15,23,3,1);
%Peak Summary Statistics
%PS=peakstats(x,y,SlopeThreshold,AmpThreshold,smoothwidth,peakgroup,smoothtype,displayit,title,signal_length)
%output: peak, position, size, width, area
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%halfSize+1:end-halfSize
%{
% smoothed generic fitting
ps0 = peakstatsMEA(f(1:length(t0f)), t0f, mean(t0f)/9, mean(t0f)*1.2, 1, 3, 1, 1,'MEA1',length(waveeeg0));
ps1 = peakstatsMEA(f(1:length(t0f)), t1f, mean(t1f)/9, mean(t1f)*1.2, 1, 3, 1, 1,'MEA2',length(waveeeg0));
ps2 = peakstatsMEA(f(1:length(t0f)), t2f, mean(t2f)/9, mean(t2f)*1.2, 1, 3, 1, 1,'MEA3',length(waveeeg0));
ps3 = peakstatsMEA(f(1:length(t0f)), t3f, mean(t3f)/9, mean(t3f)*1.2, 1, 3, 1, 1,'MEA4',length(waveeeg0));
ps4 = peakstatsMEA(f(1:length(t0f)), t4f, mean(t4f)/9, mean(t4f)*1.2, 1, 3, 1, 1,'MEA5',length(waveeeg0));
ps5 = peakstatsMEA(f(1:length(t0f)), t5f, mean(t5f)/9, mean(t5f)*1.2, 1, 3, 1, 1,'MEA6',length(waveeeg0));
ps6 = peakstatsEEG(f(1:length(t0f)), t6f, mean(t6f)/9, mean(t6f)*1.2, 1, 3, 1, 1,'EEG1',length(waveeeg0));
ps7 = peakstatsEEG(f(1:length(t0f)), t7f, mean(t7f)/9, mean(t7f)*1.2, 1, 3, 1, 1,'EEG2',length(waveeeg0));
%}


% generic fitting
ps0 = peakstatsMEA(f, yp0, mean(yp0)/2, mean(yp0)/1, 1, 3, 1, 1,'MEA1',length(eeg0));
ps1 = peakstatsMEA(f, yp1, mean(yp1)/2, mean(yp1)/1, 1, 3, 1, 1,'MEA2',length(eeg0));
ps2 = peakstatsMEA(f, yp2, mean(yp2)/2, mean(yp2)/1, 1, 3, 1, 1,'MEA3',length(eeg0));
ps3 = peakstatsMEA(f, yp3, mean(yp3)/2, mean(yp3)/1, 1, 3, 1, 1,'MEA4',length(eeg0));
ps4 = peakstatsMEA(f, yp4, mean(yp4)/2, mean(yp4)/1, 1, 3, 1, 1,'MEA5',length(eeg0));
ps5 = peakstatsMEA(f, yp5, mean(yp5)/2, mean(yp5)/1, 1, 3, 1, 1,'MEA6',length(eeg0));
ps6 = peakstatsEEG(f, yp6, mean(yp6)/2, mean(yp6)/1, 1, 3, 1, 1,'EEG1',length(eeg0));
ps7 = peakstatsEEG(f, yp7, mean(yp7)/2, mean(yp7)/1, 1, 3, 1, 1,'EEG2',length(eeg0));




%% erstmal die normalen statistiken und dann plots
%{
ps0 = peakstatsMEA(f, yp0, 0.01, 1.8, 1, 3, 1, 1,'MEA1',length(waveeeg0));
ps1 = peakstatsMEA(f, yp1, 0.01, 1.8, 1, 3, 1, 1,'MEA2',length(waveeeg0));
ps2 = peakstatsMEA(f, yp2, 0.01, 1.8, 1, 3, 1, 1,'MEA3',length(waveeeg0));
ps3 = peakstatsMEA(f, yp3, 0.01, 1.8, 1, 3, 1, 1,'MEA4',length(waveeeg0));
ps4 = peakstatsMEA(f, yp4, 0.01, 1.8, 1, 3, 1, 1,'MEA5',length(waveeeg0));
ps5 = peakstatsMEA(f, yp5, 0.01, 1.8, 1, 3, 1, 1,'MEA6',length(waveeeg0));
ps6 = peakstatsEEG(f, yp6, 0.01, 1.8, 1, 3, 1, 1,'EEG1',length(waveeeg0));
ps7 = peakstatsEEG(f, yp7, 0.01, 1.8, 1, 3, 1, 1,'EEG2',length(waveeeg0));
%}

%{
x0 = ps0(:,2); y0 = ps0(:,3);
x1 = ps1(:,2); y1 = ps1(:,3);
x2 = ps2(:,2); y2 = ps2(:,3);
x3 = ps3(:,2); y3 = ps3(:,3);
x4 = ps4(:,2); y4 = ps4(:,3);
x5 = ps5(:,2); y5 = ps5(:,3);
x6 = ps6(:,2); y6 = ps6(:,3);
x7 = ps7(:,2); y7 = ps7(:,3);

%Plot fft Signal with peaks
%Plot single-sided amplitude spectrum.
%see fft_peak_analysis
%see peakstatsMEA and peakstatsEEG
% Plot peakstats
% plot trennschärfe
% number peaks, peaks width, interval between peaks ( x-axis: interval, y-axis: peak-width, z-axis HZ or mark Hz)
% in deutsch, halbwertsbreite muss größer sein als die entfernung der maxima, um zwei peaks zu trennen
% number of input peaks vs. number of output peaks
% oder einfach nur die peakbreiten angucken in signalen und daruas auf maximum trennschärfe schließen
% wohl einfach nur die anzhl der peaks abgleichen mit den input freq., 
% trennschärfe einfach nur die größte peakbreite eines inputs?
% oder durschnittliche peaksbreite mit abweichung!?
% trennschärfe variiert mit der eingesetzten bandbreite (trennschärfe bei niedrigen und hohen frequenzen)
% trennschärfe auch mit number of inputs? wieviel inputs kann ich geben!??

%% further analysis
% wieviel signale kann ich unterscheiden wenn das modell kleiner wird
% 
%}
