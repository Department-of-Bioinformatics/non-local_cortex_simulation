% Example correlation matrix

% Create a Graph object
G = graph(corrnetwork);

% Set node labels (optional)
node_labels = cellstr(num2str((1:numnodes(G))'));

% Create the graph plot
figure;
h = plot(G, 'Layout', 'force', 'NodeLabel', node_labels);
title('Correlation Network');