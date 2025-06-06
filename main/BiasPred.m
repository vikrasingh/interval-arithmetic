%{
Pred function, to find the predecessor of a number or an interval       
Pred(a)=b where b is smallest no. such that b<a   
Pred(A)=B where is the largest interval such that A.inf<B.inf and B.sup<A.sup   
Pred(va)=vb where bv vector is the Pred of av 
Pred(vA)=vB where Av and Bv are interval vectors
If A is a vector of intervals then Pred(A)=B will return B as vector of intervals
 such that each interval in B is the largest interval contained in respective intervals of A 
%} 
function  out=BiasPred(x)

if isfloat(x)==1 && isa(x,'INTERVAL')==0    % if x is a real no.
    
    roundDown;
    out=x-realmin;
    roundDefault;
    return
    
elseif isfloat(x)==0 && isa(x,'INTERVAL')==0   % if x is a vector of reals.
    
    roundDown;
    out=x-realmin;
    roundDefault;
    return
    
elseif isfloat(x)==1 && isa(x,'INTERVAL')==1  % if x is a scalar interval
    out=INTERVAL;
    roundDown;
    out.sup=x.sup-realmin;
    roundUp;
    out.inf=x.inf+realmin;
    roundDefault;
    return
    
elseif isfloat(x)==0 && isa(x,'INTERVAL')==1  % x is a vector of intervals
    
    
    n=length(x);
    out=intervalVec(n);  % out is initialized as a row vector of empty intervals of length n
    roundDown;
    for i=1:n
        out(i).sup=x(i).sup-realmin;
    end
    roundUp;
    for j=1:n
        out(j).inf=x(j).inf+realmin;
    end
    roundDefault;
    return
end



end