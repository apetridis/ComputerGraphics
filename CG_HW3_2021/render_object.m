function Img = render_object(shader,focal,eye,lookat,up,bg_color,M,N,H,W,verts,vert_colors,face_indices,mat,lights,I_a)
    %% Calculate normal vectors of tops on 3D object
    normals = calculate_normals(verts,face_indices);
    %% Project tops of triangles from 3D to 2D and rasterize them to a rectangular MxN 
    [P_2d,D] = project_cam_ku(focal, eye, lookat, up, verts);
    P_2d = rasterize(P_2d, M, N, H, W);
    %% Find depth for each triangle
    K = size(face_indices,2);
    triangle_depth = zeros(1,K);
    for i=1:K
        triangle_depth(i) = mean(D(face_indices(:,i)));
    end
    %% Sort faces by triangle depth
    [~,b] = sort(triangle_depth,'descend');
    face_indices = face_indices(:,b);
    %% Initialize Image with background color
    Img = zeros(M,N,3);
    Img(:,:,1) = bg_color(1);
    Img(:,:,2) = bg_color(2);
    Img(:,:,3) = bg_color(3);
    %% Paint K triangles into Image
    for k=1:K
        verts_p = [P_2d(:,face_indices(1,k)) P_2d(:,face_indices(2,k)) P_2d(:,face_indices(3,k))];
        verts_n = [normals(:,face_indices(1,k)) normals(:,face_indices(2,k)) normals(:,face_indices(3,k))];
        verts_c = [vert_colors(:,face_indices(1,k)) vert_colors(:,face_indices(2,k)) vert_colors(:,face_indices(3,k))];
        bcoords = (verts(:,face_indices(1,k)) + verts(:,face_indices(2,k)) + verts(:,face_indices(3,k)))/3;        
        if shader
            Img = shade_gouraud(verts_p,verts_n,verts_c,bcoords,eye,mat,lights,I_a,Img);
        elseif shadder == 2
            Img = shade_phong(verts_p,verts_n,verts_c,bcoords,eye,mat,lights,I_a,Img);
        else
            fprintf('Shader option must be 1 (for Gouraud) or 2 (for Phong)');
            break;
        end
    end
end

