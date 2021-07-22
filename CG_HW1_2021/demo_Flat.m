load('racoon_hw1.mat');
Img = render(vertices_2d,faces,vertex_colors,depth,'Flat');
figure;
imshow(Img)
imwrite(Img,'demo_flat.png');


