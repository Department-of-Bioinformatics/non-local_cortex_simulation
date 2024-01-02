% Load LFP recordings (replace with your own data)
%load('LFP_recordings.mat'); % Assuming you have a matrix called 'LFP_recordings' with dimensions (channels, time points)
input = activationmatrixN26655NSO1C1;
input = matrix_2d;
%%use script import before

%input = input(:,300:340)


% Calculate column means
%maxi = max(abs(input));

% Normalize matrix by column means
%input = input ./ maxi;

figure;
plot(input);

%plot(input(:,1));

% Parameters for PSD calculation
window_size = 200; % Window size for PSD calculation (adjust as needed)
overlap = 50; % Overlap between consecutive windows (adjust as needed)


% Calculate PSD
%[pxx,f] = pwelch(x,500,300,500,fs,'centered','power');
[PSD, frequencies] = pwelch(input, window_size, overlap, 1000, 1000,'power');


% Plot PSD
figure;
loglog(frequencies, PSD);
xlabel('Frequency (Hz)');
ylabel('Power Spectrum Density');
title('Power Spectrum Density');


% Fit power law model
x = frequencies;
y = PSD;

% Manually transform the data to fit a power law model
logx = log10(x);
logy = log10(y);

% Match the dimensions of logy to logx
logx = repmat(logx, 1, size(logy, 2));

% Fit a linear model in the log-log space
coeffs = polyfit(logx, logy, 1);

% powerlaw_fit = fit(log10(x)', log10(y)', 'poly1');

% Extract Power Law exponent
%powerlaw_exponent = powerlaw_fit.p1;
powerlaw_exponent = -coeffs(1);

% Plot power law fit
figure;
loglog(x, y);
hold on;
loglog(x, 10.^(polyval(coeffs, logx)), 'r-', 'LineWidth', 2);
xlabel('Frequency (Hz)');
ylabel('Power Spectrum Density');
title(['Power Law Fit, Exponent: ' num2str(powerlaw_exponent)]);

% Interpret criticality measure
if powerlaw_exponent > -1
    disp('The neural network exhibits criticality (Power Law exponent > -1).');
else
    disp('The neural network does not exhibit criticality (Power Law exponent <= -1).');
end