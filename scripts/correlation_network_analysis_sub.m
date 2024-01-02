%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% load time matrices from F:\Masterarbeit_BioWis\Netlogo\Output\correlation network to matab 
%% loading script correlation_network.m
%% or load the time matrices as matrix


%% analyse the correlation network



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% claculate correlations coefficients

%ising = isingt23(15000:20000,:);
corrdata = corrcoef(activationmatrixN38SOD1C1S50);


%% building a network matrix
corrnetwork = corrdata>0.07;


%% cont the number of neighbours
NormalCount = sum(corrdata>0.07);

%% plot the distribution
figure;
hist(NormalCount,80);


y0 = NormalCount;
%% plot 
%y00 = bsxfun(@rdivide, y0,  mean(y0));
y00 = y0;
yAll = sort(y00);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PDF || CDF : Probability Density Function || Cumulative Distribution Function
%% use fixed or dynamic bins; calculate edges; consider number of all datapoints(n) and binwidth when estimating probability

%binranges = 0:1:100;  %fixed binranges

numbins = 120;
n8 = length(yAll);
binwidth8 = range(yAll) / numbins;
edge8 = min(yAll):binwidth8:max(yAll);   %dynamic binranges(edges)

[bincounts8,ind8] = histc(yAll,edge8);

% probability estimation
bincounts8 = bincounts8 ./ (n8*binwidth8);

% Defaults for this blog post
width = 7;     % Width in inches
height = 3;    % Height in inches
alw = 2;     % AxesLineWidth
fsz = 10;      % Fontsize
lw = 2;      % LineWidth
msz = 2;       % MarkerSize


window_size = 1;


h1 = figure;

plot(edge8(:,window_size:end)',bincounts8,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'MarkerSize',2)

h2 = figure;

loglog(edge8(:,window_size:end)',bincounts8,'^','markerfacecolor',[1 1 1],'markeredgecolor',[1 0 0],'MarkerSize',msz)
xlim([1 5000])