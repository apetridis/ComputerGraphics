% Author: 
%   Konstantinos Chatzis
%   kachatzis <at> ece.auth.gr
%
%   Computer Graphics
%   Project 1
%   25/3/2021

%% Update Scan Line
% Updates active edges and boundary points for a given line (y)
% and sorts the resulting arrays to fit the 'flat' and 'gouraud'
% algorithms. This takes care of illegal shapes.
function [active_edges, boundary_points] = update_scan_line(y, active_edges, boundary_points, vertices_2d, slope, ykmin, ykmax, xkmin, xkmax, y_min, y_max)

    %% Update Coordinates

    % Update coordinates on boundaries 
    % from the previous scanline
    for i = 1 : size(boundary_points, 1)
        % If there is an active edge
        if active_edges(i)
            % Add the inverse of the edge slope to the x coordinate.
            boundary_points(i,1) = boundary_points(i,1) + 1/slope( active_edges(i) );
            % Increment the y coordinate.
            boundary_points(i,2) = boundary_points(i,2) + 1;
        end
    end
    
    %% Add / Remove Edges

    for j=1:3  % For each edge in the triangle

        % Starting Vertex = j
        % Find ending vertex
        next_vertex = next(j,3);

        %% Add Edges
        % If the edge j secants (crosses) this scan line (y),
        % Add it to the active edges and boundary points
        if y == ykmin(j)

            if isnan(slope(j))
                %% Undefined Edge
                % dont add it as active
                % dont add a boundary point
            elseif slope(j) == 0
                %% Horizontal Edge
                % dont add it as active
                % dont add a boundary point
            elseif slope(j) == inf || slope(j) == -inf
                %% Vertical Edge

                % Add Active Edge
                active_edges = [active_edges j];

                % Get edge position
                [tmp pos] = size(active_edges);

                if slope(j) > 0
                    % upwards edge
                    boundary_points(pos,:) = vertices_2d(j,:);
                else
                    % downwards edge
                    boundary_points(pos,:) = vertices_2d(next_vertex,:);
                end
            
            else
                %% Ordinary Edge
                % edge is neither vertical or horizontal

                % Add Active Edge
                active_edges = [active_edges j];

                % Get edge position
                [tmp pos] = size(active_edges);

                % Add edge's lowest vertex to boundary points
                % in the same row as column in active edges
                if slope(j) > 0  % edge increasing

                    if vertices_2d(j,1) < vertices_2d(next_vertex,1)
                        % north-east edge
                        % lowest point is the start
                        boundary_points(pos,:) = vertices_2d(j,:);
                    else
                        % south-west edge
                        % lowest point is the end
                        boundary_points(pos,:) = vertices_2d(next_vertex,:);
                    end
                else            % edge decreasing

                    if vertices_2d(j,1) < vertices_2d(next_vertex,1)
                        % south-east edge
                        % lowest point is the end
                        boundary_points(pos,:) = vertices_2d(next_vertex,:);
                    else
                        % north-west edge
                        % lowest point is the start
                        boundary_points(pos,:) = vertices_2d(j,:);
                    end
                end

            end

        end

        % If edge j stops at the previous scan line (y),
        % remove it from the active edges and boundary points
        if y == ykmax(j) && y ~= y_max
            %% Remove Edges

            % locate the edge to be removed
            edge_pos = ( active_edges == j );

            % Remove j from active edges
            active_edges( edge_pos ) = [];

            % Remove edge j from boundary points
            boundary_points ( edge_pos , : ) = []; 

        end

    end

    %% Sort Edges
    
    % Sort Bounadry points and Active Edges
    % on ascending order based on x
    if active_edges
        [boundary_points, sortIdx] = sortrows (boundary_points, 1 );
        active_edges = active_edges (sortIdx);
    end

end
