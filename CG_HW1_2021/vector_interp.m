function value = vector_interp(p1,p2,a,V1,V2,dim)
    if dim==1 %% dim==1 horizontal interpolation(x)
        if (p2(1)-p1(1))==0
            value = 0.5*V1 + 0.5*V2;
        else
            s = abs((p2(1)- a(1))/(p2(1)-p1(1)));
            value = s*V1 + (1-s)*V2;
        end        
    elseif dim==2 %% dim==2 vertical interpolation(y)
        if (p2(1)-p1(1))==0
            value = 0.5*V1 + 0.5*V2;
        else
            s = abs((p2(2)- a(2))/(p2(2)-p1(2)));
            value = s*V1 + (1-s)*V2;
        end   
    end    
end