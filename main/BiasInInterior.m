%{
[out]=BiasInInterior(x,y) , x can be a point or an interval and y is always an interval
out=1 if x is contained in interior of y
out=0 if not
%}
function [out]=BiasInInterior(x,y)
     out=0;
     n=length(x);m=length(y);
     if n==1 && m==1
        if isa(x,'INTERVAL')==0   % x is a real scalar
           if x>y.inf && x<y.sup
              out=1;
           end
           return
        else         % if x is an interval
           if x.inf>y.inf && x.sup<y.sup
              out=1;
           end
           return
        end
     elseif n>1 && m>1 && n==m
        if isa(x,'INTERVAL')==0 && isa(y,'INTERVAL')==1   % x is a real vector and y is an interval vec  
            for i=1:n
                if x(i)<Sup(y(i)) && Inf(y(i))<x(i)
                   out=1; 
                else
                    out=0; return
                end
            end
        elseif isa(x,'INTERVAL')==1 && isa(y,'INTERVAL')==1 % both x and y are interval vec
            for i=1:n
                if Inf(y(i))<Inf(x(i)) && Sup(x(i))<Sup(y(i))
                   out=1; 
                else
                    out=0; return
                end
            end
        end
     end
end