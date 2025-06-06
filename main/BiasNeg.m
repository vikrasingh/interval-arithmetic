%{
NEGATION of an interval A, result will be -A 
%}
function out=BiasNeg(x)
 out=INTERVAL;
 out.inf= - x.sup;
 out.sup= - x.inf;

end