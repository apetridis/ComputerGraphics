function Img = render(vertices_2d,faces,vertex_colors,depth,renderer)
    M = 1200;
    N = 1200;
    Img = ones(M,N,3);
    K = size(faces,1);
    triangle_depth = zeros(1,K);
    %find depth for each triangle
    for i=1:K
        triangle_depth(i) = mean(depth(faces(i,:)));
    end
    %sort faces by triangle depth
    [~,b] = sort(triangle_depth,'descend');
    faces = faces(b,:);
        
    if strcmp(renderer,'Flat')%Create  Image  with  paint_triangle_flat  for  all  triangles
        for k = 1:K
            triangle_vertices = [vertices_2d(faces(k,1),:);vertices_2d(faces(k,2),:);vertices_2d(faces(k,3),:)];
            triangle_color = [vertex_colors(faces(k,1),:);vertex_colors(faces(k,2),:);vertex_colors(faces(k,3),:)];
            Img = paint_triangle_flat(Img,triangle_vertices,triangle_color);
        end      
    elseif strcmp(renderer,'Gouraud')%Create  Image  with  paint_triangle_gouraud  for  all  triangles
        for k = 1:K
            triangle_vertices = [vertices_2d(faces(k,1),:);vertices_2d(faces(k,2),:);vertices_2d(faces(k,3),:)];
            triangle_color = [vertex_colors(faces(k,1),:);vertex_colors(faces(k,2),:);vertex_colors(faces(k,3),:)];
            Img = paint_triangle_gouraud(Img,triangle_vertices,triangle_color);
        end    
    else
        fprintf('Renderer type is incorrect');
    end
end