function P_rast = rasterize(P, M, N, H, W)
    %% Convert points from camera's Panel size HxW to computer's MxN
    % camera's panel (0,0) is in the middle of HxW %
    h_a = M/H;  %% Height analogy
    w_a = N/W;  %% Width analogy
    P_rast(1,:) = round((P(1,:)+W/2)*w_a);
    P_rast(2,:) = round((P(2,:)+H/2)*h_a);
end
