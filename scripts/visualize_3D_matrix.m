matrix_3d = permuted_matrix;  % Replace with your own 3D matrix

% Visualize a 3D matrix
% Create spatial coordinate arrays
x = 1:size(matrix_3d, 1);
y = 1:size(matrix_3d, 2);

% Create a time axis
time = 1:size(matrix_3d, 3);

% Visualize the 3D matrix
figure;
for t = 1:length(time)
    slice(matrix_3d, [], [], t);
    xlabel('X');
    ylabel('Y');
    zlabel('Time');
    axis tight;
    title(['Slice at Time = ', num2str(time(t))]);
    colorbar;
    pause(0.5);  % Pause between slices for visualization
end


matrix_3d = permuted_matrix;  % Replace with your own 3D matrix
% Create spatial coordinate arrays
x = 1:size(matrix_3d, 1);
y = 1:size(matrix_3d, 2);

% Create a time axis
time = 1:size(matrix_3d, 3);

% Visualize the 3D matrix
figure;
for t = 1:length(time)
    bending_factor = 1 - (t / length(time));
    bending_y = y - bending_factor * max(y);
    
    %[X, Bending_Y] = meshgrid(x, bending_y);
    [X, Bending_Y] = meshgrid(x, y);
    Z = matrix_3d(:, :, t);
    
    surf(X, Bending_Y, Z);
    %surf(X, Y, Z);
    xlabel('X');
    ylabel('Bending Y');
    zlabel('Time');
    axis tight;
    title(['Time = ', num2str(time(t))]);
    colorbar;
    view(3);
    zlim([min(matrix_3d(:)), max(matrix_3d(:))]);  % Set the fixed scaling for the Z axis
    pause(0.5);  % Pause between time steps for visualization
end

