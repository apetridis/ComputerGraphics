load('racoon_hw1.mat');
Img = render(vertices_2d,faces,vertex_colors,depth,'Gouraud');
figure;
imshow(Img)
imwrite(Img,'demo_Gouraud.png');
