%{
BiasRoot(A,n)= A^(1/n) where A is an interval and n is an integer which is the nth root.
%}
function out=BiasRoot(x,n) % x is an interval and n is the nth-root that we want to take.
   if n<2
       disp('Error in BiasRoot: n must be >=2.');out=[];
       return
   elseif BiasInf(x)<0
       disp('Error in BiasRoot: arg. must be >=0.');out=[];
       return
   end
   inf_is_zero=1; % need to initiate this var.
   tn=n;
   intvalOne=BiasHull(1);
   
   t1=BiasDiv(intvalOne,tn);
   if BiasInf(x)==0
       inf_is_zero=0;
       supremum=BiasSup(x);
       if supremum==0
           out=BiasHull(0);
           return
       end
       t3=BiasHull(supremum);
       t2=BiasLog(t3);
   else
       t2=BiasLog(x);
   end
   
   t3=BiasMul(t1,t2);
   
   if inf_is_zero==0
      t2=BiasExp(t3);
     out=BiasHull(0,t2);
   else
     out=BiasExp(t3);
   end
   


end