%{
MIDPOINT ,to find the midpoint of an INTERVAL
mid(A) = A.inf + (A.sup-A.inf)/2;
%}
function out=BiasMid(x)
   n=length(x);
   if n==1
      roundUp
      out= Inf(x) + (Sup(x)-Inf(x))/2;
      roundDefault
   else
      out=ones(n,1); 
      roundUp
      for i=1:n
          out(i)=Inf(x(i)) + (Sup(x(i))-Inf(x(i)))/2;
      end
   end
end