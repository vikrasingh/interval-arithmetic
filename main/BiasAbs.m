%{
BiasAbs will return the absolute value of an interval,as a scalar.
%}
function out=BiasAbs(x)
  infabs=abs(x.inf);
  supabs=abs(x.sup);
  if infabs<supabs
      out=supabs;
  else
      out=infabs;
  end
end