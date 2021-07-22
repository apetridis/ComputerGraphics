% Author: 
%   Konstantinos Chatzis
%   kachatzis <at> ece.auth.gr
%
%   Computer Graphics
%   Project 1
%   24/3/2021

%% Linear Interpolation of Vectors
% p1, p2: 2D Triangle Vertex Coordinates
% a: 2D point in which the interpolation is applied
% V1, V2: 3D vectors
% dim: direction in which the interpolation is applied 
%      to ({1: horizontal, 2:vertical})
function value = vector_interp(p1, p2, a, V1, V2, dim)

    % Find Distance Ratio of 'a' from 'p2',
    % respecively to 'p1' 
    w = ( a(dim) - p2(dim) ) / ( p1(dim) - p2(dim) );
    
    % The point is on top of both boundaries
    if isnan(w)
        w = 0.5;
    end

    % Find the ratio of each vector
    value = w * V1 + (1 - w) * V2;

end
