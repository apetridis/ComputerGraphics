function X = shade_gouraud(verts_p,verts_n,verts_c,bcoords,cam_pos,mat,lights,I_a,X)
    %% Compute colors for tops of triangle
    colors1 = ambient_light(mat,verts_c(:,1),I_a) + diffuse_light(bcoords,verts_n(:,1),[0;0;0],mat,lights) + specular_light(bcoords,verts_n(:,1),[0;0;0],cam_pos,mat,lights);
    colors2 = ambient_light(mat,verts_c(:,2),I_a) + diffuse_light(bcoords,verts_n(:,2),[0;0;0],mat,lights) + specular_light(bcoords,verts_n(:,2),[0;0;0],cam_pos,mat,lights);
    colors3 = ambient_light(mat,verts_c(:,3),I_a) + diffuse_light(bcoords,verts_n(:,3),[0;0;0],mat,lights) + specular_light(bcoords,verts_n(:,3),[0;0;0],cam_pos,mat,lights);
    colors = [colors1 colors2 colors3];
    %% Paint Triangle with vector_interp inside paint_triangle_gouraud
    X = paint_triangle_gouraud(X,verts_p',colors');
end
