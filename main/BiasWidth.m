%{
BiasWidth function for an interval or interval vector X returns max of the width of all
its elements.
BiasWidth(X)= max BiasWidth(X_i);
%}
function out=BiasWidth(x)
   n=length(x);
   if n==1     % if x is just one interval
      out=BiasDiam(x); 
      return
   else   % if x is an interval vector
       out=BiasDiam(x(1));
       for i=2:n
           if out<BiasDiam(x(i))
              out=BiasDiam(x(i)); 
           end
       end
   end

end
