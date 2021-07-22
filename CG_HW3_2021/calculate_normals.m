function normals = calculate_normals(vertices,face_indices)
    [~,N_v] = size(vertices);           %% Number of tops on 3D object
    [~,N_t] = size(face_indices);       %% Number of triangles on 3D object
    normals = zeros(3,N_v);
    %% Compute normal vector for each triangle and tops
    for i=1:N_t
        t_normal = cross(vertices(:,face_indices(2,i)) - vertices(:,face_indices(1,i)), vertices(:,face_indices(3,i)) - vertices(:,face_indices(2,i)));
        t_normal = t_normal/norm(t_normal);
        normals(:,face_indices(1,i)) = normals(:,face_indices(1,i)) + t_normal;
        normals(:,face_indices(2,i)) = normals(:,face_indices(2,i)) + t_normal;
        normals(:,face_indices(3,i)) = normals(:,face_indices(3,i)) + t_normal;
    end
    %% Normalize normal vectors of each top
    for i=1:N_v
        normals(:,i) = normals(:,i)/norm(normals(:,i));
    end
end
