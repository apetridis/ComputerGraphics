% Author: 
%   Konstantinos Chatzis
%   kachatzis <at> ece.auth.gr
%
%   Computer Graphics
%   Project 1
%   25/3/2021

%% Paint Gradient Colored Triangle
% 
% In this algorithm we are drawing a triangle using a gradient color.
% Boundary crossings don't need to be counted, for the active edges 
% are always one (on a horizontal edge) or two (in any other scan 
% line of the triangle), thus only one or none region is active  
% at any scan line.
% Scan lines without an active region (only one active edge) 
% have no boundary points, but are drawn as a whole line. 
%
% img: Image of MxNx3
% vertices_2d: 3 Vertices of Triangle (3x2)
% vertex_colors: 3 Colors of Triangle Vertices (3x3)
% 
function Y = paint_triangle_gouraud(img, vertices_2d, vertex_colors)

    %% Initialize Values for the algorithm

    % Find min, max of x, y for the whole triangle 
    y_min = min([vertices_2d(1,2), vertices_2d(2,2), vertices_2d(3,2)]);
    y_max = max([vertices_2d(1,2), vertices_2d(2,2), vertices_2d(3,2)]);
    x_min = min([vertices_2d(1,1), vertices_2d(2,1), vertices_2d(3,1)]);
    x_max = max([vertices_2d(1,1), vertices_2d(2,1), vertices_2d(3,1)]);


    % For Each Edge find min, max of x, y

    % xkmin, xkmax, ykmin, ykmax: 3D Vector (a scalar for each edge 'k').
    % Where min, max are the minimum and maximum vertices of
    % the edge from vertex k to vertex k+1.
    % slope: 3D vector containing the 2D slope of each edge

    ykmin = zeros(3,1);
    ykmax = zeros(3,1);
    xkmin = zeros(3,1);
    xkmax = zeros(3,1);
    slope = zeros(3,1);

    for j = 1 : 3  % For each edge of the triangle

        % ending vertex of edge j
        next_vertex = next(j,3);

        % Find min, max
        xkmin(j) = min([vertices_2d(j,1), vertices_2d(next_vertex,1)]);
        xkmax(j) = max([vertices_2d(j,1), vertices_2d(next_vertex,1)]);
        ykmin(j) = min([vertices_2d(j,2), vertices_2d(next_vertex,2)]);
        ykmax(j) = max([vertices_2d(j,2), vertices_2d(next_vertex,2)]);

        slope(j) = (vertices_2d(next_vertex,2) - vertices_2d(j,2)) / (vertices_2d(next_vertex,1) - vertices_2d(j,1));
        
    end

    % active_edges: a single multi-dimensinal vector, where each scalar is an edge.
    active_edges = [];

    % boundary_points: a Mx2 array, where M are the boundary points, and each 
    % line contains a 2D vector as columns.
    boundary_points = [];

    %% Draw Triangle
    
    % for each line
    for y = y_min:y_max

        % Update Active Edges and Boundary Points
        [active_edges, boundary_points] = update_scan_line(y, active_edges, boundary_points, vertices_2d, slope, ykmin, ykmax, xkmin, xkmax, y_min, y_max);

            % If there are 2 boundaries
            if size(boundary_points) > [1 1]

             % Find colors on first boundary
                c_left = vector_interp( ...
                    (vertices_2d(active_edges(1),:)) , ...          % Left Edge Vertex 1
                    (vertices_2d(next(active_edges(1),3),:)) , ...  % Left Edge Vertex 2
                    round(boundary_points(1,:)), ...                % Scanline's Left Boundary
                    vertex_colors(active_edges(1),:) , ...          % Colour of Vertex 1
                    vertex_colors(next(active_edges(1),3),:) , ...  % Colour of Vertex 2
                    2 ...                                           % Vertical Interpolation
                );
                
                % Find colors on second boundary
                c_right = vector_interp( ...
                    (vertices_2d(active_edges(2),:)) , ...          % Right Edge Vertex 1
                    (vertices_2d(next(active_edges(2),3),:)) , ...  % Right Edge Vertex 2
                    round(boundary_points(2,:)), ...                % Scanline's Right Boundary
                    vertex_colors(active_edges(2),:) , ...          % Colour of Vertex 1
                    vertex_colors(next(active_edges(2),3),:) , ...  % Colour of Vertex 2
                    2 ...                                           % Vertical Interpolation
                );

                % Paint active region
                img( y , round( boundary_points(1,1) ) : round( boundary_points(2,1) ), :) = ...
                    multi_vector_interp( ...
                        round(boundary_points(1,:)) , ...           % Left Boundary
                        round(boundary_points(2,:)), ...            % Right Boundary
                        transpose(round(boundary_points(1,1)): ...  % All columns in between
                            round(boundary_points(2,1))), ...       
                        c_left , ...                                % Color at left boundary
                        c_right , ...                               % Color at right boundary
                        1 ...                                       % Horizontal interpolation
                    );

            end
    end       
    
    
    % Copy Image to result
    Y = img;
    return;

end
