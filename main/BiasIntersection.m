%{
INTERSECTION
intersection of two disjoint intervals is undefined
Intersection(A,B) = 
%}
function out=BiasIntersection(x,y)
       n=max(length(x),length(y));
       if n==1      % x and y both are intervals
          out=INTERVAL;
          if x.sup<y.inf || x.inf>y.sup
%              disp('Error: Intervals are disjoint');
             return
          end
          if x.inf>y.inf
             out.inf=x.inf;
          else
             out.inf=y.inf;
          end
          if x.sup<y.sup
             out.sup=x.sup; 
          else
             out.sup=y.sup; 
          end
          
       else % when x and y both are interval vectors
           
          out=intervalVec(n);
          for i=1:n
              out(i)=BiasIntersection(x(i),y(i));
          end
          
           
      end

end