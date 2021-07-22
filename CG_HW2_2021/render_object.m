function I = render_object(p, F, C, M, N, H, W, w, c_v, c_lookat, c_up)
%%  Produce prospective projections and Compute depth
    [P, D] = project_cam_ku(w, c_v, c_lookat, c_up, p);
%%  Convert points from camera's Panel size HxW to computer's MxN
    P_rast = rasterize(P, M, N, H, W);
%%  Create Image from Triangles, Colors and Depth (From first Project)
    I = render(P_rast', F, C, D, 'Gouraud');
end
