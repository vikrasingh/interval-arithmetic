%{
BiasEqual(x,y) input x and y as interval,
returns 1 if x=y otherwise 0
%}
function [out]=BiasEqual(x,y)
     out=0;
    if x.inf==y.inf && x.sup==y.sup
        out=1;
    end
    
end