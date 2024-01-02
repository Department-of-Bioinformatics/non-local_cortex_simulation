%% The corrlation of wavespeed and maximal frequncy is shown here
%% Data are manually recorded and collected in the file wavespeed.txt

% Location: I:\Masterarbeit_BioWis\Netlogo\Output\wavespeed

NI = [ 0.01 0.2 0.5 1.2 2.0 2.5 3.0 ]
hz = [ 15 85 140 235 325 415 500 ]
speed = [ 0.025 0.13 0.22 0.34 0.45 0.49 0.53 ]

NI2 = [ 0.01 0.2 0.5 1.2 2.0 ]
hz2 = [ 15 85 140 235 325 ]
speed2 = [ 0.025 0.13 0.22 0.34 0.45]


%hz = NI; 
%hz2 = NI2; 

% Defaults for this blog post
width = 2.3622;     % Width in inches
height = 1.41732;    % Height in inches
alw = 1;     % AxesLineWidth
fsz = 6;      % Fontsize
lw = 1;      % LineWidth
msz = 6;       % MarkerSize




% fit the data point
P = polyfit(NI,hz,1);
yfit = P(1)*NI+P(2);

Rsq1 = 1 - sum((hz - yfit).^2)/sum((hz - mean(hz)).^2);

% fit the data point of low frequencies
P2 = polyfit(NI2,hz2,1);
yfit2 = P2(1)*NI2+P2(2);

Rsq12 = 1 - sum((hz2 - yfit2).^2)/sum((hz2 - mean(hz2)).^2);


% Plot the data

h1 = figure;

plot(NI, hz, '^','markerfacecolor',[0 0 0],'markeredgecolor',[0 0 0],'MarkerSize',msz);
hold on;
plot(NI,yfit,'r-','LineWidth', alw);
hold on;
%plot(NI2,yfit2,'b-','LineWidth', alw);

% adjust figure properties

%xlabel('NI\_slopev','FontSize', 6,'FontWeight','normal','Fontname','arial');
%ylabel('frequency (Hz)','FontSize', 6,'FontWeight','normal','Fontname','arial');

axis([0 3.1 0 500])
set(gca,'XTick',[0:1:3.1]);
set(gca,'YTick',[0:200:500]);

%ll = legend('Original Data','linear fit all','linear fit <400 Hz');
ll = legend('data','linear fit all');
set(ll,'FontSize',fsz);
set(ll,'FontWeight','normal');
set(ll,'Fontname','arial');
legend('Location','southeast');
legend('boxoff');

%t1 = text(35,0.35,['Rsq = ' num2str(roundn(Rsq1,-4))]);
%t2 = text(35,0.45,['Frequency = ' num2str(roundn(P(1),-4)) ' * NI_slopev + ' num2str(roundn(P(2),-4)) ]);
t3 = text(0.1,430,['rsq = ' num2str(roundn(Rsq1,-3))],'FontSize', fsz);
t4 = text(0.1,480,['frequency = ' num2str(roundn(P(1),-3)) ' * NI\_slopev + ' num2str(roundn(P(2),-3)) ],'FontSize', fsz);
%t3 = text(35,0.55,['Rsq = ' num2str(roundn(Rsq12,-4))]);
%t4 = text(35,0.65,['Frequency = ' num2str(roundn(P2(1),-4)) ' * NI_slopev + ' num2str(roundn(P2(2),-4)) ]);


%set(t1,'FontWeight','normal','FontSize',6,'Fontname','arial','color','red');
%set(t2,'FontWeight','normal','FontSize',6,'Fontname','arial','color','red');
%set(t3,'FontWeight','normal','FontSize',6,'Fontname','arial','color','blue');
%set(t4,'FontWeight','normal','FontSize',6,'Fontname','arial','color','blue');


% Determine the style
set(gca, 'FontSize', 10, 'LineWidth', alw, 'FontWeight','normal','Fontname','arial'); %<- Set properties
set(gca, 'box', 'off');
set(gcf,'color','w');   %background of figure is white when printing.
set(gcf,'InvertHardcopy','on');   %background of figure is white when printing independet of current color
%set(findall(gcf,'type','text'),'FontSize',8,'FontWeight','normal','Fontname','arial');

% Here we preserve the size of the image when we save it.
set(gca,'TickDir','out'); % The only other option is 'in'
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

print(h1,'-dpng','wavespeed_frequency_NI_vs_frequency.png','-r1000');

