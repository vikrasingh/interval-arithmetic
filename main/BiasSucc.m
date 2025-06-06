%{
Succ function, to find the successor of a number or an interval       
Succ(a)=b where b is the largest no. such that b>a   
Succ(A)=B where B is the largest interval such that B.inf<A.inf and A.sup<B.sup     
Succ(va)=vb
Succ(vA)=vB where vB contains the smallest intervals containing resp. intervals of vA 

%}
function out=BiasSucc(x)

if isfloat(x)==1 && isa(x,'INTERVAL')==0  % if x is a real no.
    
    roundUp;
    out=x+realmin;
    roundDefault;
    return
    
elseif isfloat(x)==0 && isa(x,'INTERVAL')==0 % if x is a vector of reals.
    
    roundUp;
    out=x+realmin;
    roundDefault;
    return
    
    
elseif isfloat(x)==1 && isa(x,'INTERVAL')==1  % if x is an interval
    out=INTERVAL;
    roundDown;
    out.inf=x.inf-realmin;
    roundUp;
    out.sup=x.sup+realmin;
    roundDefault;
    return
    
elseif isfloat(x)==0 && isa(x,'INTERVAL')==1  % if x is a vector of intervals.
    
    n=length(x);
    out=intervalVec(n);
    roundDown;
    for i=1:n
        out(i).inf=x(i).inf-realmin;
    end
    roundUp
    for j=1:n
        out(j).sup=x(j).sup+realmin;
    end
    roundDefault;
   
end
end