%{
BiasIAbs will return the absolute value of an interval as an interval.
BiasIAbs(A)= { |x| : x in A };
A can be an interval, an array of intervals or a matrix of intervals.
%}
function out=BiasIAbs(x)
 [m,n]=size(x);
 if m==1 && n==1
    if isa(x,'INTERVAL')==0 % means x is a floating point, or an array 
        out=abs(x);return
    elseif BiasInf(x)>0
       out=x;return
    elseif BiasSup(x)<0
       out=BiasNeg(x);return
    else
       t=BiasAbs(x);
       out=BiasHull(0,t);return
    end
    
 elseif m==1 || n==1  % row vector or column vector case
     l=length(x);
     out=intervalVec(l);
     for i=1:l
         out(i)=BiasIAbs(x(i)); 
     end
     return
     
 elseif m>1 && n>1  % x is a matrix of intervals
     out=intervalMatrix(m,n);
     for i=1:m
         for j=1:n
             out(i,j)=BiasIAbs(x(i,j)); 
         end
     end
     return
 end
end