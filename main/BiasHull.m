%{
##NOTE : BiasHull subroutine does not round down and round up the input arguments while forming the interval
class.

HULL function, it is defined in static methods because in the methods
section above we can only define functions which take atleast one input which is an object of
the class.
        Restricted to the use of two or less input arguments only
it can take the following input arguments 
NOTE: BiasHull(a,b) command does NOT take into account whether a<=b or not.

Hull(a) = [a , a]        
Hull(a,b) = [a , b]
Hull(a,A) = [a , A.sup] if a<A.inf
          = [A.inf , a] if a>A.sup
Hull(A,B) = A,B both are intervals
added on 3 July20
Hull(a,vb)= [a,b_i] for i=1:length(vb)
Hull(va,b)= [a_i,b] for i=1:length(va)
Hull(va,vb)= [a_i,b_i] for i=1: length(va) which should be = length(vb)
        
%}  
function out=BiasHull(x,varargin)
                
              
               
                switch nargin
                    case 1
                      n=length(x);  
                      if n==1 
                          out=INTERVAL;
                          if isfloat(x)==1
                             out.inf=x;
                             out.sup=x;
                             return
                          end
                      else
                          out=intervalVec(n);
                          for i=1:n
                              out(i)=BiasHull(x(i));
                          end
                      end  
                      return
                      
                    case 2
                      n=length(x);
                      m=length(varargin{1});  
                      if n==1 && m==1
                         out=INTERVAL;
                         if isfloat(x)==1 && isa(varargin{1},'INTERVAL')==0  % x and y both are real numbers
                            y=varargin{1};
                            out.inf=x;
                            out.sup=y;
                            return
                         end
                      
                         if isfloat(x)==1 && isa(varargin{1},'INTERVAL')==1 % x is a real number and y is an interval
                            y=varargin{1};
                            if x<y.inf
                               out.inf=x;
                            else
                               out.inf=y.inf;
                            end
                            if x>y.sup
                               out.sup=x;
                            else
                               out.sup=y.sup;
                            end
                            return
                         end
          
                         if isfloat(x)==0 && isfloat(varargin{1})==0 % x and y are intervals
                            y=varargin{1};
                            if x.inf<y.inf
                               out.inf=x.inf;
                            else
                               out.inf=y.inf;
                            end
              
                            if x.sup>y.sup
                               out.sup=x.sup;
                            else
                               out.sup=y.sup;
                            end
                            return
                            
                         end
                      
                      
                      elseif n==1 && m>1
                         if isfloat(x)==1 && isfloat(varargin{1})==1   % when x is a real number and y is a real vector
                            out=intervalVec(m);
                            for i=1:m
                                out(i)=BiasHull(x,varargin{:}(i)); 
                            end
                            return
                         end
                    
                      
                      elseif n>1 && m==1
                         if isfloat(x)==1 && isfloat(varargin{1})==1   % when x is a real vector and y is a real number.
                            out=intervalVec(n);
                            for i=1:n
                                out(i)=BiasHull(x(i),varargin{:}); 
                            end
                            return
                         end
                      
                      elseif n>1 && m>1 && n==m 
                           % when x and y are real vectors of equal length
                           % when x is a real vec and y is an interval vec or when x is an interval and y is a
                           % real vec
                           % when both x and y are interval vectors of equal length
                            out=intervalVec(m);
                            for i=1:n
                                out(i)=BiasHull(x(i),varargin{:}(i)); 
                            end
                            return
                         
                      else
                          disp('Error in BiasHull: the format of the input arg. is not correct.');
                          return
                      end
                end

end