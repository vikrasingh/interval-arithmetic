%{
BiasPowerN to find the nth power of an interval
 BiasPowerN(A,n)=A^n       where n is an integer and A an interval
%}
function out=BiasPowerN(x,n) % x is an interval and n is the interger we want x to raise to
   m=length(x);
   if m==1
           out=INTERVAL;
           absn=abs(n);  % find the mod of n
           if absn>=2   % if n>=2
              xsqr=BiasSqr(x);  % square the interval 
              if rem(absn,2)==1   % if n is an odd integer
                 y=BiasMul(xsqr,x);  % y=x^3
              else
                 y=xsqr; % if n is even, y=x^2
              end
              for i=3:2:(absn-1)   
                  z=y;
                  y=BiasMul(z,xsqr);
              end
           elseif rem(absn,2)==1  % case when n=1
              y=x;
           else         % case when n=0 
              y=BiasHull(1);
           end
   
           if n<0
              out=BiasDiv(1,y);
           else
              out=y;
           end
   elseif m>1
          % 24 Mar20
          out=intervalVec(m);
          for i=1:m
              out(i)=BiasPowerN(x(i),n);
          end
          
   end
end