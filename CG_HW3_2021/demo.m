%% Initialize Data
load('hw3.mat');
vert_colors = vert_colors';
face_indices = face_indices';
mat = PhongMaterial(ka,kd,ks,n_phong);
lights = PointLight(point_light_pos',point_light_intensity);
I_a = Ia';

%% Gouraud shader
shader = 1;
% All type of lights
Img_All_gouraud = render_object(shader,focal,eye,lookat,up,bg_color,M,N,H,W,verts,vert_colors,face_indices,mat,lights,I_a);

% Only ambient light
mat = PhongMaterial(ka,0,0,n_phong);
Img_amb_gouraud = render_object(shader,focal,eye,lookat,up,bg_color,M,N,H,W,verts,vert_colors,face_indices,mat,lights,I_a);

% Only diffusion light
mat = PhongMaterial(0,kd,0,n_phong);
Img_diff_gouraud = render_object(shader,focal,eye,lookat,up,bg_color,M,N,H,W,verts,vert_colors,face_indices,mat,lights,I_a);

% Only specular light
mat = PhongMaterial(0,0,ks,n_phong);
Img_spec_gouraud = render_object(shader,focal,eye,lookat,up,bg_color,M,N,H,W,verts,vert_colors,face_indices,mat,lights,I_a);

fh_gouraud = figure();
fh_gouraud.WindowState = 'maximized';
sgtitle('Gouraud Shading');
subplot(2,2,1);
imshow(Img_All_gouraud);
title('All type of lights');
subplot(2,2,2);
imshow(Img_amb_gouraud);
title('Only ambient light');
subplot(2,2,3);
imshow(Img_diff_gouraud);
title('Only diffusion light');
subplot(2,2,4);
imshow(Img_spec_gouraud);
title('Only specular light');

%% Phong shader
shader = 2;
mat = PhongMaterial(ka,kd,ks,n_phong);
% All type of lights
Img_All_phong = render_object(shader,focal,eye,lookat,up,bg_color,M,N,H,W,verts,vert_colors,face_indices,mat,lights,I_a);

% Only ambient light
mat = PhongMaterial(ka,0,0,n_phong);
Img_amb_phong = render_object(shader,focal,eye,lookat,up,bg_color,M,N,H,W,verts,vert_colors,face_indices,mat,lights,I_a);

% Only diffusion light
mat = PhongMaterial(0,kd,0,n_phong);
Img_diff_phong = render_object(shader,focal,eye,lookat,up,bg_color,M,N,H,W,verts,vert_colors,face_indices,mat,lights,I_a);

% Only specular light
mat = PhongMaterial(0,0,ks,n_phong);
Img_spec_phong = render_object(shader,focal,eye,lookat,up,bg_color,M,N,H,W,verts,vert_colors,face_indices,mat,lights,I_a);

fh_phong = figure();
fh_phong.WindowState = 'maximized';
sgtitle('Phong Shading');
subplot(2,2,1);
imshow(Img_All_phong);
title('All type of lights');
subplot(2,2,2);
imshow(Img_amb_phong);
title('Only ambient light');
subplot(2,2,3);
imshow(Img_diff_phong);
title('Only diffusion light');
subplot(2,2,4);
imshow(Img_spec_phong);
title('Only specular light');