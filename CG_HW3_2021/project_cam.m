function [P,D] = project_cam(w, c_v, c_x, c_y, c_z, p)
%% Convert p to Cameras Cordinate System
    T = transformation_matrix;            %% Create Transformation matrix
    T.T(1:3,:) = [c_x, c_y, c_z c_v];     %% Add Rotation and offset
    p_new = system_transform(p, T);       %% Change cordinates
%% Produce prospective projections (From 3D to 2D)
    P(1,:) = -(p_new(1,:)*w)./p_new(3,:);
    P(2,:) = -(p_new(2,:)*w)./p_new(3,:);
%% Compute depth
    D = p_new(3,:);                       %% Depth = Z cordinate of p_new
end
