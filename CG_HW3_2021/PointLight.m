classdef PointLight
    properties
        pos;
        intensity;
    end
    
    methods
        function obj = PointLight(pos,intensity)
            obj.pos = pos;
            obj.intensity = intensity;
        end
    end
end

