function  out=BiasSin(x)
%{
 BiasSin(A) will give the sin values of some interval A
%}
 
 if BiasDiam(x)>= 2*pi 
		out=BiasHull(-1,1);
		return;
 end

%   Reduction of x to [0, 2Pi] 
	getInterval=ScaleTo2Pi(x);    % ScaleTo2Pi is a subroutine 
    x_inf=getInterval.inf;
    x_sup=getInterval.sup;
    
 if (x_sup >= x_inf + 2*pi) 
        out=BiasHull(-1,1);
		return;
 end
 
 %{
       x_inf, x_sup are now in the range [0, 2Pi]
	 * Quadrants:
	 *  0 = [0,Pi/2]
	 *  1 = [Pi/2,Pi]
	 *  2 = [Pi,3Pi/2]
	 *  3 = [3Pi/2,2Pi]
 %}
	
	q_inf = Quadrant(x_inf);      % Quadrant is a subroutine defined below
	q_sup = Quadrant(x_sup);

    if (q_inf == q_sup) && (BiasSup(x) > BiasInf(x) + pi) 
		out=BiasHull(-1,1);
		return;
    end

    q_sup=bitsll(q_sup,2);
    
 switch (q_sup + q_inf)
	
	
	case {0,3,15}
        roundDown
		y_inf = sin(x_inf);
        roundUp
		y_sup = sin(x_sup);
	
    
	case {1,14}
		y_inf = -1.0;
        roundUp
		x_inf = sin(x_inf);
		x_sup = sin (x_sup);
		y_sup = max(x_inf, x_sup);
		
	case 2
		y_inf = -1.0;
        roundUp
		y_sup = sin(x_sup);
		
		
	
	case {4,11}
		y_sup = 1.0;
        roundDown
		x_inf = sin(x_inf);
		x_sup = sin (x_sup);
		y_inf = min(x_inf, x_sup);
		
	
	case {5,9,10}
        roundUp
		y_sup = sin(x_inf);
        roundDown
		y_inf = sin(x_sup);
        
	
	case {6,12}
		y_inf = -1.0; y_sup = 1.0; 
	case 7
		y_sup = 1.0;
        roundDown
		y_inf = sin(x_inf);
		
	case 8
		y_sup = 1.0;
        roundDown
		y_inf = sin(x_sup);
		
	case 13
		y_inf = -1.0;
        roundUp
		y_sup= sin(x_inf);
		
 end
    
    if y_inf < -1.0
        y_inf = -1.0;	% don't overestimate 
    end
    
    if y_sup > 1.0 
        y_sup = 1.0;	        % dto.  
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
    
