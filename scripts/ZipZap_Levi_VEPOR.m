%%%% Input eegsingal
perl('parserwavepattern.pl');
%waveeeg0 = dlmread('eegsignal2.txt',';');
%waveeeg0 = dlmread('wavepattern05.txt',';');
waveeeg0 = dlmread('45-60_IN0.txt',';');
eeg0 = waveeeg0(500000:600000,2);
eeg0 = eeg0.*(-1);
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

baseline = [90.983434, 90.369096, 86.631134, 91.265087, 89.935101, 90.467095];
0_15_IN0 = [92.383418, 88.171118, 91.727083, 90.705093, 87.919121, 90.397096];
15_30_IN0 = [48.648348, 49.685503, 48.255517, 46.695533, 48.970510, 47.787522];
30_45_IN0 = [33.164076, 34.748653, 33.929661, 33.994660, 35.944641, 34.722653];
45_60_IN0 = [32.745192, 31.771682, 31.381686, 30.731693, 31.069689, 31.992680];




simulated_complexity = [90.983434, 90.369096, 86.631134, 91.265087, 89.935101, 90.467095;
92.383418, 88.171118, 91.727083, 90.705093, 87.919121, 90.397096;
48.648348, 49.685503, 48.255517, 46.695533, 48.970510, 47.787522;
33.164076, 34.748653, 33.929661, 33.994660, 35.944641, 34.722653;
32.745192, 31.771682, 31.381686, 30.731693, 31.069689, 31.992680];


%%%%%%%%%%%%%%% For figure build
% Defaults for this blog post
width = 7;     % Width in inches
height = 3;    % Height in inches
alw = 2;     % AxesLineWidth
fsz = 12;      % Fontsize
lw = 2;      % LineWidth
msz = 2;       % MarkerSize



%%%%%%%%%%%%%%% display data
h1 = figure; 
mean_sc = mean(simulated_complexity');
errors_sc = std(simulated_complexity');
size_sc = 1:size(simulated_complexity',2);
bar(size_sc,mean_sc);
hold on; 
h2 = errorbar(size_sc,mean_sc, errors_sc);

xticklabels({'baseline','0-15','15-30','30-45','45-60'})
xtickangle(10)
set(h2,'linestyle','none'); 


%%%%%%%%%%%%%% style

title('Level Ziv Complexity of simulated VEPOR','FontSize',14,'FontWeight','bold','Fontname','Calibri Light')
xlabel('brain states','FontSize',fsz,'FontWeight','bold','Fontname','Calibri')
ylabel('LVC','FontSize',fsz,'FontSize',fsz,'FontWeight','bold','Fontname','Calibri')


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


print(h1,'-dpng','LZC_VEPOR.png','-r1000');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% Auswertung VEPOR Data


