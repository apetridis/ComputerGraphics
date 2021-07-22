function I = diffuse_light(P,N,color,mat,lights)
    %% Calculate L unit nector from m light points
    m = length(lights);
    for i=1:m
        L(:,i) = (lights(i).pos' - P)/norm(lights(i).pos' - P);
    end
    %% Calculate diffuse light of P
    I = zeros(3,1);
    for i=1:m
        I = I + color + lights(i).intensity' .* mat.k_d * dot(N,L(:,i));
    end
end
