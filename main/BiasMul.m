%{
MULTIPLICATION
perform multiplication using the operator '*' 
we can insert the input using the following formats

a*A = [a*A.BiasInf , a*A.BiasSup] if a>=0
a*A = [a*A.BiasSup , a*A.BiasInf] if a<0
A*B = there are 9 different cases for this 
a*vb =[a*b , a*b]
A*vb = Interval times a real vector
a*vB = scalar a times interval vector
A*vB = an interval times vector interval
va'*vB or va*vB or vA'*vb or vA*vb = a scalar vector times an interval vectors

vA'*vB or vA*vB = an interval vector times an interval vector


%}
function out=BiasMul(x,y)
  
  n=length(x);
  m=length(y);
  
  if n==1 && m==1
          out=INTERVAL;
        if isfloat(x)==1 && isfloat(y)==0
            % case of a*A

            if x>=0 % subcase 1 
               roundDown
               out.inf=x*y.inf;
               roundUp;
               out.sup=x*y.sup;
               roundDefault;
               return
            else % subcase when x<0
               roundDown;
               out.inf=x*y.sup;
               roundUp;
               out.sup=x*y.inf; 
               roundDefault;
               return
            end

        elseif isfloat(x)==0 && isfloat(y)==0
            % case A*B both are INTERVALs
            % check p13 of  INTERVAL Anal. by Moore,..
               
            if -realmin<=(x.inf) && -realmin<=(y.inf)  % subcase 1
                roundDown;
                out.inf=x.inf*y.inf;
                roundUp;
                out.sup=x.sup*y.sup;
                roundDefault;
                return

            elseif ((x.inf) < -realmin) && (realmin < (x.sup)) && (-realmin < (y.inf) || -realmin==(y.inf)) % subcase 2
                roundDown;
                out.inf=x.inf*y.sup;
                roundUp;
                out.sup=x.sup*y.sup;
                roundDefault;
                return

            elseif x.sup<=(realmin) && -realmin<=(y.inf) % subcase 3
                roundDown;
                out.inf=x.inf*y.sup;
                roundUp;
                out.sup=x.sup*y.inf;
                roundDefault;
                return

            elseif -realmin<=x.inf && y.inf<-realmin && realmin<y.sup % subcase 4
                roundDown;
                out.inf=x.sup*y.inf;
                roundUp;
                out.sup=x.sup*y.sup;
                roundDefault;
                return

            elseif x.sup<=realmin && y.inf<-realmin && realmin<y.sup % subcase 5
                roundDown;
                out.inf=x.inf*y.sup;
                roundUp;
                out.sup=x.inf*y.inf;
                roundDefault;
                return

            elseif -realmin<=x.inf && y.sup<=realmin % subcase 6
                roundDown;
                out.inf=x.sup*y.inf;
                roundUp;
                out.sup=x.inf*y.sup;
                roundDefault;
                return

            elseif x.inf<-realmin && realmin<x.sup && y.sup<=realmin  % subcase 7
                roundDown;
                out.inf=x.sup*y.inf;
                roundUp;
                out.sup=x.inf*y.inf;
                roundDefault;
                return

            elseif x.sup<=realmin && y.sup<=realmin % subcase 8
                roundDown;
                out.inf=x.sup*y.sup;
                roundUp;
                out.sup=x.inf*y.inf;
                roundDefault;
                return

            elseif x.inf<-realmin && realmin<x.sup && y.inf<-realmin && realmin<y.sup % subcase 9
                roundDown;
                out.inf=min(x.inf*y.sup , x.sup*y.inf);
                roundUp;
                out.sup=max(x.inf*y.inf , x.sup*y.sup);
                roundDefault;
                return

            end
        else
            disp('Error: Input arg. are not of correct format.');
        end
        
  else
     
      if n==1 && isa(x,'INTERVAL')==0 && m>1 && isa(y,'INTERVAL')==0
          % when x is a scalar and y is real vector
          out=intervalVec(m);
          roundDown
          for i=1:m
             out(i).inf=x*y(i);
          end
          roundUp
          for j=1:m
             out(j)=x*y(j);
          end
          roundDefault
          return
       
      elseif n>1 && isa(x,'INTERVAL')==1 && m>1 && isa(y,'INTERVAL')==0 && n==m
          % when x is an interval vector and y is real vector
          array=intervalVec(n);
          roundDown
          for i=1:n
             if sign(y(i))>=0   
                array(i).inf=y(i)*x(i).inf;  
             else                          
                array(i).inf=y(i)*x(i).sup;  
             end                           
          end                              
          roundUp                          
          for j=1:n                        
             if sign(y(j))>=0              
                array(j).sup=y(j)*x(j).sup;  
             else                          
                array(j).sup=y(j)*x(j).inf;  
             end                           
          end                              
          roundDefault
          out=array(1);
          for i=2:n
              out=out+array(i);
          end
          return
          
      elseif n==1 && isa(x,'INTERVAL')==0 && m>1 && isa(y,'INTERVAL')==1
          % if x is a real and y is an interval vector
          out=intervalVec(m);
          roundDown
          if x>=0
             for i=1:m
                 out(i).inf=x*y(i).inf;  
                 roundUp                            
                 out(i).sup=x*y(i).sup;  
             end                           
          else                              
             for j=1:m                        
                 out(j).inf=x*y(j).sup;  
                 roundUp                  
                 out(j).sup=x*y(j).inf;  
             end                           
          end                              
          roundDefault
          return
          
      elseif n==1 && isa(x,'INTERVAL')==1 && m>1 && isa(y,'INTERVAL')==1 
          % if x is an interval and y is an interval vector
           out=intervalVec(m);
           if x.inf >=0              % x >=0
              for i=1:m
                  roundDown
                  if y(i).inf >=0     % y(i)>=0
                      out(i).inf=x.inf*y(i).inf;
                      roundUp
                      out(i).sup=x.sup*y(i).sup;
                  elseif y(i).sup<=0   % y(i)<=0
                      out(i).inf=x.sup*y(i).inf;
                      roundUp
                      out(i).sup=x.inf*y(i).sup;
                  else                % 0 in y(i)
                      out(i).inf=x.sup*y(i).inf;
                      roundUp
                      out(i).sup=x.sup*y(i).sup;
                  end
                  
              end
           elseif x.sup<=0           % x<=0
              for i=1:m
                  roundDown
                  if y(i).inf>=0      % y(i)>=0
                      out(i).inf=x.sup*y(i).sup;
                      roundUp
                      out(i).sup=x.sup*y(i).inf;
                  elseif y(i).sup<=0     % y(i)<=0
                      out(i).inf=x.sup*y(i).sup;
                      roundUp
                      out(i).sup=x.inf*y(i).inf;
                  else                % 0 in y(i)
                      out(i).inf=x.inf*y(i).sup;
                      roundUp
                      out(i).sup=x.inf*y(i).inf;
                  end
                  
              end
              
           else                   % 0 in x
              for i=1:m
                  roundDown
                  if y(i).inf>=0       % y(i)>=0
                      out(i).inf=x.inf*y(i).sup;
                      roundUp
                      out(i).sup=x.sup*y(i).sup;
                  elseif y(i).sup<=0   % y(i)<=0
                      out(i).inf=x.sup*y(i).inf;
                      roundUp
                      out(i).sup=x.inf*y(i).inf;
                  else              % 0 in y(i)
                      r1=x.inf*y(i).sup;
                      r2=x.sup*y(i).inf;
                      if r1<r2
                          out(i).inf=r1;
                      else
                          out(i).inf=r2;
                      end
                      roundUp
                      r1=x.inf*y(i).inf;
                      r2=x.sup*y(i).sup;
                      if r1>r2
                          out(i).sup=r1;
                      else
                          out(i).sup=r2;
                      end
                  end
                  
                  
              end
              
           end
           roundDefault;
           return
           
      elseif n>1 && isa(x,'INTERVAL')==0 && m>1 && isa(y,'INTERVAL')==1 && n==m
          % 24 March20 , could not find this case in the Profil/Bias ,so
          % verify this.
          % if x is vector of scalars and y is an interval vector
          % answer is same for va*vB or va'*vB
          array=intervalVec(n);
          for i=1:n
              array(i)=x(i)*y(i);     % in scalar vector implementation, scalar should be on the LHS
          end
          out=array(1);
          for i=2:n
              out=out+array(i);
          end
          return
          
      elseif n>1 && isa(x,'INTERVAL')==1 && m>1 && isa(y,'INTERVAL')==0 && n==m
          % 24 March20 , could not find this case in the Profil/Bias ,so
          % verify this.
          % if x is an interval vector and y is a vector of reals
          % answer is same for vA*vb or vA'*vb or va'*vB or va*vB
          % output will be an interval
          array=intervalVec(n);
          for i=1:n
              array(i)=x(i)*y(i);     % in scalar vector implementation, scalar should be on the LHS
          end
         
          out=array(1);
          for i=2:n
              out=out+array(i);
          end
          return
          
     elseif n>1 && isa(x,'INTERVAL')==1 && m>1 && isa(y,'INTERVAL')==1 && n==m
          % 24 March20 , could not find this case in the Profil/Bias ,so
          % verify this.
          % if x and y are both interval vectors
          % answer is same for vA*vB or vA'*vB 
          % output will be an interval
          array=intervalVec(n);
          for i=1:n
              array(i)=x(i)*y(i);     % in scalar vector implementation, scalar should be on the LHS
          end
         
          out=array(1);
          for i=2:n
              out=out+array(i);
          end
          return
      end
  
  end
end