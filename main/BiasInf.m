%{
Inf function to find the infimum of the given interval
%}
function out=BiasInf(x)
    n=length(x);
    
    if n==1 && isa(x,'INTERVAL')==1  % if x is an interval  
       out=x.inf;
    elseif n>1 && isa(x,'INTERVAL')==1 
             % if x is an interval vector
        out=ones(n,1);
        for i=1:n
            out(i)=x(i).inf; 
        end
    end


end