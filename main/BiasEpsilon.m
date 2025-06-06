%   /* Calculation of BiasEpsilon (min { x >= 0 : 1 + x > 1 }) */
function out=BiasEpsilon
%   Current = 1.0;
%   OnePlusCurrent=2;
%   while (OnePlusCurrent > 1.0)
%      Last = Current;
%      Current=Current/2;
%      OnePlusCurrent = 1.0 + Current;
%      
%   end
%   out = Last;
out=eps;
end