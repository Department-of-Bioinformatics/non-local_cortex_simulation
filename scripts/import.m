%% Import data from text file

% Specify the file path
prefix = 'C:\Users\job37yv\Research\Netlogo\Output\correlation network\simulation and output old\';

% Array of input file names
fileNames = {
    'ising_t3.v2.txt',
    'ising_t23.v2.txt',
    'ising_t2.v2.txt',

    'activation_matrix_N36SOD1C1S30.txt',
    'activation_matrix_N3SOD1C1S30.txt',
    'activation_matrix_N2SOD1C1S30.txt',
    'activation_matrix_N1SOD1C1S30.txt',
    'activation_matrix_N01SOD1C1S30.txt',

    'activation_matrix_N36SOD1C1S40.txt',
    'activation_matrix_N3SOD1C1S40.txt',
    'activation_matrix_N2SOD1C1S40.txt',
    'activation_matrix_N1SOD1C1S40.txt',
    'activation_matrix_N01SOD1C1S40.txt',

    'activation_matrix_N36SOD1C1S50.txt',
    'activation_matrix_N3SOD1C1S50.txt',
    'activation_matrix_N2SOD1C1S50.txt',
    'activation_matrix_N1SOD1C1S50.txt',
    'activation_matrix_N01SOD1C1S50.txt'
}

fileNames = {
    'ising_t3.v2.txt',
    'ising_t23.v2.txt',
    'ising_t2.v2.txt'
}


% Concatenate the prefix with each file name
result = cell(size(fileNames));
for i = 1:numel(fileNames)
    result{i} = [prefix fileNames{i}];
end

% Display the concatenated strings
disp(result);

%parfor
%for i = 1:length(result)
for i = 1:length(result)
    %file_path = "C:\Users\job37yv\Research\Netlogo\Output\correlation network\simulation\activation_matrix_N1D0001SOD01CHAOS1S40.txt"
    file_path = cell2mat(result(i));

    % Read the CSV file as a table, specifying row 4 onwards as data and row 3 as the variable names
    if (contains(file_path, "ising_"))
        data_table = readtable(file_path, 'HeaderLines', 2, 'ReadVariableNames', false);
        header_row = readtable(file_path, 'Range', 'A2');  % Read the header row separately
    else
        data_table = readtable(file_path, 'HeaderLines', 3, 'ReadVariableNames', false);
        header_row = readtable(file_path, 'Range', 'A3');  % Read the header row separately
    end
    
    % Assign the header from the header row
    data_table.Properties.VariableNames = header_row.Properties.VariableNames;

    % remove the borders of the model
    % Find columns with header containing the number 20
    header = data_table.Properties.VariableNames;

    %% filter data 
    % filter length 
    %data_table2 = data_table;
    if (contains(file_path, "ising_"))
        data_table = data_table(30000:38000,:);
    else
        data_table = data_table(30000:38000,:);
    end
    

    if (contains(file_path, 'activation_matrix|ising'))
        border1 = (sqrt(size(data_table,2))-1)/2;
        border2 = (sqrt(size(data_table,2))-1)/2-1;
        border3 = (sqrt(size(data_table,2))-1)/2-2;
        borders = [border1, border2, border3];

        sum(contains(header, num2str(border1)))
        contains_20 = contains(header, num2str(border1));
        contains_19 = contains(header, num2str(border2));
        contains_18 = contains(header, num2str(border3));

        %contains = ismember(header, borders);
        columns_to_remove = contains_18 | contains_19 | contains_20;

        % Remove the columns
        updated_table = data_table(:, ~columns_to_remove);
    else
        updated_table = data_table;
    end
    
    % Assign the imported data to a new matrix with a dynamic variable name
    variableName = ['updated_table_', num2str(i)];
    assignin('base', variableName, updated_table);


    % Display the updated table
    %disp(updated_table);

    input = table2array(updated_table);

    % reproduce the 3D Matrix from the simulation
    % Assuming your 2D matrix is named "input_matrix"
    %input_matrix = rand(400, 100);  % Replace this with your actual 2D matrix
    input_matrix = input; 

    % Reshape the 2D matrix into a 3D matrix
    dimx = sqrt(size(input_matrix, 2));
    dimy = sqrt(size(input_matrix, 2));
    dimz = size(input_matrix, 1);

    %reshaped_matrix = reshape(input_matrix, 20, 20, 100);
    reshaped_matrix = reshape(input_matrix', dimx, dimy, dimz);
    test = reshaped_matrix(:,:,1);

    % Permute the dimensions to align with the desired orientation
    permuted_matrix = permute(reshaped_matrix, [2 1 3]);
    test = permuted_matrix(:,:,1);

    %%asign permuted 

    % Print the size of the resulting 3D matrix
    disp(size(permuted_matrix));
    variableName = ['permuted_matrix_', num2str(i)];
    assignin('base', variableName, permuted_matrix);
end




%% determine the line plot powerlaw 

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






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% bin 

% Create a string of increasing integers from 1 to 1681
m = activationmatrixN26655NSO1C1;
[rows, columns] = size(m);

vector = 1:columns;

% Omit the first values
first = sqrt(columns);
vector = vector(first+2:end);
disp(vector);

% Remove the last values
last = first;
vector = vector(1:end-last);

% Define the indices to remove
indices_to_remove1 = first:first-1:length(vector);

% Define the indices to remove
indices_to_remove2 = first+1:first-1:length(vector);

indices_to_remove = horzcat(indices_to_remove1, indices_to_remove2);

% Create a new vector excluding the specified values
vector(indices_to_remove) = [];

% Display the resulting string
length(vector)
%disp(vector);

% Translate integer values into alphabetic code
%vector1 = 1:1:100;
%alphabetic_code = char('A' + vector1 - 1);
% Display the alphabetic code
%disp(alphabetic_code);

input = input(:,vector);
