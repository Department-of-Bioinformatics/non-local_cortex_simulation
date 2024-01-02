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
% calculate correlation matrices, corr network for different p, avg degree and 

% Define the colors for each line
colors = [0.9290 0.6940 0.1250;  % Yellow
          0 0.4470 0.7410;      % Blue
          0.8500 0.3250 0.0980;  % Orange
          0.4940 0.1840 0.5560;  % Purple
          0.4660 0.6740 0.1880;  % Green
          0.3010 0.7450 0.9330;  % Light Blue
          0.6350 0.0780 0.1840;  % Dark Red
          0 0.5 0];              % Dark Green

% create new folder to save the plot
%folder = ['C:\Users\job37yv\Research\Netlogo\Output\correlation network\results\pdf_corr\' cell2mat(simulationNames(i))];
folder = 'C:\Users\job37yv\Research\Netlogo\Output\correlation network\results\degree_corrcutoff\';
if ~exist(folder, 'dir')
    mkdir(folder);
end

filename = 'degree_corrcutoff_plus_all.png';
fullpath = fullfile(folder, filename);

figure;
for i = 1:length(sortedNames)
    % get input tables
    updated_table = eval(strjoin(sortedNames(i)));
    input = table2array(updated_table)';

    % get the tags of the simulations
    simulationNames = regexprep(fileNames, '(ising_|activation_matrix_|\.txt)','');
    %filename = sprintf("pdf_corr_%s.png",cell2mat(simulationNames(i)));

    % building a crosscorrelation matrix
    corrMatrix = corrcoef(input');
    corrMatrix(logical(eye(N))) = 0;
    
    j = 0;
    x = zeros(10,1);
    y = zeros(10,1);
    for p = 0.01:0.01:1
        j = j + 1;
        % determine the networks for different p
         corrnetwork = corrMatrix > p;
        G = graph(corrnetwork);
        % determine average degree
        degrees = degree(G);

        % Calculate degree distribution
        %mean_degree = mean(degrees);
        [counts, edges] = histcounts(degrees, 'BinMethod', 'integers');

        % Compute bin centers
        binCenters = edges(1:end-1) + diff(edges)/2;    

        % Compute probability distribution
        probability = counts / sum(counts);

        if 1 == 0
            % Example degree
            k = 2;
            % Find probability for degree k
            index = find(binCenters == k);
            probabilityOfK = probability(index);
        end

        mean_degree = sum(binCenters .* probability);

        x(j) = p;
        y(j) = mean_degree;
    end
    %loglog(x, y, 'o-', 'LineWidth', 0.5)
    loglog(x, y, 'o-')
    %loglog(x, y, 'o')
    %xlim([1e-2, 1e0])
    %ylim([1e0, 1e3])
    %xticks([1e-2, 1e-1, 1e0])
    %yticks([1e-1, 1e0, 1e2, 1e3])
    %plot(x, y, 'ro', 'MarkerFaceColor', 'r', 'MarkerSize', 6);
    %plot(x, y, 'r-', 'LineWidth', 0.5);
    hold on;
end



% Labeling the axes and adding a title
xlabel('p');
ylabel('<k>');
title('p vs avgDegree');
legend(simulationNames(1:length(sortedNames)));
%print(c1,'-dpng',fullpath,'-r500');
hold off;
