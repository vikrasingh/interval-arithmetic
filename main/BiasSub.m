%{
 SUBTRACTION
subtraction of two INTERVALs is defined using the '-' operator overloading 
a - A = [a - A.sup , a - A.inf]
A - a = [A.inf - a , A.sup - a]
A - B = [A.inf - B.sup , A.sup - B.inf]
va-vb = [a-b , a-b ]
va-vB = [a-B.sup , a-B.inf]
vA-vb = [ A.inf-b , A.sup-b ]
vA-vB = [ A.inf-B.sup , A.sup-B.inf ]

%}
function out=BiasSub(x,y)
 n=max(length(x),length(y));
    if n==1
           out=INTERVAL;  % output is going to be an object of INTERVAL class
           if isfloat(x)==1 && isfloat(y)==0
              % case of a-A
        
              roundDown
              out.inf= x-y.sup;
              roundUp
              out.sup=x-y.inf;
              roundDefault;
        
           elseif isfloat(x)==0 && isfloat(y)==1
              % case of A-a
              roundDown
              out.inf=x.inf-y;
              roundUp
              out.sup=x.sup-y;
%             fprintf('[%f,%f]',out.inf,out.sup);
              roundDefault;
        
           elseif isfloat(x)==0 && isfloat(y)==0
              % case of A-B
              roundDown
              out.inf=x.inf-y.sup;
              roundUp
              out.sup=x.sup-y.inf;
%               fprintf('[%f,%f]',out.inf,out.sup);
              roundDefault;
           else
              disp('Error: Input arg. are not of correct format.');
           end
    else
        out=intervalVec(n); % define an empty interval of vectors of length n
        
        if isa(x,'INTERVAL')==0 && isa(y,'INTERVAL')==0
            % both x and y are real vectors
            roundDown
            for i=1:n
               out(i).inf=x(i)-y(i);
            end
            roundUp
            for j=1:n
            out(j).sup=x(j)-y(j);
            end
            roundDefault
            return
            
        end
        
        if isa(x,'INTERVAL')==0 && isa(y,'INTERVAL')==1
            %  x is a real vector and y is interval vector
            roundDown
            for i=1:n
               out(i).inf=x(i)-y(i).sup;
            end
            roundUp
            for j=1:n
            out(j).sup=x(j)-y(j).inf;
            end
            roundDefault
            return
            
        end
        
        if isa(x,'INTERVAL')==1 && isa(y,'INTERVAL')==0
            % x is an interval vector and y is real vector
            roundDown
            for i=1:n
               out(i).inf=x(i).inf-y(i);
            end
            roundUp
            for j=1:n
            out(j).sup=x(j).sup-y(j);
            end
            roundDefault
            return
            
        end
        
        if isa(x,'INTERVAL')==1 && isa(y,'INTERVAL')==1
            % both x and y are vector intervals
            roundDown
            for i=1:n
                out(i).inf=x(i).inf-y(i).sup;
            end
            roundUp
            for j=1:n
                out(j).sup=x(j).sup-y(j).inf;
            end
            roundDefault
            return
            
        end
        
    end

end