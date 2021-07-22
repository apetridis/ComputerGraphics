function c_q = affine_transform(c_p,T)
%% Convert to homogenοus cordinates
    c_p(end+1,:) = 1;  
%% Affine Transform
    c_q = T.T*c_p;     
%% Convert back to normal cordinates 
    c_q(end,:) = [];    
end
