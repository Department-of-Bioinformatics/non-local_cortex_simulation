function PS=peakstats(x,y,SlopeThreshold,AmpThreshold,smoothwidth,peakgroup,smoothtype,displayit,EEG,signal_length)
% function
% PS=peakstats(x,y,SlopeThreshold,AmpThreshold,smoothwidth,peakgroup,
% smoothtype,displayit). Function to locate the positive peaks in a noisy
% x-y time series data set and compute a table of summary statistics of the
% peak intervals (the x-axis interval between adjacent detected peaks),
% heights, widths, and areas, listing the maximum, minimum, average, and
% percent standard deviation, and optionally displaying the x,t data plot
% with numbered peaks and the histograms of the peak intervals, heights,
% widths, and areas in figure window 2. Detects peaks by looking for
% downward zero-crossings in the first derivative that exceed
% SlopeThreshold. Returns peak statistics (PS) containing of the maximumn,
% minimum, mean, and percent standard deviation of the peak intervals,
% heights, widths, in a matrix. Arguments "slopeThreshold", "ampThreshold"
% and "smoothwidth" control peak sensitivity. Higher values will neglect
% smaller features. "Smoothwidth" is the width of the smooth applied before
% peak detection; larger values ignore narrow peaks. If smoothwidth=1, no
% smoothing is performed. "Peakgroup" is the number points around the top
% part of the peak that are taken for measurement. If Peakgroup=0 the local
% maximum is takes as the peak height and position.
% The optional argument "smoothtype" determines the smooth algorithm:
%   If smoothtype=1, rectangular (sliding-average or boxcar) If
%   smoothtype=2, triangular (2 passes of sliding-average) If smoothtype=3,
%   pseudo-Gaussian (3 passes of sliding-average)
% The optional last argument "displayit" =1 if the x,y data plot, numbered
% peaks, and peak statistics table and the histogtams are to be displayed,
% othersize not.
% See http://terpconnect.umd.edu/~toh/spectrum/Smoothing.html and
% http://terpconnect.umd.edu/~toh/spectrum/PeakFindingandMeasurement.htm
% T. C. O'Haver, 2013.  Version 1. Last revised May, 2013
%
% Examples:
% x=[0:.1:100];y=5+5.*cos(x)+randn(size(x));peakstats(x,y,0,-1,11,19,3,1);
% As above, but no display, and statistics table returned in matrix PS:
% x=[0:.01:5]';PS=peakstats(x,x.*sin(x.^2).^2,0,-1,5,5);
% x=[0:.1:100];y=5+5.*cos(x)+randn(size(x));PS=peakstats(x,y,0,-1,11,19,3);
% x=[0:.01:5]';peakstats(x',x.*sin(x.^2).^2,0,-1,5,5,1,1) display
% statistics table and histogram plots
%
% Related functions:
% findvalleys.m, findpeaksL.m, findpeaksb.m, findpeaksplot.m, findpeaks.m,
% findpeaksnr.m, findpeaksGSS.m, findpeaksLSS.m, findpeaksfit.m.

if nargin==6;smoothtype=1;displayit=0;end % smoothtype=1, displayit=0 if not specified in 7th argument
if nargin==7;displayit=0;end  % displayit=0 if not specified in 8th argument
if smoothtype>3;smoothtype=3;end
if smoothtype<1;smoothtype=1;end
smoothwidth=round(smoothwidth);
peakgroup=round(peakgroup);
if smoothwidth>1,
	d=fastsmooth(deriv(y),smoothwidth,smoothtype);
	%sgf=sgolayfilt(dr,3,5);
else
    d=deriv(y);
end
n=round(peakgroup/2+1);
P=[0 0 0 0 0];
vectorlength=length(y);
peak=1;
AmpTest=AmpThreshold;
for j=2*round(smoothwidth/2)-1:length(y)-smoothwidth,
    if sign(d(j)) > sign(d(j+1)), % Detects zero-crossing
        if (d(j)-d(j+1)) > SlopeThreshold*y(j), % if slope of derivative is larger than SlopeThreshold
            if y(j) > AmpTest,  % if height of peak is larger than AmpThreshold
                xx=zeros(size(peakgroup));yy=zeros(size(peakgroup));
                for k=1:peakgroup, % Create sub-group of points near peak
                    groupindex=j+k-n+2;
                    if groupindex<1, groupindex=1;end
                    if groupindex>vectorlength, groupindex=vectorlength;end
                    xx(k)=x(groupindex);yy(k)=y(groupindex);
                end
                if peakgroup>3,
                    [coef,S,MU]=polyfit(xx,log(abs(yy)),2);  % Fit parabola to log10 of sub-group with centering and scaling
                    c1=coef(3);c2=coef(2);c3=coef(1);
                    PeakX=-((MU(2).*c2/(2*c3))-MU(1));   % Compute peak position and height of fitted parabola
                    PeakY=exp(c1-c3*(c2/(2*c3))^2);
                    MeasuredWidth=norm(MU(2).*2.35482/(sqrt(2)*sqrt(-1*c3)));
                    % if the peak is too narrow for least-squares technique to work
                    % well, just use the max value of y in the sub-group of points near peak.
                else
                    PeakY=max(yy);
                    pindex=val2ind(yy,PeakY);
                    PeakX=xx(pindex(1));
                    MeasuredWidth=0;
                end
                % Construct matrix P. One row for each peak
                % detected, containing the peak number, peak
                % position (x-value) and peak height (y-value).
                % If peak measurements fails and results in NaN, skip this
                % peak
                if isnan(PeakX) || isnan(PeakY) || PeakY<AmpThreshold,
                    % Skip this peak
                else % Otherwiase count this as a valid peak
                    P(peak,:) = [round(peak) PeakX PeakY MeasuredWidth  1.0646.*PeakY*MeasuredWidth];
                    peak=peak+1; % Move on to next peak
                end
            end
        end
    end
end
PP=P;

%% Deutsch :: Kommentar Johannes Balkenhol
%% hier das problem der wenigen peaks , weil differenzen gebildet werden sollen
%% da braucht es vlt eine if schleife ( nur wenn mehr als 5 peaks enthalten sind dann ... print statistiks

%  "diff" is the vector of x-axis intervals between peaks.
%% Hier entsteht ein problem wenn es nur einen peak gibt
%% hier lag ein fehler vor weil length(PP) nicht die gesuchte länge war ( Matlab scheinst wohl die längsten werte zu nehmen row, column )
diff=zeros(size(1:length(PP(:,1))));
if (length(PP(:,1)) > 1),
	for n=1:length(PP(:,1))-1;
		diff(n)=max(PP(n+1,2)-PP(n,2));
	end
end

PS=zeros(4,4);
%% prepare output of function
PS(1,:)=[max(diff);max(PP(:,3));max(PP(:,4));max(PP(:,5))];
PS(2,:)=[min(diff);min(PP(:,3));min(PP(:,4));min(PP(:,5))];
PS(3,:)=[mean(diff);mean(PP(:,3));mean(PP(:,4));mean(PP(:,5))];
PS(4,:)=[100.*std(diff)./mean(diff);100.*std(PP(:,3))./mean(PP(:,3));100.*std(PP(:,4))./mean(PP(:,4));100.*std(PP(:,5))./mean(PP(:,5))];

if displayit,
	h1 = figure;
	plot(x,y,'color',[0 0 0])
	
	PP2r = round(PP(:,2)*100)/100;		%%peak rounded x values
	PP3r = round(PP(:,3)*100)/100;		%%peak rounded y values
	
	% diese Signal listen bieten nur eine Hilfe. Das sind die im Modell zur Verfügung stehenden Frequenzen
	signals_hz =       [ 0.25, 0.5, 0.75, 1, 2, 3 , 5, 7, 11, 13, 17,   19,   23,   29,   31,   37, 41,   43,   47,   53,   59,   61,   67,   71,   73,   79,   83,   89,   97,  101, 103, 107,   109,   113,   127, 131, 137,   139,   149,    151,   157,  163,  167,   173,   179,   181,   191,   193,   197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293,   307,   311,   313,   317,   331,   337,   347,   349,   353,   359,   367,   373,   379,   383,   389,   397,   401, 409 ];
	signals_hz_model = [ 0.25, 0.5, 0.75, 1, 2, 3 , 5, 7, 11, 13, 16.9, 18.9, 23.3, 29.4, 31.3, 37, 41.7, 43.5, 47.6, 52.6, 58.8, 62.5, 66.7, 71.4, 71.4, 76.9, 83.3, 90.9, 100, 100, 100, 111.1, 111.1, 111.1, 125, 125, 142.9, 142.9, 142.9,  142.9, 166.7,166.7,166.7, 166.7, 166.7, 166.7, 200,   200,   200, 200, 200, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 250, 333.3, 333.3, 333.3, 333.3, 333.3, 333.3, 333.3, 333.3, 333.3, 333.3, 333.3, 333.3, 333.3, 333.3, 333.3, 333.3, 333.3, 500, 500 ];
	prime_period =    [ 5,   7,     11,   13,   17,   19,   23,   29,   31,   37, 41,   43,   47,   53,   59,   61,   67,   71,   73,   79,   83, 89,   97,   101, 103,  107, 109, 113, 127, 131, 137, 139 ];
	prime_period2hz = [ 250, 142.9, 90.9, 76.9, 58.8, 52.6, 43.5, 34.5, 32.3, 27, 24.4, 23.3, 21.3, 18.9, 16.9, 16.4, 14.9, 14.1, 13,7, 12.7, 12, 11.2, 10.3, 9.9, 9.7,  9.3, 9.2, 8.8, 7.9, 7.6, 7.3, 7.2 ];
	maximum_signals_prime = [ 5, 7, 11, 13, 16.9, 18.9, 23.3, 29.4, 31.3, 37, 41.7, 43.5, 47.6, 52.6, 58.8, 62.5, 66.7, 71.4, 76.9, 83.3, 90.9, 100, 111.1, 125, 142.9, 166.7, 200, 250, 333.3, 500];
	maximum_signals = [ 5, 7, 11, 13, 16.9, 18.9, 23.3, 29.4, 30, 31.3, 37, 40, 41.7, 43.5, 47.6, 50, 52.6, 58.8, 60, 62.5, 66.7, 70, 71.4, 76.9, 83.3, 90.9, 100, 111.1, 125, 142.9, 166.7, 200, 250, 333.3, 500];
	% hier sind die Signale aufgelistet die tatsächlich bei dem model run verwendet wurden, damit sie diese im Plot graphisch dargestellt werden können
	signals_used = [ 29.4, 31.3, 37, 41.7, 47.6, 52.6, 62.5, 66.7, 71.4, 76.9, 83.3, 90.9 ];
	signals_used = [ 13, 16.9, 18.9, 23.3, 29.4, 31.3, 37, 41.7, 43.5, 47.6, 52.6, 58.8 ];
	signals_used = [ 13, 18.9, 23.3, 29.4, 31.3, 37, 41.7, 43.5, 47.6, 52.6, 58.8, 62.5 ];
	signals_used = [ 13, 16.9, 18.9, 23.3, 29.4, 31.3, 37, 41.7, 43.5, 47.6, 52.6, 58.8, 62.5 ];
	signals_used = prime_period2hz;
	signals_used = maximum_signals;
	signals_used = [ 5, 7, 11, 13, 17,   19,   23,   29,   31,   37, 41,   43,   47,   53,   59,   61,   67,   71,   73,   79,   83,   89,   97,  101, 103, 107,   109,   113,   127, 131, 137,   139,   149,    151,   157,  163,  167,   173,   179,   181,   191,   193,   197, 199, 211, 223, 227, 229, 233, 239 ];
	signals_used28 = [ 5, 7, 11, 13, 16.9, 18.9, 23.3, 29.4, 31.3, 37, 41.7, 43.5, 47.6, 52.6, 58.8, 62.5, 66.7, 71.4,       76.9, 83.3, 90.9,      100,             111.1,             125,        142.9,                      166.7,                                   200,                                      250 ];
	signals_used = [       11, 13, 16.9, 18.9, 23.3, 29.4, 31.3, 37, 41.7, 43.5, 47.6, 52.6, 58.8, 62.5, 66.7, 71.4,       76.9, 83.3, 90.9,      100,             111.1,             125,        142.9,                      166.7                                         ];
	signals_used = [           13, 16.9,       23.3, 29.4, 31.3, 37, 40  , 43.5, 47.6, 52.6, 58.8, 62.5 ];
	signals_used = [ 5, 7, 11, 13, 16.9, 18.9, 23.3, 29.4, 31.3, 37, 41.7, 43.5, 47.6, 52.6, 58.8, 62.5, 66.7, 71.4,       76.9, 83.3, 90.9,      100,             111.1,             125,        142.9,                      166.7,                                   200,                                      250 ];
	signals_disease = [ 7, 8, 9, 10, 11, 12, 13, 14,   15,  16,   17,   18,   19,    20,   21,   23,   25, 27,    29,   31,   33,   35,   37, 39,   41,   43,   45,   47,   49, 51, ];
	signals_used =  [ 7, 8, 9, 10, 11, 12, 13, 14.1, 14.9, 15.9,  16.9, 17.8, 18.9,  20,   20.8, 23.3, 25, 27,    29.4, 31.3, 33.3, 34.5, 37, 38.4, 41.7, 43.5, 45.5, 47.6, 50 ];
	%              [ 0.5 2 4 6 8 10 12 14   16   18   20 22   24 26   28   30   32   34   36   38   40 42    44   46   48   50 ];
	signals_used = [ 0.5 2 4 6 8 10 12 14.1 15.9 17.8 20 22.2 24 26.3 27.7 30.3 32.3 34.5 35.7 38.5 40 41.6  43.5 45.5 47.6 50 ];
	signals_used = [ 0.5 1 3 6 7 8 9 10 11 12 13 14.1 14.9 ];
	%signals_used = [ 13, 16.9, 23.3, 29.4, 31.3, 37, 41.7, 43.5, 47.6, 52.6, 58.8, 62.5 ];
	signals_used = [ 5, 5.2, 5.5, 10, 10.5, 150, 150.2, 150.5, 200, 200.5, 400, 400.2, 450.5];
	signals_used = signals_used28;
	signals_used = [ 5, 7, 11, 13, 17,   19,   23,   29,   31,   37, 41,   43,   47,   53,   59,   61,   67,   71,   73,   79,   83,   89,   97,  101, 103, 107,   109,   113,   127, 131, 137,   139,   149,    151,   157,  163,  167,   173,   179,   181,   191,   193,   197, 199, 211, 223, 227, 229, 233, 239 ];
	signals_used = [ 10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60 ];
	signals_used = [ 2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,157,163,167,173,179,181,191,193,197,199,211,223,227,229,233,239,241,251,257,263,269,271,277,281,283,293,307,311,313,317,331,337,347,349,353,359,367,373,379,383,389,397,401,409,419,421,431,433,439,443,449,457,461,463,467,479,487,491,499 ];
	
	% hier werden die signal matches, obertöne und mismatches bestimmt ( untertöne noch nicht mit einbezogen )
	PP2rm = []; PP2rf = []; PP3rm = []; PP3rf = []; PP2mx = []; PP3my = []; PP2fx = []; PP3fy = []; PP2rob = []; PP2robb = []; PP2obx = []; PP3oby = [];
	% permitted deviation of matches
	dev = 0.5;
	for i=1:length(PP2r)
		for ii=1:length(signals_used)	%%% ckecks for frequency matches
			if ((PP2r(i) > (signals_used(ii) - dev)) && (PP2r(i) < (signals_used(ii) + dev)) && PP2r(i) <= 500 && PP2r(i) ~= 0)
				if (~ismember(PP2r(i),PP2rm))
					PP2rm(end+1) = PP2r(i);
					PP3rm(end+1) = PP3r(i);
					PP2mx(end+1) = PP(i,2);
					PP3my(end+1) = PP(i,3);
				end
			end
		end
		for ii=1:length(signals_used)	%%% checks for overtones
			if ( (modulo(PP(i,2), signals_used(ii)) == 0 | modulo(PP(i,2), signals_used(ii)) >= -dev &&  modulo(PP(i,2), signals_used(ii)) <= dev) && PP2r(i) <= 500 && PP2r(i) ~= 0)
				if (~ismember(PP2r(i),PP2rm) && ~ismember(PP2r(i),PP2rob))
					PP2rob(end+1) = PP2r(i);
					PP2robb(end+1) = signals_used(ii);
					PP2obx(end+1) = PP(i,2);
					PP3oby(end+1) = PP(i,3);
				end
			end
		end   %% else mismatches
		if (~ismember(PP2r(i),PP2rf) && ~ismember(PP2r(i),PP2rm) && ~ismember(PP2r(i),PP2rob) && PP2r(i) <= 500 && PP2r(i) ~= 0)   %%% checks for artificial frequencies
			PP2rf(end+1) = PP2r(i);
			PP2fx(end+1) = PP(i,2);
			PP3fy(end+1) = PP(i,3);
		end
	end
	
	hz_amplitude = strcat(num2str(PP2rm(:)), ',', num2str(PP3rm(:)));
	over_tone = strcat(num2str(PP2rob(:)), ',', num2str(PP2robb(:)));
	t1 = text(PP2mx(:),PP3my(:),num2str(PP2rm(:)),'color',[0 0 1]);
	t2 = text(PP2obx(:),PP3oby(:),over_tone,'color',[0 1 0]);
	t3 = text(PP2fx(:),PP3fy(:),num2str(PP2rf(:)),'color',[1 0 0]);
	set(t1,'rotation',90,'FontSize',12,'fontweight','bold');
	set(t2,'rotation',90,'FontSize',12,'fontweight','bold');
	set(t3,'rotation',90,'FontSize',12,'fontweight','bold');
	
	y = y(50:end);
	sig = horzcat(signals_used);
	t10 = text(100,max(y)*0.95,['signal length: ' num2str(signal_length)]);
	t4 = text(100,max(y)*0.9,['input signals (hz): ' num2str(sig)]);
	t5 = text(100,max(y)*0.85,['number of input signals: ' num2str(length(signals_used))]);
	t6 = text(100,max(y)*0.8,['matched output frequencies: ' num2str(length(PP2rm))]); set(t6,'color',[0 0 1]);
	t7 = text(100,max(y)*0.75,['overtones and base: ' num2str(length(PP2rob))]); set(t7,'color',[0 1 0]);
	t8 = text(100,max(y)*0.7,['artificial signals: ' num2str(length(PP2rf))]); set(t8,'color',[1 0 0]);
	t9 = text(100,max(y)*0.65,['permitted deviation is: +- ' num2str(dev)]);
	
	%l1 = legend('fft MEA1','peaks');
	%set(l1,'Position',[.6,.75,.1,.1]);
	%legend('boxoff');
	
	%axis([0 200 0 20])
	xlim([0 500])
	ylim([0 max(y)*1.1])
	set(gca,'XTick',[0:50:500])
	set(gca,'YTick',[0:max(y)*1.1/5:max(y)*1.1])
	%tick2text('axis', 'y', 'yformat', '%g', 'ytickoffset', .05);
	xlabel('Frequency (Hz)')
	ylabel('Amplitude (µV)')
	title(['Single-sided Amplitude Spectrum of ' EEG ' signal'],'FontWeight','bold');
	
	fft_peaks = strcat('fft_peaks_',EEG,'.png');
	print(h1,'-dpng',fft_peaks);
	
	disp('Peak Summary Statistics')
	disp( [ num2str(length(P(:,1))) ' peaks detected' ] )
	disp('          Interval      Height      Width          Area')
	disp( [ 'Maximum    ' num2str(max(diff)) '       ' num2str(max(PP(:,3))) '       ' num2str(max(PP(:,4)))  '       ' num2str(max(PP(:,5)))  ])
	disp( [ 'Minimum    ' num2str(min(diff)) '       ' num2str(min(PP(:,3))) '       ' num2str(min(PP(:,4)))  '       ' num2str(min(PP(:,5)))  ])
	disp( [ 'Mean       ' num2str(mean(diff)) '       ' num2str(mean(PP(:,3))) '       ' num2str(mean(PP(:,4)))  '       ' num2str(mean(PP(:,5)))  ])
	disp( [ '% STD      ' num2str(100.*std(diff)./mean(diff)) '       ' num2str(100.*std(PP(:,3))./mean(PP(:,3))) '       ' num2str(100.*std(PP(:,4))./mean(PP(:,4)))  '       ' num2str(100.*std(PP(:,5))./mean(PP(:,5)))  ])
	
	set(findall(gcf,'type','text'),'FontSize',12,'fontWeight','bold','Fontname','Calibri Light');
	set(gca, 'box', 'off');
	set(gcf,'color','w');
	%displaying statistcs auskomentiert
	%{
	h2 = figure;
	
	xbins = linspace(-2,2,20);
	subplot(2,2,1);hist(diff,40);title(['HG of intervals between peak positions (' EEG ')'],'FontWeight','bold');axis('tight');
	subplot(2,2,2);hist(PP(:,3),40);title(['HG of peak heights (' EEG ')'],'FontWeight','bold');axis('tight');
	subplot(2,2,3);hist(PP(:,4),40);title(['HG of Gaussian peak widths (' EEG ')'],'FontWeight','bold');axis('tight');
	subplot(2,2,4);hist(PP(:,5),40);title(['HG of Gaussian peak areas (' EEG ')'],'FontWeight','bold');axis('tight');
	
	fft_stats = strcat('fft_stats_',EEG,'.png');
	print(h2,'-dpng',fft_stats);
	%}
end
% -------------------------------------------------------------------------------
function [index,closestval]=val2ind(x,val)
% Returns the index and the value of the element of vector x that is closest to val
% If more than one element is equally close, returns vectors of indicies and values
% Tom O'Haver (toh@umd.edu) October 2006
% Examples: If x=[1 2 4 3 5 9 6 4 5 3 1], then val2ind(x,6)=7 and val2ind(x,5.1)=[5 9]
% [indices values]=val2ind(x,3.3) returns indices = [4 10] and values = [3 3]
dif=abs(x-val);
index=find((dif-min(dif))==0);
closestval=x(index);

function d=deriv(a)
% First derivative of vector using 2-point central difference.
%  T. C. O'Haver, 1988.
n=length(a);
d(1)=a(2)-a(1);
d(n)=a(n)-a(n-1);
for j = 2:n-1;
    d(j)=(a(j+1)-a(j-1)) ./ 2;
end

function SmoothY=fastsmooth(Y,w,type,ends)
% fastbsmooth(Y,w,type,ends) smooths vector Y with smooth
%  of width w. Version 2.0, May 2008.
% The argument "type" determines the smooth type:
%   If type=1, rectangular (sliding-average or boxcar)
%   If type=2, triangular (2 passes of sliding-average)
%   If type=3, pseudo-Gaussian (3 passes of sliding-average)
% The argument "ends" controls how the "ends" of the signal
% (the first w/2 points and the last w/2 points) are handled.
%   If ends=0, the ends are zero.  (In this mode the elapsed
%     time is independent of the smooth width). The fastest.
%   If ends=1, the ends are smoothed with progressively
%     smaller smooths the closer to the end. (In this mode the
%     elapsed time increases with increasing smooth widths).
% fastsmooth(Y,w,type) smooths with ends=0.
% fastsmooth(Y,w) smooths with type=1 and ends=0.
% Example:
% fastsmooth([1 1 1 10 10 10 1 1 1 1],3)= [0 1 4 7 10 7 4 1 1 0]
% fastsmooth([1 1 1 10 10 10 1 1 1 1],3,1,1)= [1 1 4 7 10 7 4 1 1 1]
%  T. C. O'Haver, May, 2008.
if nargin==2, ends=0; type=1; end
if nargin==3, ends=0; end
switch type
    case 1
        SmoothY=sa(Y,w,ends);
    case 2
        SmoothY=sa(sa(Y,w,ends),w,ends);
    case 3
        SmoothY=sa(sa(sa(Y,w,ends),w,ends),w,ends);
end

function SmoothY=sa(Y,smoothwidth,ends)
w=round(smoothwidth);
SumPoints=sum(Y(1:w));
s=zeros(size(Y));
halfw=round(w/2);
L=length(Y);
for k=1:L-w,
    s(k+halfw-1)=SumPoints;
    SumPoints=SumPoints-Y(k);
    SumPoints=SumPoints+Y(k+w);
end
s(k+halfw)=sum(Y(L-w+1:L));
SmoothY=s./w;
% Taper the ends of the signal if ends=1.
if ends==1,
    startpoint=(smoothwidth + 1)/2;
    SmoothY(1)=(Y(1)+Y(2))./2;
    for k=2:startpoint,
        SmoothY(k)=mean(Y(1:(2*k-1)));
        SmoothY(L-k+1)=mean(Y(L-2*k+2:L));
    end
    SmoothY(L)=(Y(L)+Y(L-1))./2;
end
% ----------------------------------------------------------------------
