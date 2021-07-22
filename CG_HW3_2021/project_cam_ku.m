function [P,D] = project_cam_ku(w, c_v, c_lookat, c_up, p)
%% Compute Cameras cordinates
    c_z = (c_lookat - c_v)/norm(c_lookat - c_v);
    c_y = c_up - dot(c_up, c_z);
    c_x = cross(c_y, c_z);
%% Call project_cam
[P,D] = project_cam(w, c_v, c_x, c_y, c_z, p);
end
