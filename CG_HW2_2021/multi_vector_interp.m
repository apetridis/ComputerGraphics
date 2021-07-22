% Author: 
%   Konstantinos Chatzis
%   kachatzis <at> ece.auth.gr
%
%   Computer Graphics
%   Project 1
%   24/3/2021

%% Multiple-line vector Interpolation
% Returns vector interpolation for multiple rows.
% p1, p2: 2D Triangle Vertex Coordinates
% a: 2D point in which the interpolation is applied
% V1, V2: 3D vectors
% dim: direction in which the interpolation is applied 
%      to ({1: horizontal, 2:vertical})
function value = multi_vector_interp(p1, p2, a, V1, V2, dim)

    value = zeros(size(a,1),3);

    for i = 1:size(a,1)
        value(i,:) = vector_interp(p1, p2, a(i,:), V1, V2, dim);
    end

end