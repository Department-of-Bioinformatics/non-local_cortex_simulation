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
%eeg2 = eeg2 + (-1 * min(eeg2));
%eeg2 = ((eeg2-mean(eeg2))/std(eeg2));
%eeg2 = (eeg2.^2).^0.5;

waveeeg3 = dlmread('eegsignal4.txt',';');
eeg3 = waveeeg3(:,2);
eeg3 = eeg3(1000:4000);
%eeg3 = eeg3 + (-1 * min(eeg3));
%eeg3 = ((eeg3-mean(eeg3))/std(eeg3));
%eeg3 = (eeg3.^2).^0.5;

waveeeg4 = dlmread('eegsignal5.txt',';');
eeg4 = waveeeg4(:,2);
eeg4 = eeg4(1000:4000);
%eeg4 = eeg4 + (-1 * min(eeg4));
%eeg4 = ((eeg4-mean(eeg4))/std(eeg4));
%eeg4 = (eeg4.^2).^0.5;

waveeeg5 = dlmread('eegsignal6.txt',';');
eeg5 = waveeeg5(:,2);
eeg5 = eeg5(1000:4000);
%eeg5 = eeg5 + (-1 * min(eeg5));
%eeg5 = ((eeg5-mean(eeg5))/std(eeg5));
%eeg5 = (eeg5.^2).^0.5;


energy = dlmread('sumenergy.txt',';');
energy = energy(:,2);
energy = energy(1000:4000);
%energy = energy + (-1 * min(energy));
%eeg5 = ((eeg5-mean(eeg5))/std(eeg5));
%eeg5 = (eeg5.^2).^0.5;


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

t8 = eeg2;
t8f = conv(t8,runavEEG);
t8f = t8f(halfSizeEEG+1:end-halfSizeEEG);

t9 = eeg3;
t9f = conv(t9,runavEEG);
t9f = t9f(halfSizeEEG+1:end-halfSizeEEG);

t10 = eeg4;
t10f = conv(t10,runavEEG);
t10f = t10f(halfSizeEEG+1:end-halfSizeEEG);

t11 = eeg5;
t11f = conv(t11,runavEEG);
t11f = t11f(halfSizeEEG+1:end-halfSizeEEG);



% find the peaks in the signal

% findpeaks.pm
% peak finder
% function P=findpeaks(x,y,SlopeThreshold,AmpThreshold,SmoothWidth,FitWidth,smoothtype)
% x=[0:.01:50];y=cos(x);findpeaks(x,y,0,-1,5,5)
% output: peak, position, size, width, area


%p0 = findpeaks(1:1:L, testplot0, -0.01, max(testplot0)/20, 3, 3, 1);
%p1 = findpeaks(1:1:L, testplot1, -0.01, max(testplot1)/20, 3, 3, 1);
%p2 = findpeaks(1:1:L, testplot2, -0.01, max(testplot2)/20, 3, 3, 1);
%%p3 = findpeaks(1:1:L, testplot3, -0.01, max(testplot3)/20, 3, 3, 1);
%p4 = findpeaks(1:1:L, testplot4, -0.01, max(testplot4)/20, 3, 3, 1);
%p5 = findpeaks(1:1:L, testplot5, -0.01, max(testplot5)/20, 3, 3, 1);
%p6 = findpeaks(1:1:L, eeg0, -0.01, max(eeg0)/20, 3, 3, 1);
%p7 = findpeaks(1:1:L, eeg1, -0.01, max(eeg1)/20, 3, 3, 1);

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
%{
testplot0 = testplot0 - min(testplot0);
testplot1 = testplot1 - min(testplot1);
testplot2 = testplot2 - min(testplot2);
testplot3 = testplot3 - min(testplot3);
testplot4 = testplot4 - min(testplot4);
testplot5 = testplot5 - min(testplot5);
eeg0 = eeg0 - min(eeg0);
eeg1 = eeg1 - min(eeg1);
%}

%{
testplot0 = testplot0(1:length(t0f)) - t0f;
testplot1 = testplot1(1:length(t1f)) - t1f;
testplot2 = testplot2(1:length(t2f)) - t2f;
testplot3 = testplot3(1:length(t3f)) - t3f;
testplot4 = testplot4(1:length(t4f)) - t4f;
testplot5 = testplot5(1:length(t5f)) - t5f;
eeg0 = eeg0(1:length(t6f)) -  t6f;
eeg1 = eeg1(1:length(t7f)) - t7f;
%}
%{
p0 = findpeaks(1:1:L, testplot0, mean(testplot0(testplot0>0))/100000000000, mean(testplot0(testplot0>0))/10000000000, 3, 3, 1);
p1 = findpeaks(1:1:L, testplot1, mean(testplot1(testplot1>0))/100000000000, mean(testplot1(testplot1>0))/10000000000, 3, 3, 1);
p2 = findpeaks(1:1:L, testplot2, mean(testplot2(testplot2>0))/100000000000, mean(testplot2(testplot2>0))/10000000000, 3, 3, 1);
p3 = findpeaks(1:1:L, testplot3, mean(testplot3(testplot3>0))/100000000000, mean(testplot3(testplot3>0))/10000000000, 3, 3, 1);
p4 = findpeaks(1:1:L, testplot4, mean(testplot4(testplot4>0))/100000000000, mean(testplot4(testplot4>0))/10000000000, 3, 3, 1);
p5 = findpeaks(1:1:L, testplot5, mean(testplot5(testplot5>0))/100000000000, mean(testplot5(testplot5>0))/10000000000, 3, 3, 1);
p6 = findpeaks(1:1:L, eeg0, mean(eeg0(eeg0>0))/100000000000, mean(eeg0(eeg0>0))/10000000000, 3, 3, 1);
p7 = findpeaks(1:1:L, eeg1, mean(eeg1(eeg1>0))/100000000000, mean(eeg1(eeg1>0))/10000000000, 3, 3, 1);
p8 = findpeaks(1:1:L, eeg2, mean(eeg2(eeg2>0))/100000000000, mean(eeg2(eeg2>0))/10000000000, 3, 3, 1);
p9 = findpeaks(1:1:L, eeg3, mean(eeg3(eeg3>0))/100000000000, mean(eeg3(eeg3>0))/10000000000, 3, 3, 1);
p10 = findpeaks(1:1:L, eeg4, mean(eeg4(eeg4>0))/100000000000, mean(eeg4(eeg4>0))/10000000000, 3, 3, 1);
p11 = findpeaks(1:1:L, eeg5, mean(eeg5(eeg5>0))/100000000000, mean(eeg5(eeg5>0))/10000000000, 3, 3, 1);
%}

%eeg5 = energy;

p0 = findpeaks(1:1:L, testplot0, 0, 0, 3, 3, 1);
p1 = findpeaks(1:1:L, testplot1, 0, 0, 3, 3, 1);
p2 = findpeaks(1:1:L, testplot2, 0, 0, 3, 3, 1);
p3 = findpeaks(1:1:L, testplot3, 0, 0, 3, 3, 1);
p4 = findpeaks(1:1:L, testplot4, 0, 0, 3, 3, 1);
p5 = findpeaks(1:1:L, testplot5, 0, 0, 3, 3, 1);
p6 = findpeaks(1:1:L, eeg0, 0, 0, 3, 3, 1);
p7 = findpeaks(1:1:L, eeg1, 0, 0, 3, 3, 1);
p8 = findpeaks(1:1:L, eeg2, 0, 0, 3, 3, 1);
p9 = findpeaks(1:1:L, eeg3, 0, 0, 3, 3, 1);
p10 = findpeaks(1:1:L, eeg4, 0, 0, 3, 3, 1);
p11 = findpeaks(1:1:L, eeg5, 0, 0, 3, 3, 1);




x0 = p0(:,2); y0 = p0(:,3);
x1 = p1(:,2); y1 = p1(:,3);
x2 = p2(:,2); y2 = p2(:,3);
x3 = p3(:,2); y3 = p3(:,3);
x4 = p4(:,2); y4 = p4(:,3);
x5 = p5(:,2); y5 = p5(:,3);
xe6 = p6(:,2); ye6 = p6(:,3);
xe7 = p7(:,2); ye7 = p7(:,3);
xe8 = p8(:,2); ye8 = p8(:,3);
xe9 = p9(:,2); ye9 = p9(:,3);
xe10 = p10(:,2); ye10 = p10(:,3);
xe11 = p11(:,2); ye11 = p11(:,3);


% normalize data - normalize peak size
% bsxfun(@rdivide, D, sum(D));
% bsxfun(@rdivide, D, mean(D));
y00 = bsxfun(@rdivide, y0,  mean(y0));
y11 = bsxfun(@rdivide, y1,  mean(y1));
y22 = bsxfun(@rdivide, y2,  mean(y2));
y33 = bsxfun(@rdivide, y3,  mean(y3));
y44 = bsxfun(@rdivide, y4,  mean(y4));
y55 = bsxfun(@rdivide, y5,  mean(y5));
ye66 = bsxfun(@rdivide, ye6,  mean(ye6));
ye77 = bsxfun(@rdivide, ye7,  mean(ye7));
ye88 = bsxfun(@rdivide, ye8,  mean(ye8));
ye99 = bsxfun(@rdivide, ye9,  mean(ye9));
ye1010 = bsxfun(@rdivide, ye10,  mean(ye10));
ye1111 = bsxfun(@rdivide, ye11,  mean(ye11));



% concat normalized vectors
%yAll = vertcat( y00, y11, y22, y33, y44, y55 );
yAll = vertcat( y0, y1, y2, y3, y4, y5 );
%yAll = y5;
%yAll = yAll(yAll>0);
%yAllEEG = vertcat( ye66, ye77, ye88, ye99, ye1010, ye1111 );
yAllEEG = vertcat( ye6, ye7, ye8, ye9, ye10, ye11 );
%yAllEEG = yAllEEG(yAllEEG>0);

yAll = sort(yAll);
yAllEEG = sort(yAllEEG);


% PDF || CDF : Probability Density Function || Cumulative Distribution Function
% use fixed or dynamic bins; calculate edges; consider number of all datapoints(n) and binwidth when estimating probability
binranges = 0:0.1:3;  %fixed binranges

numbins = 60;
n8 = length(yAll);
binwidth8 = range(yAll) / numbins;
edge8 = min(yAll):binwidth8:max(yAll);   %dynamic binranges(edges)

n9 = length(yAllEEG);
binwidth9 = range(yAllEEG) / numbins;
edge9 = min(yAllEEG):binwidth9:max(yAllEEG);

[bincounts8,ind8] = histc(yAll,edge8);
[bincounts9,ind9] = histc(yAllEEG,edge9);

% probability estimation
bincounts8 = bincounts8 ./ (n8*binwidth8);
bincounts9 = bincounts9 ./ (n9*binwidth9);

% histogram is smoothed with lowest window-size as possible, in order to get rid of zero(0) count-bins ( moving average )
window_size = 1;
%bincounts8 = tsmovavg(bincounts8,'s',window_size,1); bincounts8 = bincounts8(window_size:end,:);
%bincounts9 = tsmovavg(bincounts9,'s',window_size,1); bincounts9 = bincounts9(window_size:end,:);


%% fitting

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% lognfit for MEA and EEG

edge8pl = []; bincounts8pl = [];
[maxvalue,index] = max(bincounts8);
for i=1:length(edge8)
	%if (edge8(i) >= edge8(index))
	if (edge8(i) >= 0.1)
		edge8pl(end+1) = edge8(i);
		bincounts8pl(end+1) = bincounts8(i);
	end
end

edge9pl = []; bincounts9pl = [];
[maxvalue,index] = max(bincounts9);
for i=1:length(edge9)
	%if (edge9(i) >= edge9(index))
	if (edge9(i) >= 0.1)
		edge9pl(end+1) = edge9(i);
		bincounts9pl(end+1) = bincounts9(i);
	end
end	


edge8 = edge8pl;
edge9 = edge9pl;
bincounts8 = bincounts8pl;
bincounts9 = bincounts9pl;


[parmhat8,parmci8] = lognfit(yAll(yAll>0.1),0.5,[]);
mu8 = parmhat8(1);     %mean of lognormal
sigma8 = parmhat8(2);  %standard deviation of lognormal
mu8up = parmci8(1,1);
sigma8up = parmci8(1,2);
mu8low = parmci8(2,1);
sigma8low = parmci8(2,2);
[M8,V8]= lognstat(mu8,sigma8);
p8 = lognpdf(edge8(:,window_size:end),mu8,sigma8);
p8low = lognpdf(edge8(:,window_size:end),mu8up,sigma8up);
p8up = lognpdf(edge8(:,window_size:end),mu8low,sigma8low);
%fit8y = (1./(edge8.*sigma8.*(2*pi)^0.5)).*exp((-log(edge8-mu8).^2)/(2*sigma8^2));
fit8y = p8;
fit8ylow = p8low;
fit8yup = p8up;

[parmhat9,parmci9] = lognfit(yAllEEG(yAllEEG>0.1),0.5,[]);
mu9 = parmhat9(1);     %mean of lognormal
sigma9 = parmhat9(2);  %standard deviation of lognormal
mu9up = parmci9(1,1);
sigma9up = parmci9(1,2);
mu9low = parmci9(2,1);
sigma9low = parmci9(2,2);
[M9,V9]= lognstat(mu9,sigma9);
p9 = lognpdf(edge9(:,window_size:end),mu9,sigma9);
p9low = lognpdf(edge9(:,window_size:end),mu9up,sigma9up);
p9up = lognpdf(edge9(:,window_size:end),mu9low,sigma9low);
%fit9y = (1./(edge9.*sigma9.*(2*pi)^0.5)).*exp((-log(edge9-mu9).^2)/(2*sigma9^2));
fit9y = p9;
fit9ylow = p9low;
fit9yup = p9up;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% powerlaw fits for EEG and MEA



[slope8,intercept8] = logfit2(edge8(:,window_size:end)',bincounts8,'loglog');
[slope8pl,intercept8pl] = logfit2(edge8pl(:,window_size:end)',bincounts8pl,'loglog');
yApprox8 = (10^intercept8)*edge8.^(slope8);
yApprox8pl = (10^intercept8pl)*edge8pl.^(slope8pl);


[slope9,intercept9] = logfit2(edge9(:,window_size:end)',bincounts9,'loglog');
[slope9pl,intercept9pl] = logfit2(edge9pl(:,window_size:end)',bincounts9pl,'loglog');
yApprox9 = (10^intercept9)*edge9.^(slope9);
yApprox9pl = (10^intercept9pl)*edge9pl.^(slope9pl);

%% Plot avalanches - Powerlaw distribution and lognormal Distribuion


% Defaults for this blog post
width = 7;     % Width in inches
height = 3;    % Height in inches
alw = 2;     % AxesLineWidth
fsz = 10;      % Fontsize
lw = 2;      % LineWidth
msz = 8;       % MarkerSize




h1 = figure;

plot(edge8(:,window_size:end)',bincounts8,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'MarkerSize',msz)
hold all
plot(edge8(:,window_size:end),fit8y,'r','LineWidth',lw,'MarkerSize',msz)
hold all
plot(edge8pl(:,window_size:end),yApprox8pl(:,window_size:end),'--','color',[0 0 1],'LineWidth',lw,'MarkerSize',msz)


axis([0 max(edge8)*1.1 10^(-4) max(bincounts8)*1.1]);
set(gca,'XTick',[0:max(edge8)/5:max(edge8)*1.1]);
set(gca,'YTick',[0:max(bincounts8)/5:max(bincounts8)*1.1]);


title('Avalanche Distribution MEA All','FontSize',12,'FontWeight','bold','Fontname','Calibri')
legend('Original Data','logn fit','powerlaw fit','location','best','FontSize',fsz,'FontWeight','bold','Fontname','Calibri')
legend('boxoff')
xlabel('avalanche size (\muV)','FontSize',fsz,'FontWeight','bold','Fontname','Calibri')
ylabel('P(s)','FontSize',fsz,'FontWeight','bold','Fontname','Calibri')




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


print(h1,'-dpng','avalancheMEAAll.png','-r1000');





h2 = figure;

loglog(edge8(:,window_size:end)',bincounts8,'^','markerfacecolor',[1 1 1],'markeredgecolor',[1 0 0],'MarkerSize',msz)
hold all
loglog(edge8(:,window_size:end),fit8y,'r','LineWidth',lw,'MarkerSize',msz)
hold all
%loglog(edge8(:,window_size:end),fit8yup,'.-b')
%hold all
%loglog(edge8(:,window_size:end),fit8ylow,'.-g')
%hold all
loglog(edge8pl(:,window_size:end),yApprox8pl(:,window_size:end),'--','color',[0 0 1],'LineWidth',lw,'MarkerSize',msz)


axis([10^-1 10^3 10^(-4) 10^(0)]);
set(gca,'XTick',[10^-1 10^0 10^1 10^2 10^3 10^4 10^5]);
set(gca,'YTick',[10^(-6) 10^(-5) 10^(-4) 10^(-3) 10^(-2) 10^(-1) 10^(0)]);


title('Avalanche Distribution MEA All (loglog)','FontSize',12,'FontWeight','bold','Fontname','Calibri Light')
legend('Anesthesia','logn fit','powerlaw fit','location','southwest','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
legend('boxoff');
xlabel('avalanche size (\muV)','FontSize',fsz,'FontWeight','bold','Fontname','Calibri')
ylabel('P(s)','FontSize',fsz,'FontSize',fsz,'FontWeight','bold','Fontname','Calibri')

alpha8 = -slope8pl(1,1);
t1 = text(mean(edge8pl(:,window_size:(end-window_size)))/5+0,mean(yApprox8(:,(length(yApprox8)-length(edge8pl))+1:(end-window_size)))/5+0,['\alpha = ' num2str(alpha8)]);
set(t1,'FontSize',fsz,'FontWeight','bold','Fontname','Calibri');




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


print(h2,'-dpng','avalancheMEAAll (loglog).png','-r1000');





h3 = figure;

plot(edge9(:,window_size:end)',bincounts9,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'MarkerSize',msz)
hold all
plot(edge9(:,window_size:end),fit9y,'r','LineWidth',lw,'MarkerSize',msz)
hold all
plot(edge9pl(:,window_size:end),yApprox9pl(:,window_size:end),'--','color',[0 0 1],'LineWidth',lw,'MarkerSize',msz);


axis([0 max(edge9)*1.1 10^(-7) max(bincounts9)*1.1]);
set(gca,'XTick',[0:max(edge9)/5:max(edge9)*1.1]);
set(gca,'YTick',[0:max(bincounts9)/5:max(bincounts9)*1.1]);


title('Avalanche Distribution EEG All','FontSize',12,'FontWeight','bold','Fontname','Calibri');
legend('Original Data','logn fit','powerlaw fit','location','best','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
legend('boxoff');
xlabel('avalanche size (\muV)','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
ylabel('P(s)','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');




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


print(h3,'-dpng','avalancheEEGAll.png','-r1000');





h4 = figure;

loglog(edge9(:,window_size:end)',bincounts9,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'MarkerSize',msz);
hold all
loglog(edge9(:,window_size:end),fit9y,'r','LineWidth',lw,'MarkerSize',msz)
hold all
%loglog(edge9(:,window_size:end),fit9yup,'.-b')
%hold all
%loglog(edge9(:,window_size:end),fit9ylow,'.-g')
%hold all
loglog(edge9pl(:,window_size:end),yApprox9pl(:,window_size:end),'--','color',[0 0 1],'LineWidth',lw,'MarkerSize',msz);


axis([10^-1 10^4 10^(-4) 10^(0)]);
set(gca,'XTick',[10^-1 10^0 10^1 10^2 10^3 10^4 10^5]);
set(gca,'YTick',[10^(-6) 10^(-5) 10^(-4) 10^(-3) 10^(-2) 10^(-1) 10^(0)]);


title('Avalanche Distribution EEG All (loglog)','FontSize',12,'FontWeight','bold','Fontname','Calibri Light')
legend('Original Data','logn fit','powerlaw fit','location','southwest','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
legend('boxoff');
xlabel('avalanche size (\muV)','FontSize',fsz,'FontWeight','bold','Fontname','Calibri')
ylabel('P(s)','FontSize',fsz,'FontSize',fsz,'FontWeight','bold','Fontname','Calibri')

alpha9 = -slope9pl(1,1);
t1 = text(mean(edge9pl(:,window_size:(end-window_size)))/5+0,mean(yApprox9(:,(length(yApprox9)-length(edge9pl))+1:(end-window_size)))/5+0,['\alpha = ' num2str(alpha9)]);
set(t1,'FontSize',fsz,'FontWeight','bold','Fontname','Calibri');




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


print(h4,'-dpng','avalancheEEGAll (loglog).png','-r1000');





%{

%%qqplot()

h5 = figure;
q1 = qqplot(bincounts8',fit8y);
set(q1(1),'marker','^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0]);
set(q1(2),'linestyle','-','color',[1 0 0]);
set(q1(3),'linestyle','-.','color',[1 0 0]);
hold all
q2 = qqplot(fit8yup,fit8y);
set(q2(1),'marker','none','linestyle','none','color',[0 0 1]);
set(q2(2),'linestyle','none');
set(q2(3),'linestyle','none','color',[0 0 1]);
hold all
q3 = qqplot(fit8ylow,fit8y);
set(q3(1),'marker','none','linestyle','none','color',[0 1 0]);
set(q3(2),'linestyle','none');
set(q3(3),'linestyle','none','color',[0 1 0]);
%axis([0 1 0 1])
set(get(get(q1(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
legend('regression logn','data vs. logn fit','location','best');
legend('boxoff');
title('Q-Q-plot MEA All vs. Expected lognormal fit','FontWeight','bold')
xlabel('Data distribution quantiles')
ylabel('Expected lognormal fit quantiles')

	set(findall(gcf,'type','text'),'FontSize',12,'fontWeight','bold','Fontname','Calibri Light')
	set(gca, 'box', 'off')

print(h5,'-dpng','qq_plot_mea.png');


h6 = figure;
q4 = qqplot(bincounts9',fit9y);
set(q4(1),'marker','^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0]);
set(q4(2),'linestyle','-','color',[1 0 0]);
set(q4(3),'linestyle','-.','color',[1 0 0]);
hold all
q5 = qqplot(fit9yup,fit9y);
set(q5(1),'marker','none','linestyle','none','color',[0 0 1]);
set(q5(2),'linestyle','none');
set(q5(3),'linestyle','none','color',[0 0 1]);
hold all
q6 = qqplot(fit9ylow,fit9y);
set(q6(1),'marker','none','linestyle','none','color',[0 1 0]);
set(q6(2),'linestyle','none');
set(q6(3),'linestyle','none','color',[0 1 0]);
%axis([0 1 0 1])
set(get(get(q4(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
legend('regression logn','data vs. logn fit','location','best');
legend('boxoff');
title('Q-Q-plot EEG All vs. Expected lognormal fit','FontWeight','bold')
xlabel('Data distribution quantiles')
ylabel('Expected lognormal fit quantiles')

print(h6,'-dpng','qq_plot_eeg.png');


	set(findall(gcf,'type','text'),'FontSize',12,'fontWeight','bold','Fontname','Calibri Light')
	set(gca, 'box', 'off')

h7 = figure;

qP1 = qqplot(bincounts8',yApprox8(:,window_size:end));
set(qP1(1),'marker','^','markerfacecolor',[0 0 1],'markeredgecolor',[0 0 1]);
set(qP1(2),'linestyle','-','color',[0 0 1]);
set(qP1(3),'linestyle','-.','color',[0 0 1]);
set(get(get(qP1(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
%axis([0 1 0 1])
legend('regression powerlaw','data vs. powerlaw fit','location','best');
legend('boxoff');
title('Q-Q-plot MEA All vs. Expected powerlaw fit','FontWeight','bold')
xlabel('Data distribution quantiles')
ylabel('Expected powerlaw fit quantiles')


	set(findall(gcf,'type','text'),'FontSize',12,'fontWeight','bold','Fontname','Calibri Light')
	set(gca, 'box', 'off')

print(h7,'-dpng','qq_plot_mea2.png');


h8 = figure;

qP2 = qqplot(bincounts9',yApprox9(:,window_size:end));
set(qP2(1),'marker','^','markerfacecolor',[0 0 1],'markeredgecolor',[0 0 1]);
set(qP2(2),'linestyle','-','color',[0 0 1]);
set(qP2(3),'linestyle','-.','color',[0 0 1]);
set(get(get(qP2(2), 'Annotation'), 'LegendInformation'), 'IconDisplayStyle', 'off');
%axis([0 1 0 1])
legend('regression powerlaw','data vs. powerlaw fit','location','best');
legend('boxoff');
title('Q-Q-plot EEG All vs. Expected powerlaw fit','FontWeight','bold')
xlabel('Data distribution quantiles')
ylabel('Expected powerlaw fit quantiles')

	set(findall(gcf,'type','text'),'FontSize',12,'fontWeight','bold','Fontname','Calibri Light')
	set(gca, 'box', 'off')

print(h8,'-dpng','qq_plot_eeg2.png');


%% Signal example
%% Plot Original Output of NetLogo Simulation 
%% Signal is plotted and Peaks are marked
%% Running average is added






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% signal with peaks is shown here




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
%hold all
%plot(Fs*t,t0f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz)
hold all
plot(x0,y0,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz)


axis([2000 3000 min(testplot0(2000:3000))*1.8 max(testplot0(2000:3000))*1.8])
set(gca,'XTick',[0:100:15000])
set(gca,'YTick',[-55:5:55])
title('Signal  MEA 1','FontWeight','bold', 'FontSize',12,'Fontname','Calibri')
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (µV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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
%hold all
%plot(Fs*t,t1f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz)
hold all
plot(x1,y1,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz)


axis([2000 3000 min(testplot0(2000:3000))*1.8 max(testplot0(2000:3000))*1.8])
set(gca,'XTick',[0:100:15000])
set(gca,'YTick',[-55:5:55])
title('Signal  MEA 2','FontWeight','bold', 'FontSize',12,'Fontname','Calibri')
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (µV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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
%hold all
%plot(Fs*t,t2f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz)
hold all
plot(x2,y2,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz)


axis([2000 3000 min(testplot0(2000:3000))*1.8 max(testplot0(2000:3000))*1.8])
set(gca,'XTick',[0:100:15000])
set(gca,'YTick',[-55:5:55])
title('Signal  MEA 3','FontWeight','bold', 'FontSize',12,'Fontname','Calibri')
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (µV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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
%hold all
%plot(Fs*t,t3f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz)
hold all
plot(x3,y3,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz)


axis([2000 3000 min(testplot0(2000:3000))*1.8 max(testplot0(2000:3000))*1.8])
set(gca,'XTick',[0:100:15000])
set(gca,'YTick',[-55:5:55])
title('Signal  MEA 4','FontWeight','bold', 'FontSize',12,'Fontname','Calibri')
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (µV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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
%hold all
%plot(Fs*t,t4f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz)
hold all
plot(x4,y4,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz)


axis([2000 3000 min(testplot0(2000:3000))*1.8 max(testplot0(2000:3000))*1.8])
set(gca,'XTick',[0:100:15000])
set(gca,'YTick',[-55:5:55])
title('Signal  MEA 5','FontWeight','bold', 'FontSize',12,'Fontname','Calibri')
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (µV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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
%hold all
%plot(Fs*t,t5f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz)
hold all
plot(x5,y5,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz)


axis([2000 3000 min(testplot0(2000:3000))*1.8 max(testplot0(2000:3000))*1.8])
set(gca,'XTick',[0:100:15000])
set(gca,'YTick',[-55:5:55])
title('Signal  MEA 6','FontWeight','bold', 'FontSize',12,'Fontname','Calibri')
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (µV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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
%hold all;
%plot(Fs*t,t6f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz);
hold all;
plot(x6,y6,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz);


axis([2000 3000 min(eeg1(2000:3000))*1.8 max(eeg1(2000:3000))*1.8]);
set(gca,'XTick',[0:100:15000]);
set(gca,'YTick',[-5500:100:5500])
title('Signal EEG 1','FontWeight','bold','FontSize',12,'Fontname','Calibri');
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (µV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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



%}

h14 = figure;

plot(Fs*t,eeg5,'linewidth',2,'color',[0 0 0],'LineWidth',lw,'MarkerSize',msz);
%hold all;
%plot(Fs*t,t6f,'-r','linewidth',1,'LineWidth',lw,'MarkerSize',msz);
hold all;
plot(xe11,ye11,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'LineWidth',lw,'MarkerSize',msz);


%axis([2000 3000 min(eeg1(2000:3000))*1.8 max(eeg1(2000:3000))*1.8]);
%set(gca,'XTick',[0:100:15000]);
%set(gca,'YTick',[-5500:100:5500])
title('Signal EEG 2','FontWeight','bold','FontSize',12,'Fontname','Calibri');
legend ('Original Data','Moving average','location','northeast','FontSize',fsz,'FontWeight','bold','Fontname','Calibri');
legend('boxoff');


xlabel('Time (ms)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')
ylabel('Amplitude (µV)','FontSize', fsz, 'FontWeight','bold','Fontname','Calibri')


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
%}
