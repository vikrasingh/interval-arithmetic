%{
Sup gives us the supremum of the interval.
%}
function out=BiasSup(x)
     n=length(x);
    
    if n==1 && isa(x,'INTERVAL')==1  % if x is an interval  
       out=x.sup;
    elseif n>1 && isa(x,'INTERVAL')==1
             % if x is an interval vector
        out=ones(n,1);
        for i=1:n
            out(i)=x(i).sup;
        end
    else
        out=x; % if x is a real or real vector
    end  
 


end