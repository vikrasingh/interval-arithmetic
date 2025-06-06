%{
BiasPowerI , to find an interval raise to power another interval
BiasPowerI(A,B)=A^(B) , where A and B are intervals.

%}
function out=BiasPowerI(x,y) % where both x and y are intervals
  x_inf=BiasInf(x);
  x_sup=BiasSup(x);
  if x_inf<0
      disp('Power: Base is negative.');
  end
  
  if x_inf==0
      if BiasInf(y)<=0
          disp('Power: Negative or zero exponent with zero base.');
          return;
      elseif BiasSup(x)==0
          out=BiasHull(0);
          return;
      else
          t2=BiasHull(x_sup);
          t1=BiasLog(t2);
      end
      
  else
       t1=BiasMul(x); 
  end
  t2=BiasMul(t1,y); 
  
  if x_inf==0
      t1=BiasExp(t2);
      out=BiasHull(0,t1);
  else
      out=BiasExp(t2);
  end
  
end