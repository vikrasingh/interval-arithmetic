%{
to find the square root of an interval, return an interval
%}
function out=BiasSqrt(x)  % input x an interval
 if BiasInf(x)<0
     disp('Error: argument is a negative Interval.');
     out=[];
     return
 else
     roundDown
     y_inf=sqrt(BiasInf(x));
     roundUp
     y_sup=sqrt(BiasSup(x));
     if y_inf<0
         y_inf=0;
     end
     out=BiasHull(y_inf,y_sup);
 end
 
end