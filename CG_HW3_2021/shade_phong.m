function X = shade_phong(verts_p,verts_n,verts_c,bcoords,cam_pos,mat,lights,I_a,X)    
    X = paint_triangle_phong(X, verts_p', verts_c', verts_n', I_a, bcoords,cam_pos,mat,lights);
end

