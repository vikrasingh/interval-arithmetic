%{
DIAMETER
diam(A)=A.sup-A.inf
%}
function out=BiasDiam(x)
   % x can be an interval or a vector of intervals
      roundUp
      out=x.sup-x.inf;
      roundDefault;
      return;

end