%%%%%%%%%%%%%%%%%%%
% search the fitting matrices in the workspace and order interatively
workspaceVars = who;

matchedNames = {};
integerValues = [];

% Iterate over each variable in the workspace
for i = 1:numel(workspaceVars)
    varName = workspaceVars{i};
    
    % Check if the variable name matches the pattern
    match = sscanf(varName, 'updated_table_%d');
    
    if ~isempty(match)
        % Add the matched name to the array
        matchedNames{end+1} = varName;
        
        % Add the corresponding integer value to the array
        integerValues(end+1) = match;
    end
end

% Sort the arrays based on the integer values
[sortedValues, sortIndices] = sort(integerValues);
sortedNames = matchedNames(sortIndices);

% Display the sorted names and corresponding integer values
for i = 1:numel(sortedNames)
    fprintf('%s: %d\n', sortedNames{i}, sortedValues(i));
end



%%%%%%%%%%%%%%%%%%%
% calculate correlation matrices, determine pdf of corr and plot

% Define the colors for each line
colors = [1 0 0; 0 1 0; 0 0 1; 
          1 0 0; 0 1 0; 0 0.6 0; 0 0.3 0; 0 0 1;     
          1 0 0; 0 1 0; 0 0.6 0; 0 0.3 0; 0 0 1;   
          1 0 0; 0 1 0; 0 0.6 0; 0 0.3 0; 0 0 1;];     


% create new folder to save the plot
%folder = ['C:\Users\job37yv\Research\Netlogo\Output\correlation network\results\pdf_corr\' cell2mat(simulationNames(i))];
folder = 'C:\Users\job37yv\Research\Netlogo\Output\correlation network\results\pdf_corr\';
if ~exist(folder, 'dir')
    mkdir(folder);
end

% Define the number of histograms in each group
groupSizes = [3, 5, 5, 5];
groupSizes = [3];

% Define the filepaths for each group
filenames = {'pdf_corr_ising.png', 'pdf_corr_MS30.png', 'pdf_corr_MS40.png', 'pdf_corr_MS50.png'};
filename = 'pdf_corr_ising.png';



startIdx = 1;

for g = 1:length(groupSizes)
    groupSize = groupSizes(g);
    endIdx = startIdx + groupSize - 1;   

    c1 = figure;
    hold on;
    %for i = 1:length(sortedNames)
    for i = startIdx:endIdx
        % get input tables
        updated_table = eval(strjoin(sortedNames(i)));
        input = table2array(updated_table)';

        % get the tags of the simulations
        simulationNames = regexprep(fileNames, '(ising_|activation_matrix_|\.txt)','');
        %filename = sprintf("pdf_corr_%s.png",cell2mat(simulationNames(i)));

        % building a crosscorrelation matrix
        corrMatrix = corrcoef(input');
        % Compute histogram bins
        %[counts, edges]  = histcounts(corrMatrix, 'Normalization', 'probability');
        %[counts, edges]  = histcounts(corrMatrix);
        %bin_centers = (edges(1:end-1) + edges(2:end)) / 2;
        [counts, bin_centers] = ksdensity(corrMatrix(:)');
        %  plot(bin_centers, counts, 'LineWidth', 2, 'Color', colors(i, :));
        plot(bin_centers, counts, 'LineWidth', 2, 'Color', colors(i, :));
    end
    hold off;

    fullpath = fullfile(folder, filenames(g));

    % Labeling the axes and adding a title
    xlabel('corr');
    ylabel('Counts');
    title('Degree Distribution Correlation');
    legend(simulationNames(startIdx:endIdx));
    print(c1,'-dpng',strjoin(fullpath),'-r500');

    startIdx = endIdx + 1;
end

