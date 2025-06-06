%   /* Calculation of BiasEta     (min { x > 0 }) */
function out=BiasEta
 

%   Current = BiasEpsilon;
    Current = eps;
  while (Current > 0.0)
    Last = Current;
    Current=Current/2;
  end
  out = Last;
  
end