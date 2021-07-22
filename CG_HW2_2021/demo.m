%% Load data
load('hw2.mat');
%% Step 0 -Initial position 
I = render_object(V', F, C, M, N, H, W, w, cv, ck, cu);
% Save result
imwrite(I, '0.jpg');
% Step 0.5 - Create a transformation matrix
T = transformation_matrix;
%% Step 1 - Translate the transformation matrix by t1
T = translate(T, t1);
% 1.1 Apply translation
V1 = affine_transform(V', T);
% 1.2 Render object with render_object
I1 = render_object(V1, F, C, M, N, H, W, w, cv, ck, cu);
% Save result
imwrite(I1, '1.jpg');
%% Step 2 - Rotate the transformation matrix by theta around given axis g
% Step 2.0.5 - Create a transformation matrix
T = transformation_matrix;
% 2.1 Apply rotation
T = rotate(T, theta, g);
V2 = affine_transform(V1, T);
% 2.2 Render object with render_object
I2 = render_object(V2, F, C, M, N, H, W, w, cv, ck, cu);
% Save result
imwrite(I2, '2.jpg');
%% Step 3 - Translate the transformation matrix by t2
% Step 3.0.5 - Create a transformation matrix
T = transformation_matrix;
% 3.1 Apply translation
T = translate(T, t2);
V3 = affine_transform(V2, T);
% 3.2 Render object with render_object
I3 = render_object(V3, F, C, M, N, H, W, w, cv, ck, cu);
% Save result
imwrite(I3, '3.jpg');


