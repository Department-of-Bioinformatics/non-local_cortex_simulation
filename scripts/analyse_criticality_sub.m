%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% generate corrleation network from timeseries matrices of the netlogo simulaton 
%%%%% plot the distribution of the corrleation networks
%%%%% for this use script correlation_network_analysis
%%%%% save each distribution to a variable to combine the different distributions

%%%%% distributions are analyzed for different NI_slopev vlaues
%%%%% as follows:
%% 1.	0.1	order
%% 2.	0.4	near criticality
%% 3.	1.0	criticality
%% 4.	2.0	criticality
%% 5.	3.0	critcality
%% 6.	3.6	near criticality
%% 7.	3.8	chaos
%% p+ cutoff 0.07




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% order NI 0.1

%%correlation_network_analysis.m
xk1 = edge8(:,window_size:end)';
yk1 = bincounts8;

%%correlation_network_analysis.m
xk2 = edge8(:,window_size:end)';
yk2 = bincounts8;

%%correlation_network_analysis.m
xk3 = edge8(:,window_size:end)';
yk3 = bincounts8;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% criticality NI 1

%%correlation_network_analysis.m
xk4 = edge8(:,window_size:end)';
yk4 = bincounts8;

%%correlation_network_analysis.m
xk5 = edge8(:,window_size:end)';
yk5 = bincounts8;

%%correlation_network_analysis.m
xk6 = edge8(:,window_size:end)';
yk6 = bincounts8;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% criticality NI 3

%%correlation_network_analysis.m
xk7 = edge8(:,window_size:end)';
yk7 = bincounts8;

%%correlation_network_analysis.m
xk8 = edge8(:,window_size:end)';
yk8 = bincounts8;

%%correlation_network_analysis.m
xk9 = edge8(:,window_size:end)';
yk9 = bincounts8;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% chaosNI 3.8

%%correlation_network_analysis.m
xk10 = edge8(:,window_size:end)';
yk10 = bincounts8;

%%correlation_network_analysis.m
xk11 = edge8(:,window_size:end)';
yk11 = bincounts8;

%%correlation_network_analysis.m
xk12 = edge8(:,window_size:end)';
yk12 = bincounts8;




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% create the final figure
% Defaults for this blog post
width = 2.3622;     % Width in inches
height = 1.41732;    % Height in inches
alw = 1;     % AxesLineWidth
fsz = 8;      % Fontsize
lw = 1;      % LineWidth
msz = 6;       % MarkerSize


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

value_k =  figure;

loglog(xk1,yk1,'*','markerfacecolor',[0 1 0],'markeredgecolor',[0 1 0],'MarkerSize',msz);
hold all;
loglog(xk2,yk2,'*','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'MarkerSize',msz);
hold all;
loglog(xk3,yk3,'*','markerfacecolor',[0 0 0],'markeredgecolor',[0 0 0],'MarkerSize',msz);
hold all;

axis([1 4000 10^-5 1*10^-1])
set(gca,'XTick',[10^0 10^1 10^2 10^3 10^4 10^5]);
set(gca,'YTick',[10^(-5) 10^(-4) 10^(-3) 10^(-2) 10^(-1) 10^(0) 10^(1) 10^(2) 10^(3) 10^(4)]);

%xlabel('Avalanche size (µV)','FontWeight','normal','FontSize',fsz,'Fontname','arial')
%ylabel('Frequency','FontWeight','normal','FontSize',fsz,'Fontname','arial')
legend('model size ~ 30x30 columns','model size ~ 40x40 columns','model size ~ 50x50 columns''FontSize',8,'Fontname','arial')

% Determine the style
set(gca, 'FontSize', fsz, 'LineWidth', alw, 'FontWeight','normal','Fontname','arial'); %<- Set properties
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


print(value_k,'-dpng','value_k_loglog1.png','-r1000');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

value_k =  figure;
loglog(xk4,yk4,'*','markerfacecolor',[0 1 0],'markeredgecolor',[0 1 0],'MarkerSize',msz);
hold all;
loglog(xk5,yk5,'*','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'MarkerSize',msz);
hold all;
loglog(xk6,yk6,'*','markerfacecolor',[0 0 0],'markeredgecolor',[0 0 0],'MarkerSize',msz);
hold all;

axis([1 4000 10^-5 1*10^-1])
set(gca,'XTick',[10^0 10^1 10^2 10^3 10^4 10^5]);
set(gca,'YTick',[10^(-5) 10^(-4) 10^(-3) 10^(-2) 10^(-1) 10^(0) 10^(1) 10^(2) 10^(3) 10^(4)]);

%xlabel('Avalanche size (µV)','FontWeight','normal','FontSize',fsz,'Fontname','arial')
%ylabel('Frequency','FontWeight','normal','FontSize',fsz,'Fontname','arial')

% Determine the style
set(gca, 'FontSize', fsz, 'LineWidth', alw, 'FontWeight','normal','Fontname','arial'); %<- Set properties
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


print(value_k,'-dpng','value_k_loglog2.png','-r1000');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
value_k =  figure;

loglog(xk7,yk7,'*','markerfacecolor',[0 1 0],'markeredgecolor',[0 1 0],'MarkerSize',msz);
hold all;
loglog(xk8,yk8,'*','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'MarkerSize',msz);
hold all;
loglog(xk9,yk9,'*','markerfacecolor',[0 0 0],'markeredgecolor',[0 0 0],'MarkerSize',msz);
hold all;

axis([1 4000 10^-5 1*10^-1])
set(gca,'XTick',[10^0 10^1 10^2 10^3 10^4 10^5]);
set(gca,'YTick',[10^(-5) 10^(-4) 10^(-3) 10^(-2) 10^(-1) 10^(0) 10^(1) 10^(2) 10^(3) 10^(4)]);

%xlabel('Avalanche size (µV)','FontWeight','normal','FontSize',fsz,'Fontname','arial')
%ylabel('Frequency','FontWeight','normal','FontSize',fsz,'Fontname','arial')

% Determine the style
set(gca, 'FontSize', fsz, 'LineWidth', alw, 'FontWeight','normal','Fontname','arial'); %<- Set properties
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


print(value_k,'-dpng','value_k_loglog3.png','-r1000');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

value_k =  figure;
loglog(xk10,yk10,'*','markerfacecolor',[0 1 0],'markeredgecolor',[0 1 0],'MarkerSize',msz);
hold all;
loglog(xk11,yk11,'*','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'MarkerSize',msz);
hold all;
loglog(xk12,yk12,'*','markerfacecolor',[0 0 0],'markeredgecolor',[0 0 0],'MarkerSize',msz);
hold all;


axis([1 4000 10^-5 1*10^-1])
set(gca,'XTick',[10^0 10^1 10^2 10^3 10^4 10^5]);
set(gca,'YTick',[10^(-5) 10^(-4) 10^(-3) 10^(-2) 10^(-1) 10^(0) 10^(1) 10^(2) 10^(3) 10^(4)]);

%xlabel('Avalanche size (µV)','FontWeight','normal','FontSize',fsz,'Fontname','arial')
%ylabel('Frequency','FontWeight','normal','FontSize',fsz,'Fontname','arial')

% Determine the style
set(gca, 'FontSize', fsz, 'LineWidth', alw, 'FontWeight','normal','Fontname','arial'); %<- Set properties
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

print(value_k,'-dpng','value_k_loglog4.png','-r1000');