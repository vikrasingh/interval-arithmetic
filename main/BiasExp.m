
function out=BiasExp(x) % x is an interval
 roundDown
  y_inf= exp(BiasInf(x));
  roundUp
  y_sup= exp(BiasSup(x));
  if y_inf < 0
      y_inf=0;
  end
  out=BiasHull(y_inf,y_sup);
end