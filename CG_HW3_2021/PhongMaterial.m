classdef PhongMaterial    
    properties
        k_a;            %% Diffuse light factor from the environment
        k_d;            %% Diffuse reflection
        k_s;            %% Mirror reflection
        n_phong;        %% Degree of dispersion of reflected rays from the surface
    end
    
    methods
        function obj = PhongMaterial(k_a,k_d, k_s, n_phong)
            obj.k_a = k_a;
            obj.k_d = k_d;
            obj.k_s = k_s;
            obj.n_phong = n_phong;
        end        
    end
end

