function Y = paint_triangle_gouraud(img,vertices_2d,vertex_colors)
    Y = img;
    
    ykmin = zeros(1,3);
    ykmax = zeros(1,3);
    xkmin = zeros(1,3);
    xkmax = zeros(1,3);
    m = zeros(1,3);
    dx = zeros(1,3);
    dy = zeros(1,3);
    sgn = zeros(1,3);
    sum = zeros(1,3);
    for i = 1:3
        ykmin(i) = min(vertices_2d(i,2),vertices_2d(mod(i,3)+1,2));
        ykmax(i) = max(vertices_2d(i,2),vertices_2d(mod(i,3)+1,2));
        xkmin(i) = min(vertices_2d(i,1),vertices_2d(mod(i,3)+1,1));
        xkmax(i) = max(vertices_2d(i,1),vertices_2d(mod(i,3)+1,1));
        dx(i) = vertices_2d(i,1) - vertices_2d(mod(i,3)+1,1);
        dy(i) = vertices_2d(i,2) - vertices_2d(mod(i,3)+1,2);
        if dx(i)==0
            m(i) = 0;
        else
            m(i) = dy(i)/dx(i);
        end
        sgn(i) = sign(m(i));   
    end
    ymin = min(ykmin);
    ymax = max(ykmax);
    xmin = min(xkmin);
    
    dx = abs(dx);
    dy = abs(dy);
    
    
    py = (find(ismember(vertices_2d(:,2),ymin)));
    pre_actPoint = vertices_2d(py,:);
    pre_colors = vertex_colors(py,:);
    px = (find(ismember(vertices_2d(:,2),xmin)));
    if length(py)==3 && length(px)==3 
         
    end
    if length(py)==3
        if length(px)==3 %Paint if all points are the same one with the mean of all colors 
            Y(ymin,xmin,:) = mean(vertex_colors);
        else %All peaks same y(ymin)
            [vertices_2d,b] = sortrows(vertices_2d,(1));
            vertex_colors = vertex_colors(b,:);
            for x=vertices_2d(1,1):vertices_2d(2,1)
                color = vector_interp(vertices_2d(1,:),vertices_2d(2,:),[x,ymin],vertex_colors(1,:),vertex_colors(2,:),1);
                Y(ymin,x,:) = color;
            end
            for x=vertices_2d(2,1):vertices_2d(3,1)
                color = vector_interp(vertices_2d(2,:),vertices_2d(3,:),[x,ymin],vertex_colors(2,:),vertex_colors(3,:),1);
                Y(ymin,x,:) = color;
            end
        end
    elseif length(px)==3 %Vertical line
        [vertices_2d,id] = sortrows(vertices_2d,(2));
        vertex_colors = vertex_colors(id,:);
        for y=vertices_2d(1,2):vertices_2d(2,2)
            color = vector_interp(vertices_2d(1,:),vertices_2d(2,:),[xmin,y],vertex_colors(1,:),vertex_colors(2,:),2);
            Y(y,xmin,:) = color;
        end
        for y=vertices_2d(2,2):vertices_2d(3,2)
            color = vector_interp(vertices_2d(2,:),vertices_2d(3,:),[xmin,y],vertex_colors(2,:),vertex_colors(3,:),2);
            Y(y,xmin,:) = color;
        end        
    else
        if length(py)==2
            for x=min(pre_actPoint(1,1),pre_actPoint(2,1)):max(pre_actPoint(1,1),pre_actPoint(2,1))%paint base edge(first row)
                color = vector_interp(pre_actPoint(1,:),pre_actPoint(2,:),[x,ymin],pre_colors(1,:),pre_colors(2,:),1);
                Y(ymin,x,:) = color;
            end
            %find first active edges
            if py(1)==1
                if py(2)==2
                    actSides = [3 2];
                else
                    actSides = [1 2];
                end
            else
                actSides = [1 3];
            end
            %find first active points 
            first_actPoint = struct('x',{pre_actPoint(1,1)},'sideFrom',{actSides(1)});
            if dx(first_actPoint.sideFrom)~=0
                sum(first_actPoint.sideFrom) = sum(first_actPoint.sideFrom) + dx(first_actPoint.sideFrom);
                while sum(first_actPoint.sideFrom) >= dy(first_actPoint.sideFrom)
                    if dy(first_actPoint.sideFrom)~=0
                        first_actPoint.x = first_actPoint.x + sgn(first_actPoint.sideFrom);
                        sum(first_actPoint.sideFrom) = sum(first_actPoint.sideFrom) - dy(first_actPoint.sideFrom);
                    end
                end        
            end
            second_actPoint = struct('x',{pre_actPoint(2,1)},'sideFrom',{actSides(2)});
            if dx(second_actPoint.sideFrom)~=0
                sum(second_actPoint.sideFrom) = sum(second_actPoint.sideFrom) + dx(second_actPoint.sideFrom);
                while sum(second_actPoint.sideFrom) >= dy(second_actPoint.sideFrom)
                    if dy(second_actPoint.sideFrom)~=0
                        second_actPoint.x = second_actPoint.x + sgn(second_actPoint.sideFrom);
                        sum(second_actPoint.sideFrom) = sum(second_actPoint.sideFrom) - dy(second_actPoint.sideFrom);
                    end
                end
            end                    
        else
            Y(ymin,vertices_2d(py,1),:) = vertex_colors(py,:);%paint first point 
            %find first active edges 
            actSides = [py,mod(py+1,3)+1];
            %find first active points
            first_actPoint = struct('x',{pre_actPoint(1)},'sideFrom',{actSides(1)});
            if dx(first_actPoint.sideFrom)~=0
                sum(first_actPoint.sideFrom) = sum(first_actPoint.sideFrom) + dx(first_actPoint.sideFrom);
                while sum(first_actPoint.sideFrom) >= dy(first_actPoint.sideFrom)
                    if dy(first_actPoint.sideFrom)~=0
                        first_actPoint.x = first_actPoint.x + sgn(first_actPoint.sideFrom);
                        sum(first_actPoint.sideFrom) = sum(first_actPoint.sideFrom) - dy(first_actPoint.sideFrom);
                    end
                end
            end
            second_actPoint = struct('x',{pre_actPoint(1)},'sideFrom',{actSides(2)});
            if dx(second_actPoint.sideFrom)~=0
                sum(second_actPoint.sideFrom) = sum(second_actPoint.sideFrom) + dx(second_actPoint.sideFrom);
                while sum(second_actPoint.sideFrom) >= dy(second_actPoint.sideFrom)
                    if dy(second_actPoint.sideFrom)~=0
                        second_actPoint.x = second_actPoint.x + sgn(second_actPoint.sideFrom);
                        sum(second_actPoint.sideFrom) = sum(second_actPoint.sideFrom) - dy(second_actPoint.sideFrom);
                    end
                end
            end 
        end

        for y = ymin+1:ymax-1
            if first_actPoint.x > second_actPoint.x %sort actPoints
                temp = first_actPoint;
                first_actPoint = second_actPoint;
                second_actPoint = temp;
            end
            %find color of first active point
            switch first_actPoint.sideFrom
                case 1
                    Ck = vector_interp(vertices_2d(1,:),vertices_2d(2,:),[first_actPoint.x,y],vertex_colors(1,:),vertex_colors(2,:),2);
                case 2
                    Ck = vector_interp(vertices_2d(2,:),vertices_2d(3,:),[first_actPoint.x,y],vertex_colors(2,:),vertex_colors(3,:),2);
                case 3
                    Ck = vector_interp(vertices_2d(3,:),vertices_2d(1,:),[first_actPoint.x,y],vertex_colors(3,:),vertex_colors(1,:),2);
            end
            %find color of second active point
            switch second_actPoint.sideFrom
                case 1
                    Cl = vector_interp(vertices_2d(1,:),vertices_2d(2,:),[second_actPoint.x,y],vertex_colors(1,:),vertex_colors(2,:),2);
                case 2
                    Cl = vector_interp(vertices_2d(2,:),vertices_2d(3,:),[second_actPoint.x,y],vertex_colors(2,:),vertex_colors(3,:),2);
                case 3
                    Cl = vector_interp(vertices_2d(3,:),vertices_2d(1,:),[second_actPoint.x,y],vertex_colors(3,:),vertex_colors(1,:),2);
            end            
            for x=first_actPoint.x:second_actPoint.x
                %find color of each x
                color = vector_interp([first_actPoint.x,y],[second_actPoint.x,y],[x,y],Ck,Cl,1);
                Y(y,x,:) = color;
            end
                        
            %find each time new active points
            if sgn(first_actPoint.sideFrom)==0
                first_actPoint.x = first_actPoint.x;
            elseif dx(first_actPoint.sideFrom)~=0
                sum(first_actPoint.sideFrom) = sum(first_actPoint.sideFrom) + dx(first_actPoint.sideFrom);
                while sum(first_actPoint.sideFrom) >= dy(first_actPoint.sideFrom)
                    if dy(first_actPoint.sideFrom)~=0
                        first_actPoint.x = first_actPoint.x + sgn(first_actPoint.sideFrom);
                        sum(first_actPoint.sideFrom) = sum(first_actPoint.sideFrom) - dy(first_actPoint.sideFrom);
                    end
                end
            end
            if sgn(second_actPoint.sideFrom)==0
                second_actPoint.x = second_actPoint.x;
            elseif dx(second_actPoint.sideFrom)~=0
                sum(second_actPoint.sideFrom) = sum(second_actPoint.sideFrom) + dx(second_actPoint.sideFrom);
                while sum(second_actPoint.sideFrom) >= dy(second_actPoint.sideFrom)
                    if dy(second_actPoint.sideFrom)~=0
                        second_actPoint.x = second_actPoint.x + sgn(second_actPoint.sideFrom);
                        sum(second_actPoint.sideFrom) = sum(second_actPoint.sideFrom) - dy(second_actPoint.sideFrom);
                    end
                end
            end
            if ismember(y,ykmin) && ismember(y,ykmax) %%new actSide %%%% test before the correct is after 
                pn = (find(ismember(vertices_2d(:,2),y)));
                if ismember(pn,actSides)
                    actSides(actSides==pn) = mod(pn+1,3) + 1;
                    if first_actPoint.sideFrom==pn
                        first_actPoint.sideFrom = mod(pn+1,3) + 1;
                        first_actPoint.x = vertices_2d(vertices_2d(:,2)==y);%%%%
                    else
                        second_actPoint.sideFrom = mod(pn+1,3) + 1;
                        second_actPoint.x = vertices_2d(vertices_2d(:,2)==y);%%%%
                    end
                else
                    actSides(actSides==mod(pn+1,3) + 1) = pn;
                    if first_actPoint.sideFrom==mod(pn+1,3) + 1
                        first_actPoint.sideFrom = pn;
                        first_actPoint.x = vertices_2d(vertices_2d(:,2)==y);%%%%                        
                    else
                        second_actPoint.sideFrom = pn;
                        second_actPoint.x = vertices_2d(vertices_2d(:,2)==y);%%%%                        
                    end
                end
            end            
        end
        %paint last yscan
        pl = (find(ismember(vertices_2d(:,2),ymax)));
        last_actPoint = vertices_2d(pl,:);
        last_colors = vertex_colors(pl,:);
        if length(pl)==2
            for x=last_actPoint(1,1):last_actPoint(2,1)
                color = vector_interp(last_actPoint(1,:),last_actPoint(2,:),[x,ymax],last_colors(1,:),last_colors(2,:),1);
                Y(ymax,x,:) = color;
            end
        else
            Y(ymax,last_actPoint(1),:) = last_colors;
        end
    end
end
