%{
BiasSqr to square an interval x
%}
function out=BiasSqr(x)
  
  t1=BiasIAbs(x);
  out=BiasMul(t1,t1);
   
end