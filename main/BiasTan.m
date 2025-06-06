%{
BiasTan of some interval
%}
function out=BiasTan(x)

if BiasDiam(x)>= (2*pi)
    out=BiasHull(-Inf,+Inf); 
    return
end

%   Reduction of x to [0, 2Pi] 
getInterval=ScaleTo2Pi(x);
x_inf=getInterval.inf;
x_sup=getInterval.sup;
if x_sup >= (x_inf+ 2*pi) 
    out=BiasHull(-Inf,+Inf);
    return
end

%{ 
 x_inf, x_sup are now in the range [0 , 2pi]
     * Quadrants:
	 *  0 = [0,Pi/2]
	 *  1 = [Pi/2,Pi]
	 *  2 = [Pi,3Pi/2]
	 *  3 = [3Pi/2,2Pi]
%}

q_inf = Quadrant(x_inf);
q_sup = Quadrant(x_sup);

if (q_inf==q_sup) && (x_sup > (x_inf+pi))
    out=BiasHull(-Inf,+Inf);
    return
end

q_sup=bitsll(q_sup,2);

switch (q_sup+q_inf)
    case {0,3,5,9,10,15}
        roundDown
        y_inf=tan(x_inf);
        roundUp
        y_sup=tan(x_sup);
    otherwise
        y_inf=-Inf;
        y_sup=+Inf;
    
end
out=BiasHull(y_inf,y_sup);




end

%% Quadrant function which is the subroutine of the above function
function getQuadrantNum=Quadrant(x) % x is in [0,2pi]
  if x<= (pi/2)
     getQuadrantNum=0; return
  elseif x<= pi
      getQuadrantNum=1; return
  elseif x<= (pi + (pi/2))
      getQuadrantNum=2; return
  else
      getQuadrantNum=3;
  end
end 