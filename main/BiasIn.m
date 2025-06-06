%{
[out]=BiasIn(x,y) , x can be a point or an interval and y is always an interval
out=1 if x is contained in y
out=0 if not
%}
function [out]=BiasIn(x,y)
  out=0;
  if isa(x,'INTERVAL')==0   % x is a real scalar
      if x>=y.inf && x<=y.sup
         out=1;
      end
      return
  else         % if x is an interval
      if x.inf>=y.inf && x.sup<=y.sup
          out=1;
      end
      
  end

end