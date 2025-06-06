%{
BIASDIFF
13 Dec20, to define a special interval subtraction
A - B =[ A.inf-B.inf , A.sup-B.sup]
vA - vB =[ A_i.inf-B_i.inf , A_i.sup-B_i.sup ]
%}

function out=BiasDiff(x,y)
n=max(length(x),length(y));
   if n==1
      out=INTERVAL;
      if isfloat(x)==0 && isfloat(y)==0
         % case of A - B where both A and B are intervals
         
         roundDown
         out.inf= x.inf-y.inf;
         roundUp
         out.sup=x.sup-y.sup;
         roundDefault;
         
      end
      if out.inf>out.sup
         z=INTERVAL;
         z.sup=out.inf;
         z.inf=out.sup;
         out=z;
      end
      
   elseif n>1
       % case of vA - vB
       out=intervalVec(n);
       for i=1:n
           out(i)=BiasDiff(x(i),y(i));
       end
       
   else
       disp('Error in BiasDiff: Input arg are not of correct format.');
       
   end


end