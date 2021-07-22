function I = ambient_light(mat,color,I_a)
    %% Calculate ambient light of a point
    I = color + (I_a .* mat.k_a);
end
