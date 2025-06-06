%{
DIVISION
to perform division use the '/' operator 
input format can be
a/A = [a/A.sup , a/A.inf] when a>=0
a/A = [a/A.inf , a/A.sup] when a<0

A/a = [A.inf/a , A.sup/a] when a>0
A/a = [A.sup/a , A.inf/a] when a<0
A/B = interval divided by interval
va/b = vector of real divided by a constant b
vA/b = vector on intervals divided by a const b
va/B = vector of reals divided by an interval
vA/B =vector of intervals divided by an interval

%}
function out=BiasDiv(x,y)
    n=max(length(x),length(y));
    if n==1
       out=INTERVAL;
       if isfloat(x)==1 && isfloat(y)==0 % a/A
          if x>=0  % a>=0
             roundDown
             out.inf=x/(y.sup); 
             roundUp
             out.sup=x/(y.inf);
             roundDefault;
             return
          else     % a<0
             roundDown
             out.inf=x/(y.inf); 
             roundUp
             out.sup=x/(y.sup); 
             roundDefault;
             return
          end
        
      elseif isfloat(x)==0 && isfloat(y)==1  % A/a
          if y>0       % a>0
             roundDown
             out.inf=(x.inf)/y;
             roundUp
             out.sup=(x.sup)/y;
             roundDefault;
             return
          elseif y<0     % a<0
             roundDown
             out.inf=(x.sup)/y;
             roundUp
             out.sup=(x.inf)/y;
             roundDefault;
             return
          end
        
      elseif isfloat(x)==0 && isfloat(y)==0     % A/B
          if -realmin<=x.inf          %      0<= inf A
                 if -realmin< y.inf % 0 < inf B
                    roundDown
                    out.inf=x.inf / y.sup;
                    roundUp
                    out.sup=x.sup / y.inf;
                    roundDefault;
                    return
             elseif y.sup< realmin  % sup B <0
                    roundDown
                    out.inf=x.sup / y.sup;
                    roundUp
                    out.sup= x.inf / y.inf;
                    roundDefault;
                    return
                 
               else  % 0 in B, will just give the error for now
                    disp('Error: Division by zero.  /n');
                end
             
        elseif x.sup<=realmin  % sup A <=0
              if -realmin< y.inf  % 0< inf B
                  roundDown
                  out.inf=x.inf / y.inf;
                  roundUp
                  out.sup= x.sup * y.sup;
                  roundDefault;
                  return
                  
              elseif y.sup<realmin  % sup B <0
                  roundDown
                  out.inf=x.sup / y.inf;
                  roundUp
                  out.sup=x.inf * y.sup;
                  roundDefault;
                  return
                  
              else   % 0 in B
                  disp('Error: Division by zero. /n');
                  
              end
              
          else   % 0 in A
              if   -realmin<y.inf   % 0 < inf B
                  roundDown
                  out.inf=x.inf / y.inf;
                  roundUp
                  out.sup= x.sup / y.inf;
                  roundDefault;
                  return
                  
              elseif y.sup < realmin  % sup B < 0
                  roundDown
                  out.inf=x.sup / y.sup;
                  roundUp
                  out.sup= x.inf / y.sup;
                  roundDefault;
                  return
                  
              else % when 0 in B
                  disp('Error: Division by zero.  ');
              end  % -realmin<=y.inf
              
          end  % -realmin<=x.inf
          
       end  % isfloat(x)==1 && isfloat(y)==0
       
    else   % n>1
        out=intervalVec(n);
        if isa(x,'INTERVAL')==0 && isa(y,'INTERVAL')==0
            % x is a real vector and y is a real scalar
            if y==0
                disp('Error: vector divide by zero');
                return
            end
            roundDown
            for i=1:n
                out(i).inf=x(i)/y;
                roundUp
                out(i).sup=x(i)/y;
            end
            roundDefault;
            return
            
        elseif isa(x,'INTERVAL')==1 && isa(y,'INTERVAL')==0
            % x in an interval vector and y is a real scalar
            if y==0
                disp('Error: vector divide by zero');
                return
            end
            roundDown
            if y>=0           % y>=0
               for i=1:n
                  out(i).inf=x(i).inf/y;
               end
               roundUp
               for i=1:n
                   out(i).sup=x(i).sup/y;
               end
            else            % y<0
               for i=1:n
                   out(i).inf=x(i).sup/y;  
               end
               roundUp
               for i=1:n
                   out(i).sup=x(i).inf/y;
               end
            end
            roundDefault
            return
            
        elseif isa(x,'INTERVAL')==0 && isa(y,'INTERVAL')==1
            % if x is a real vector and y is an interval
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%       
            if y.sup>=0  && (y.inf<0 || y.inf==0)   % verify this Bias1.c  BiasDivVRI
               disp('Error: Vector divide by zero.');
            
                for i=1:n
                    if x(i)==0
                        out(i).sup=NaN; % Not a no.
                        out(i).inf=NaN;
                    else
                        out(i).inf=-Inf;
                        out(i).sup=+Inf;
                    end
                    return
                end
            end
            for i=1:n
                if x(i)>=0
                    out(i).inf=x(i)/y.sup;
                else
                    out(i).inf=x(i)/y.inf;
                end
            end
            roundUp
            for i=1:n
                if x(i)>=0
                    out(i).sup=x(i)/y.inf;
                else
                    out(i).inf=x(i)/y.sup;
                end
            end
            roundDefault
            return
        elseif isa(x,'INTERVAL')==1 && isa(y,'INTERVAL')==1
            % x is an interval vector and y is an interval
            for i=1:n
                out(i)=BiasDiv(x(i),y);
            end
        end
        
    end


end