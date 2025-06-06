%{
Dist 
function to find the distance between an interval and real no. or two
intervals , give the input in the following ways.
Dist(a,A)= inf A - a  if a< inf B
         = a - sup B  if a> sup B
Dist(A,B)= max(abs(inf A - inf B) , abs(sup A - sup B))  check this ?
%}
function out=BiasDist(x,y)
    if isfloat(x)==1 && isfloat(y)==0 % x is a number and y is an interval
        if x<y.inf
            out=y.inf - x;
        elseif x>y.sup
            out=x - y.sup;
        end
        
    elseif isfloat(x)==0 && isfloat(y)==0  % both x and y are intervals
        
        out=max(abs(x.inf - y.inf) , abs(x.sup - y.sup));
        
        
    end


end