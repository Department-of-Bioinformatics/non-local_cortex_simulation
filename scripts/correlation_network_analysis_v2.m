%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% analyse the correlation network
%% by calculate correlations coefficients

% Initialize arrays to store matched names and corresponding integer values
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


% for each file determine correlation network and network properties
for i = 1:length(sortedNames)
    %get input table
    updated_table = eval(strjoin(sortedNames(i)));
    input = table2array(updated_table)';

    %figure to folder
    simulationNames = regexprep(fileNames, '(ising_|activation_matrix_|\.txt)','');
    folder = ['C:\Users\job37yv\Research\Netlogo\Output\correlation network\results\pdf\' cell2mat(simulationNames(i))];
    if ~exist(folder, 'dir')
        mkdir(folder);
    end

    %save signal figure
    filename = sprintf("signal_%s.png",cell2mat(simulationNames(i)));
    fullpath = fullfile(folder, filename);
    h1 = figure;
    plot(input);
    print(h1,'-dpng',fullpath,'-r500');

    %% building correlation matrix
    corrdata = corrcoef(input');

    %define network cutoff
    positiveThreshold = 0.2; % Adjust this value as needed
    negativeThreshold = -0.2; % Adjust this value as needed
    corcutoff = positiveThreshold;

    % build binary interaction matrix from corr matrix
    corrnetwork = corrdata>corcutoff;

    %% plot PDF of the degree of the nodes in the network 
    % count the number of neighbours
    NormalCount = sum(corrdata>corcutoff);

    y0 = NormalCount;
    %y00 = bsxfun(@rdivide, y0,  mean(y0));
    y00 = y0;
    yAll = sort(y00);

    %binranges = 0:1:100;  %fixed binranges
    numbins = 120;
    n8 = length(yAll);
    binwidth8 = range(yAll) / numbins;
    edge8 = min(yAll):binwidth8:max(yAll);   %dynamic binranges(edges)

    [bincounts8,ind8] = histc(yAll,edge8);

    % probability estimation
    bincounts8 = bincounts8 ./ (n8*binwidth8);

    % Defaults for ploting the figures
    width = 7;     % Width in inches
    height = 3;    % Height in inches
    alw = 2;     % AxesLineWidth
    fsz = 10;      % Fontsize
    lw = 2;      % LineWidth
    msz = 2;       % MarkerSize

    window_size = 1;

    h2 = figure;
    plot(edge8(:,window_size:end)',bincounts8,'^','markerfacecolor',[1 0 0],'markeredgecolor',[1 0 0],'MarkerSize',msz);

    h3 = figure;
    loglog(edge8(:,window_size:end)',bincounts8,'^','markerfacecolor',[1 1 1],'markeredgecolor',[1 0 0],'MarkerSize',msz);
    xlim([1 5000])

    filename = sprintf("pdf_%s.png",cell2mat(simulationNames(i)));
    fullpath = fullfile(folder, filename);
    print(h2,'-dpng',fullpath,'-r500');

    filename = sprintf("pdf_loglog_%s.png",cell2mat(simulationNames(i)));
    fullpath = fullfile(folder, filename);   
    print(h3,'-dpng',fullpath,'-r500');

    
    %% criticality analysis

    % Berechnen der Eigenschaften des Netzwerks
    network_degree = sum(corrdata > corcutoff, 2); % Grad des Knotens
    network_strength = sum(corrdata, 2); % Stärke des Knotens

    % Berechnen der Critcality-Maße
    mean_degree = mean(network_degree); % durchschnittlicher Grad des Netzwerks
    mean_strength = mean(network_strength); % durchschnittliche Stärke des Netzwerks
    criticality = mean_degree / mean_strength; % Critcality-Maß

    % Plotten der Ergebnisse
    h4 = figure;
    histogram(network_degree);
    xlabel('Degree');
    ylabel('Frequency');
    title('Degree Distribution');

    h5 = figure;
    histogram(network_strength);
    xlabel('Strength');
    ylabel('Frequency');
    title('Strength Distribution');


    filename = sprintf("hist_degree_%s.png",cell2mat(simulationNames(i)));
    fullpath = fullfile(folder, filename);
    print(h4,'-dpng',fullpath,'-r500');


    filename = sprintf("hist_strength_loglog_%s.png",cell2mat(simulationNames(i)));
    fullpath = fullfile(folder, filename);   
    print(h5,'-dpng',fullpath,'-r500');


    fprintf('Mean Degree: %f\n', mean_degree);
    fprintf('Mean Strength: %f\n', mean_strength);
    fprintf('Critcality: %f\n', criticality);


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% get network properties

    G = graph(corrnetwork);
    %figure;
    %plot(G);
    % Network properties
    networkSize = numnodes(G);
    numberOfEdges = numedges(G);
    averageDegree = mean(degree(G));
    clusteringCoefficient = mean(clustering_coefficient_matrix(corrnetwork));
    %clusteringCoefficient = mean(clustering_coef_bu(corrnetwork));
    D = distances(G);
    networkDiameter = max(D(~isinf(D)));
    averagePathLength = mean(D(~isinf(D)));

    tableData = table(networkSize, averageDegree, clusteringCoefficient, averagePathLength, networkDiameter);
    tableData.Properties.VariableNames = {'NetworkSize', 'AverageDegree', 'ClusteringCoefficient', 'AveragePathLength', 'NetworkDiameter'};


    %% generate a random network to compare with
    %https://www.cs.purdue.edu/homes/dgleich/demos/erdos_renyi/generate.html
    n = networkSize;
    e = numberOfEdges;
    s = randi(n, e, 1);
    t = randi(n, e, 1);

    N = n;
    %p = 0.001;
    p = e/n^2;

    rand('seed',100); % reseed so you get a similar picture
    G = rand(N,N) < p;
    G = triu(G,1);
    G = G + G';

    thres_giant = 1/(N-1)

    randomNetwork = graph(G);


    randomNetworkProperties = struct();
    %adjMatrix = adjacency(G);

    randomNetworkProperties.AverageDegree = mean(degree(randomNetwork));
    randomNetworkProperties.ClusteringCoefficient = mean(clustering_coefficient_matrix(adjacency(randomNetwork)));
    randomNetworkProperties.AveragePathLength = mean(distances(randomNetwork));
    D = distances(randomNetwork);
    randomNetworkProperties.NetworkDiameter = max(D(~isinf(D)));
    disp(randomNetworkProperties.NetworkDiameter);
    randomNetworkProperties.AveragePathLength = mean(D(~isinf(D)));
    randomNetworkProperties.file_path = file_path;

    randomTableData = table(randomNetworkProperties.AverageDegree, randomNetworkProperties.ClusteringCoefficient, randomNetworkProperties.AveragePathLength, randomNetworkProperties.NetworkDiameter, simulationNames(i));
    randomTableData.Properties.VariableNames = {'rnAverageDegree', 'rnClusteringCoefficient', 'rnAveragePathLength', 'rnNetworkDiameter','simulationNames'};


    tableData2 = horzcat(tableData, randomTableData);

    % Specify the file name and path
    filename = 'network_properties.xlsx';
    sheetName = 'Network_Properties';

    % export table into excel file
    % Check if the file exists
    if exist(filename, 'file')
        % If the file exists, read the existing data from the sheet
        existingData = readtable(filename, 'Sheet', sheetName);
        
        % Append the new data to the existing data
        combinedData = [existingData; tableData2];

        % Write the combined data to the Excel sheet
        writetable(combinedData, filename, 'Sheet', sheetName, 'WriteVariableNames', true);
    else
        % Write the tableData to Excel
        writetable(tableData2, filename, 'Sheet', sheetName, 'WriteVariableNames', true);
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% functions
function cc = clustering_coefficient(adjacencyMatrix)
    n = size(adjacencyMatrix, 1);
    cc = zeros(n, 1);

    for i = 1:n
        neighbors = find(adjacencyMatrix(i, :));
        k = numel(neighbors);
        
        if k > 1
            subgraph = adjacencyMatrix(neighbors, neighbors);
            numEdges = sum(subgraph(:))/2;
            cc(i) = 2 * numEdges / (k * (k - 1));
        end
    end
end


function G = randomGraph(N, p)
    % Create an empty graph object
    G = graph();

    % Generate random connections
    for i = 1:N
        for j = i+1:N
            if rand() < p
                G = addedge(G, i, j);
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% bin
%% generate a random network to compare with
% V1
n = networkSize;
e = numberOfEdges;
%randomNetwork = randomGraph(N, numberOfEdges / (N * (N - 1))); % Adjust the density parameter if needed
s = randi(n, e, 1);
t = randi(n, e, 1);
randomNetwork = graph(s, t, [], n);
%A = 1*(beta>=rand(n));

figure;
plot(randomNetwork);


% V2
G = graph(true(n)); % Self-loops are possible
%G = graph(true(n), 'omitselfloops'); % Alternative without self-loops
p = randperm(numedges(G), e);
randomNetwork = graph(G.Edges(p, :));

figure;
plot(randomNetwork);

% V3
N = n;  % Number of nodes
p = 0.029;  % Probability of connection
p = e/n^2;

% Create an Erdős-Rényi random network
randomNetwork = randomGraph(N, p);

% Plot the network
figure;
plot(G);
