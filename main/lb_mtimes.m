% 13 March 21
% the following function will just give us the lower bound of the output interval to save
% computation time.

function   out=lb_mtimes(x,y)

  n=length(x);
  m=length(y);
  
  if n==1 && m==1
       if isfloat(x)==1 && isfloat(y)==1
           % case of a*b
            roundDown
            out=x*y;
            roundDefault;
            return
        
       elseif isfloat(x)==1 && isfloat(y)==0
            % case of a*A

            if x>=0 % subcase 1 
               roundDown
               out=x*y.inf;
               roundDefault;
               return
              
            else % subcase when x<0
               roundDown;
               out=x*y.sup; 
               roundDefault;
               return
            end

        elseif isfloat(x)==0 && isfloat(y)==0
            % case A*B both are INTERVALs
            % check p13 of  INTERVAL Anal. by Moore,..
               
            if -realmin<=(x.inf) && -realmin<=(y.inf)  % subcase 1
                roundDown;
                out=x.inf*y.inf;
                roundDefault;
                return

            elseif ((x.inf) < -realmin) && (realmin < (x.sup)) && (-realmin < (y.inf) || -realmin==(y.inf)) % subcase 2
                roundDown;
                out=x.inf*y.sup;
                roundDefault;
                return

            elseif x.sup<=(realmin) && -realmin<=(y.inf) % subcase 3
                roundDown;
                out=x.inf*y.sup;
                roundDefault;
                return

            elseif -realmin<=x.inf && y.inf<-realmin && realmin<y.sup % subcase 4
                roundDown;
                out=x.sup*y.inf;
                roundDefault;
                return

            elseif x.sup<=realmin && y.inf<-realmin && realmin<y.sup % subcase 5
                roundDown;
                out=x.inf*y.sup;
                roundDefault;
                return

            elseif -realmin<=x.inf && y.sup<=realmin % subcase 6
                roundDown;
                out=x.sup*y.inf;
                roundDefault;
                return

            elseif x.inf<-realmin && realmin<x.sup && y.sup<=realmin  % subcase 7
                roundDown;
                out=x.sup*y.inf;
                roundDefault;
                return

            elseif x.sup<=realmin && y.sup<=realmin % subcase 8
                roundDown;
                out=x.sup*y.sup;
                roundDefault;
                return

            elseif x.inf<-realmin && realmin<x.sup && y.inf<-realmin && realmin<y.sup % subcase 9
                roundDown;
                out=min(x.inf*y.sup , x.sup*y.inf);
                roundDefault;
                return

            end
        else
            disp('Error: Input arg. are not of correct format.');
        end
        
   end



end