%{ 
 ADDITION 
 Firstly define the INTERVAL addition using the '+' operator overloading
 input of plus function can be a double and an INTERVAL or both INTERVALs.  
 From now on lower case represent a double variable and upper case letter
 represents an INTERVAL.

 a + A = [a+A.inf , a+A.sup] 
 A + a = [A.inf+a , A.sup+a]
 A + B = [A.inf+B.inf , A.sup+B.sup]
 va+vb = [ a+b , a+b] here a and b are real vectors
 a +vB = [a+v_i.inf, a+v_i.sup] for i=1,...
 vA+ b = [v_i.inf+b, v_i.sup+b] for i=1,...
 va+vB = [ a+B.inf , a+B.sup ]
 vA+vb = [ A.inf+b , B.sup+b ]
 vA+vB = [ A.inf+B.inf , A.sup+B.sup ]
 A +vB = [ A.inf+B_i.inf , A.sup+B_i.sup] for i=1,...
 vA+ B = [ A_i.inf+B.inf , A_i.sup+B.sup] for i=1,...
%}
function [out]=BiasAdd(x,y)
       n=length(x);
       m=length(y);
    if n==1 && m==1
          out=INTERVAL; % the output is going to be an object of the INTERVAL class only
        
          if isfloat(x)==1 && isfloat(y)==0 
             % first arg double and second INTERVAL  
                         
             roundDown;
             out.inf=x+y.inf;
             roundUp;            
             out.sup=x+y.sup;
             roundDefault;
          elseif isfloat(x)==0 && isfloat(y)==1
             % first INTERVAL and second double
      
             roundDown;
             out.inf=x.inf+y;
             roundUp;
             out.sup=x.sup+y;
             roundDefault;
       
          elseif isfloat(x)==0 && isfloat(y)==0
             % both are INTERVALs
             roundDown;
             out.inf=x.inf+y.inf;
             roundUp;
             out.sup=x.sup+y.sup;
             roundDefault;
          else
              disp('Error in BiasAdd: input arg. are not of correct format.'); 
          end
          
    else
        
        if n>1 && isa(x,'INTERVAL')==0 && m>1 && isa(y,'INTERVAL')==0 && n==m
           % both x and y are vectors of real.
           out=intervalVec(n);  % define out to be a vector of intervals
           
           roundDown
           for i=1:n
               out(i).inf=x(i).inf+y(i).inf;
           end
           roundUp
           for j=1:n
               out(j).inf=x(j).inf+y(j).inf;
           end
           roundDefault
           return
           
        elseif n==1 && isa(x,'INTERVAL')==0 && m>1 && isa(y,'INTERVAL')==1 
           % when x is a real no. and y an interval vector.
           out=intervalVec(m);  % define out to be a vector of intervals
           
           roundDown
           for i=1:m
               out(i).inf=x+y(i).inf;
           end
           roundUp
           for j=1:m
               out(j).inf=x+y(j).sup;
           end
           roundDefault
           return   
           
        elseif n>1 && isa(x,'INTERVAL')==1 && m==1 && isa(y,'INTERVAL')==0 
           % when x is an interval vector and y is a real no. 
           out=intervalVec(n);  % define out to be a vector of intervals
           
           roundDown
           for i=1:n
               out(i).inf=x(i).inf + y;
           end
           roundUp
           for j=1:n
               out(j).inf=x(j).sup + y;
           end
           roundDefault
           return    
           
        elseif n>1 && isa(x,'INTERVAL')==0 && m>1 && isa(y,'INTERVAL')==1 && n==m
            % when x is a real vector and y is vector of intervals.
            out=intervalVec(n);  % define out to be a vector of intervals
            roundDown
            for i=1:n
                out(i).inf=x(i)+y(i).inf; 
            end
            roundUp
            for j=1:n
                out(j).sup=x(j)+y(j).sup;
            end
            roundDefault
            return
            
        elseif n>1 && isa(x,'INTERVAL')==1 && m>1 && isa(y,'INTERVAL')==0 && n==m
            % when x is an interval vector and y is vector of reals.
            out=intervalVec(n);  % define out to be a vector of intervals
            roundDown
            for i=1:n
                out(i).inf=y(i)+x(i).inf; 
            end
            roundUp
            for j=1:n
                out(j).sup=y(j)+x(j).sup;
            end
            roundDefault
            return    
        
        elseif n==1 && isa(x,'INTERVAL')==0 && m>1 && isa(y,'INTERVAL')==1
            % when x is a real and y is vector of intervals.
            out=intervalVec(m);  % define out to be a vector of intervals
            roundDown
            for i=1:m
                out(i).inf=x+y(i).inf; 
            end
            roundUp
            for j=1:m
                out(j).sup=x+y(j).sup;
            end
            roundDefault
            return   
        
        elseif n>1 && isa(x,'INTERVAL')==1 && m==1 && isa(y,'INTERVAL')==0
            % when x is an interval vector and y is real.
            out=intervalVec(n);  % define out to be a vector of intervals
            roundDown
            for i=1:n
                out(i).inf=y+x(i).inf; 
            end
            roundUp
            for j=1:n
                out(j).sup=y+x(j).sup;
            end
            roundDefault
            return
            
        elseif n>1 && isa(x,'INTERVAL')==1 && m>1 && isa(y,'INTERVAL')==1 && n==m
            % both x and y are interval vectors 
            out=intervalVec(n);  % define out to be a vector of intervals
            roundDown
            for i=1:n
                out(i).inf=x(i).inf+y(i).inf;
            end
            roundUp
            for j=1:n
                out(j).sup=x(j).sup+y(j).sup;
            end
            roundDefault
            return
            
        elseif n==1 && isa(x,'INTERVAL')==1 && m>1 && isa(y,'INTERVAL')==1 
            % both x is an interval and y is interval vector 
            out=intervalVec(m);  % define out to be a vector of intervals
            roundDown
            for i=1:m
                out(i).inf=x.inf+y(i).inf;
            end
            roundUp
            for j=1:m
                out(j).sup=x.sup+y(j).sup;
            end
            roundDefault
            return
            
        elseif n>1 && isa(x,'INTERVAL')==1 && m==1 && isa(y,'INTERVAL')==1 
            % both x is an interval vector and y is an interval
            out=intervalVec(n);  % define out to be a vector of intervals
            roundDown
            for i=1:n
                out(i).inf=x(i).inf+y.inf;
            end
            roundUp
            for j=1:n
                out(j).sup=x(j).sup+y.sup;
            end
            roundDefault
            return   
          
        elseif n==1 && isa(x,'INTERVAL')==1 && m>1 && isa(y,'INTERVAL')==1 
            % x is an interval and y is an interval vector.
            out=intervalVec(m);  % define out to be a vector of intervals
            roundDown
            for i=1:m
                out(i).inf=x.inf+y(i).inf;
            end
            roundUp
            for j=1:m
                out(j).sup=x.sup+y(j).sup;
            end
            roundDefault
            return      
            
        elseif n>1 && isa(x,'INTERVAL')==1 && m==1 && isa(y,'INTERVAL')==1 
            %  x is an interval vector and y is an interval.
            out=intervalVec(n);  % define out to be a vector of intervals
            roundDown
            for i=1:n
                out(i).inf=x(i).inf+y.inf;
            end
            roundUp
            for j=1:n
                out(j).sup=x(j).sup+y.sup;
            end
            roundDefault
            return      
            
        else
            disp('Error: Input arg. are not of correct format.');
        end
    end

end