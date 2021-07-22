function I = specular_light(P,N,color,cam_pos,mat,lights)
    %% Calculate V unit vector
    V = (cam_pos - P)/norm(cam_pos - P);
    %% Calculate L unit nector from m light points
    m = length(lights);
    for i=1:m
        L(:,i) = (lights(i).pos' - P)/norm(lights(i).pos' - P);
    end
	%% Calculate spectral light of P
    I = zeros(3,1);
    for i=1:m
        I = I + color + lights(i).intensity' .* mat.k_s * dot((2*N*dot(N,L(:,i)) - L(:,i)),V)^mat.n_phong;
    end
end
