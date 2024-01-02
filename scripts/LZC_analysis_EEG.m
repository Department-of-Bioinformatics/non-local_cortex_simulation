%%%% Input eegsingal
perl('parserwavepattern.pl');
waveeeg0 = dlmread('eegsignal4.txt',';');
%waveeeg0 = dlmread('wavepattern00.txt',';');
%waveeeg0 = dlmread('0-15_IN0.txt',';');
eeg0 = waveeeg0(1000:9000,2);
%eeg0 = eeg0.*(-1);
%eeg00=round(eeg0);
%eeg0 = eeg0 + abs(min(eeg0));
eeg1 = eeg0 > median(eeg0);
x = eeg1';
x = double(x);

%{
%%%% Input Presence
perl('parserwavepattern_matrix.pl');
wmatrix = dlmread('matrix.csv','\t');
wmatrix = wmatrix(:,1:100);
%wmatrix = wmatrix.^2;
wmatrix = wmatrix > median(wmatrix,'all');
x = double(wmatrix);
%}



disp('==================================');
disp('lempel-ziv input sequence is created');
strInput = strrep((mat2str(x)),' ','');
strInput = strrep(strInput,'[','');
strInput =  strrep(strInput,']','');
strInput =  strrep(strInput,';','');
disp('mat2str completed');
%%
codeBook = cellstr(['0';'1']);
%% lempel-ziv calculation

[value codeBook NumRep NumRepBin ] = lempelzivEnc(strInput,codeBook);

%%

outputLength = length( NumRepBin{1})*length(NumRepBin)-length(NumRepBin);
inputLength = length(strInput);
compRatio = outputLength/inputLength*100;
str = sprintf('========================\nInput length is %d and output length is %d\nCompression ratio is %f',inputLength,outputLength,compRatio);

disp(str);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Auswertung Netlogo Simulation

% Values measured with EEG radius of 5mm
% waking, sws_sleep, rem_sleep, A.D., Schizo, Anethesia

simulated_complexity = [74.928134, 75.753031, 79.877515, 78.090239, 78.227722, 76.990376;
32.620922, 28.346457, 32.245969, 28.008999, 27.671541, 28.233971; 
38.120235, 37.120360, 38.245219, 37.245344, 36.245469, 38.620172;
89.088864, 60.367454, 84.139483, 85.239345, 62.742157, 82.902137;
52.243470, 54.368204, 54.743157, 53.993251, 51.243595, 53.243345;
45.369329, 49.993751, 45.744282, 45.244344, 46.994126, 45.869266];



% Values measured with EEG radius of 10mm
waking = [54.618173, 53.868266, 54.493188, 55.368079, 55.368079, 53.368329];
sws_sleep = [26.884139, 25.984252, 28.121485, 27.221597, 28.346457, 26.434196];
rem_sleep = [36.745407, 35.620547, 35.120610, 35.370579, 34.370704, 37.745282];
Alzheimer0_1 = [59.367579, 56.617923, 54.493188, 42.994626, 47.744032, 52.368454];
Alzheimer1 = [56.617923, 62.867142, 80.427447, 81.389826, 57.617798, 63.367079];
Schizo = [47.994001, 48.243970, 46.119235, 46.869141, 48.243970, 45.494313];
Ketamin = [49.868766, 43.744532, 53.368329, 52.743407, 47.619048, 55.368079];
Propofol = [28.121485, 24.746907, 22.609674, 23.397075, 21.822272, 23.509561];



simulated_complexity = [54.618173, 53.868266, 54.493188, 55.368079, 55.368079, 53.368329;
26.884139, 25.984252, 28.121485, 27.221597, 28.346457, 26.434196;
36.745407, 35.620547, 35.120610, 35.370579, 34.370704, 37.745282;
59.367579, 56.617923, 54.493188, 42.994626, 47.744032, 52.368454;
56.617923, 62.867142, 80.427447, 81.389826, 57.617798, 63.367079;
47.994001, 48.243970, 46.119235, 46.869141, 48.243970, 45.494313;
49.868766, 43.744532, 53.368329, 52.743407, 47.619048, 55.368079;
28.121485, 24.746907, 22.609674, 23.397075, 21.822272, 23.509561];






% Defaults for this blog post
width = 2.3622;     % Width in inches
height = 1.41732;    % Height in inches
alw = 1;     % AxesLineWidth
fsz = 10;      % Fontsize
lw = 1;      % LineWidth
msz = 6;       % MarkerSize


%%%%%%%%%%%%%%% display data
h1 = figure; 
mean_sc = median(simulated_complexity');
errors_sc = std(simulated_complexity');
errors_low = quantile(simulated_complexity',0.15);
errors_up = quantile(simulated_complexity',0.85);
size_sc = 1:size(simulated_complexity',2);
bar(size_sc,mean_sc,'FaceColor',[0 0 1],'EdgeColor',[0 0 1]);
hold on; 
%h2 = errorbar(size_sc,mean_sc, errors_sc);
h2 = errorbar(size_sc,mean_sc, errors_low-mean_sc,errors_up-mean_sc);


ylim([0 90])
%xticklabels({'waking','SWS','REM','A.D.0.1','A.D.1.0', 'Schizo','Ketamin','Propofol'})
%xtickangle(10)
set(gca,'YTick',[0:20:100]);

set(h2,'linestyle','none'); 
set(gca,'XColor',[0 0 0]);
set(gca,'YColor',[0 0 0]);
xticklabels({})
yticklabels({})

%%%%%%%%%%%%%% style

%title('Lempel Ziv Complexity of simulated EEG','FontSize',14,'FontWeight','bold','Fontname','arial Light')
%xlabel('brain states','FontSize',fsz,'FontWeight','bold','Fontname','arial')
%ylabel('LZC','FontSize',fsz,'FontSize',fsz,'FontWeight','bold','Fontname','arial')


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


% Determine the style
set(gca,'FontSize',fsz,'LineWidth',alw,'FontWeight','normal','Fontname','Arial'); %<- Set properties
set(gca,'box','off');
set(gcf,'color','w');   %background of figure is white when printing.
set(gca,'color','w');
set(gca,'TickDir','out'); % The only other option is 'in'
%set(gcf,'InvertHardcopy','on');   %background of figure is white when printing independet of current color



print(h1,'-dpng','LZC_EEG_v2.png','-r1500');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Auswertung VEPOR Data


