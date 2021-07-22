% Author: 
%   Konstantinos Chatzis
%   kachatzis <at> ece.auth.gr
%
%   Computer Graphics
%   Project 1
%   24/3/2021

%% next
% finds next integer in a circle of integers
% Starting from 1
% i: input
% max: maximum integer
function value = next(i, max)
    value = i + 1;
    if value > max 
        value = 1;
    end
end