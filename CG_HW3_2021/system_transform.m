function d_p = system_transform(c_p,T)
%% Convert to homogenοus cordinates
    c_p(end+1,:) = 1;  
%% Change cordinates
    d_p = T.T^(-1)*c_p;
%% Convert back to normal cordinates
    d_p(end,:) = [];
end
