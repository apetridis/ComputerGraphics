classdef transformation_matrix
    % Transformation matrix of a point %
    properties
        T
    end
    
    methods
    %% Constructor of class, initialize T into unit array
        function obj = transformation_matrix
            obj.T = eye(4);
        end
    %% Rotate Array at angle theta from u axis
        function modified_obj = rotate(modified_obj, theta, u)
            modified_obj.T(1:3,1:3) = (1-cos(theta))*[u(1)^2, u(1)*u(2), u(1)*u(3); u(2)*u(1), u(2)^2, u(2)*u(3); u(3)*u(1), u(3)*u(2), u(3)^2] + cos(theta)*eye(3) + sin(theta)*[0, -u(3), u(2); u(3), 0, -u(1); -u(2), u(1), 0];
        end
    %% Shift by vector t
        function modified_obj = translate(modified_obj, t)
            modified_obj.T(1:3,4) = t;
        end
    end
end
