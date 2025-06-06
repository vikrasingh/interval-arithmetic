classdef INTERVAL  

    properties
       inf;
       sup;
        
    end
    methods 
%{
Firstly we have to define INTERVAL as class with two properties inf and sup,INTERVAL can take the 
         following input arguments. Input can be of type double,int,string 
 1.       INTERVAL()=[]
 2.       INTERVAL(5)=[5.00000,5.00000]  use intergers as an input to create
          degenerate INTERVAL
 3.       INTERVAL(2/3,2/3)=[0.66666,0.66667]  given as double input, the
        function will round down the first input and round up the second
 4.     INTERVAL(2/3,2)=[0.66666,2.00000]  round down the first and keep the second exact       
 5.     INTERVAL(2,2/3)=[2.00000,0.66667]  first exact and second round up       

updated rounding procedure if a<0 , 02 Aug20        
        
%}
        function obj=INTERVAL(a,varargin) 
            
            
%{ 
            
to get the bound of the INTERVALs we use the following
sup <= (variable + eta)/(1-eps) and inf=(variable-eta)/(1+eps)where is the eps and
eta are the machine dependent 
%}             
            switch nargin
                case 0  % for empty input just return empty scalars as inf and sup
%                     disp('[Empty]');
                    obj.inf=[];
                    obj.sup=[];
                    return
            
                case 1
                    
                    if isinteger(a)==1 % if input is an integer, no need of rounding
                        obj.inf=a;
                        obj.sup=a;
                        return
                        
                    else % for one argument of type double use rounding to find 
                        % inf and sup.
                        if a>=0                  % updated 02 Aug20
                           roundDown;
                           obj.inf=(a - realmin)/(1+eps);
                           roundUp;
                           obj.sup=(a + realmin)/(1-eps);
                           roundDefault;
                           return
                        elseif a<0
                            roundDown;
                            obj.inf=(a - realmin)/(1-eps);
                            roundUp;
                            obj.sup=(a + realmin)/(1+eps);
                            roundDefault;
                        end
                    end
            
                    
                 case 2
                     
                     if isinteger(a)==1 && isinteger(varargin{:})==1  % when both inputs are integers
                         obj.inf=a;
                         obj.sup=varargin{:};
                         return
                         
                     elseif isfloat(a)==1 && isfloat(varargin{:})==1  % if both inputs are double
                          roundDown;
                          inf_of_both=min(a,varargin{:});  %find the inf of both the no.
                          if inf_of_both>=0
                             obj.inf=(inf_of_both - realmin)/(1+eps);
                          elseif inf_of_both<0
                             obj.inf=(inf_of_both - realmin)/(1-eps);
                          end

                          roundUp;
                          sup_of_both=max(a,(varargin{:})); % find sup of both
                          if sup_of_both>=0
                              obj.sup=(sup_of_both + realmin)/(1-eps);
                          elseif sup_of_both<0
                              obj.sup=(sup_of_both + realmin)/(1+eps);
                          end
                          roundDefault;
                          return
                       
                          
                     elseif isfloat(a)==1 && isinteger(varargin{:})==1  % if first input is double and 
                          % second is an integer
                         roundDown;
                         if a>=0
                             obj.inf=(a - realmin)/(1+eps);
                         elseif a<0
                             obj.inf=(a - realmin)/(1-eps);
                         end
                         obj.sup=varargin{:};
                         roundDefault;
                         return
                         
                     elseif isinteger(a)==1 && isfloat(varargin{:})==1 % if first is an integer and second is double
                         obj.inf=a;
                         roundUp;
                         if varargin{:}>=0
                             obj.sup=(varargin{:} + realmin)/(1-eps);
                         elseif varargin{:}<0
                             obj.sup=(varargin{:} + realmin)/(1+eps);
                         end
                         roundDefault;
                      else
                          disp('Error: Input arg. are not of correct format.');
                          return
                      end
                    
                  
                        
                        
                    
            end
        end
        
%%%%%%%%%%%%%%%%%%% end of defining the INTERVAL  %%%%%%%%%%%%%%%%%%%%

%{
Inf function to find the infimum of the given interval
Output will be a real no. or a vector of real no.s
%}
function out=Inf(x) % where x is an interval   BiasInf
        out=BiasInf(x);
end

%{
Sup gives us the supremum of the interval.
%}
function out=Sup(x) % where x is an interval  BiasSup
     out=BiasSup(x);
end


% Let's define four arithmetic operations now

%{ 
 ADDITION 
 Firstly define the INTERVAL addition using the '+' operator overloading
 input of plus function can be a double and an INTERVAL or both INTERVALs.  
 From now on lower case represent a double no. and upper case letter
 represents an INTERVAL.

 a + A = [a+A.inf , a+A.sup] 
 A + a = [A.inf+a , A.sup+a]
 A + B = [A.inf+B.inf , A.sup+B.sup]
 

%}

function out=plus(x,y)   
       out=BiasAdd(x,y);
end   % end of plus 



%{
 SUBTRACTION
subtraction of two INTERVALs is defined using the '-' operator overloading 
a - A = [a - A.sup , a - A.inf]
A - a = [A.inf - a , A.sup - a]
A - B = [A.inf - B.sup , A.sup - B.inf]

%}
       
function out=minus(x,y)  % -
   out=BiasSub(x,y);
    
end % end of minus
    
%{
MULTIPLICATION
perform multiplication using the operator '*' 
we can insert the input using the following formats

a*A = [a*A.inf , a*A.sup] if a>=0
a*A = [a*A.sup , a*A.inf] if a<0

A*B = there are 9 different cases for this 
%}
 
function out=mtimes(x,y)  %  *
    out=BiasMul(x,y);
    
end  % end of mtimes

%{
DIVISION
to perform division use the '/' operator 
input format can be
a/A = [a/A.sup , a/A.inf] when a>=0
a/A = [a/A.inf , a/A.sup] when a<0

A/a = [A.inf/a , A.sup/a] when a>0
A/a = [A.sup/a , A.inf/a] when a<0

A/B = 

%}

function out=mrdivide(x,y)  % /
   out=BiasDiv(x,y);
    
end    % end of division

%{
Modified subtraction, 11 Dec20
A ~ B = [A.inf-B.inf , A.sup-B.sup]
vA ~ vB = [vA.inf-vB.inf , vA.sup-vB.sup]
%}
function out=Diff(x,y)   
    out=BiasDiff(x,y);
    
end


%{
MIDPOINT ,to find the midpoint of an INTERVAL
mid(A) = A.inf + (A.sup-A.inf)/2;
%}
function out=Mid(x) % to find the midpoint of an INTERVAL
    out=BiasMid(x);
end   % end of midpoint

%{
DIAMETER
diam(A)=A.sup-A.inf
%}
function out=Diam(x)
   out=BiasDiam(x);
end

%{
Dist 
function to find the distance between an interval and real no. or two
intervals , give the input in the following ways.
Dist(a,A)= inf A - a  if a< inf B
         = a - sup B  if a> sup B
Dist(A,B)= max(abs(inf A - inf B) , abs(sup A - sup B))  check this ?
%}

function out=Dist(x,y) % x can be a real no. or an interval, y has to be an interval only
    
    out=BiasDist(x,y);
end

%{
INTERSECTION
intersection of two disjoint intervals is undefined
Intersection(A,B) = 
%}
function out=Intersection(x,y) % here x and y both are intervals
   out=BiasIntersection(x,y);
       
end

%{
Sin(A) will return the sin value for the interval A.
%}
function out=Sin(x)
    out=BiasSin(x);
end

%{
Cos(A) will return the cos values of some interval A
%}
function out=Cos(x)
    out=BiasCos(x);
end

%{
Tan(A) tan of some interval
%}
function out=Tan(x) % x is an interval
    out=BiasTan(x);
    
end

%{
Cot(A) will return the cot values for some interval A;
%}
function out=Cot(x) % x is an interval
    out=BiasCot(x);
end

%{
EXPONENTIAL function for an interval        
%}
       function out=Exp(x)  % x is an interval
           out=BiasExp(x);
       end
       
%{
BiasLog is the natural log, we will call it using log.  
     Log(A)=[ , ]
%}
       function out=Log(x) % x is an interval
           out=BiasLog(x);
       end

%{
BiasLog10  is the log with base 10, we will call it by Log10 
    Log10(A)=[ , ]
%}
       function out=Log10(x)
           out=BiasLog10(x);
       end
 
%{
Sqr function to find the square of an interval; 
    return an interval.
       Sqr([2,5]) = [4.000000,25.000000]
%}
       function out=Sqr(x)
           out=BiasSqr(x);
       end
     


%{
Sqrt function, Sqrt(A), where A is a non negative interval.
  Sqrt([2,4]) = [1.414214,2.000000]     
%}
       function out=Sqrt(x)
           out=BiasSqrt(x);
       end
 
%{
IAbs to find the absolute value of an interval
  IAbs(A)={ |x| : x in A }; 
    A can be a interval, an array or matrix of intervals
%}
       function out=IAbs(x)
           out=BiasIAbs(x);
       end
       
%{
Root to find the nth root of an interval
Root(A,n) where A is an interval and n is an integer which is the nth root.
A=[8,27]; Root(A,3)=[2,3]        
%}
       function out=Root(x,n)  % x is an interval, Root computes [x]^(1/n)
           out=BiasRoot(x,n);
       end

%{
Power  , to raise an interval A to some power n
       or to raise an interval A to the power another interval B
Power(A,n) = A^n
Power(A,B) = A^B       

%}
       function out=Power(x,y)  % x has to be an interval but y can be an integer or an interval
           if isa(x,'INTERVAL')==1 && rem(y,1)==0
               out=BiasPowerN(x,y); % here y is an integer
               return
           elseif isa(x,'INTERVAL')==1 && isa(y,'INTERVAL')==1
               out=BiasPowerI(x,y); % will give x^y where both are intervals
           else
               disp('Error in Power.');
           end
       end
       
%{
[m,r]=MidRad(x) will return the midpoint and radius of the interval x        
%}
       function [midpt,rad]=MidRad(x)
             [midpt,rad]=BiasMidRad(x);
       end
       
%{
Width(x) returns width if x is an interval
      or returns largest width of any interval of x if x is an interval vector
%}
       function [w]=Width(x)
           [w]=BiasWidth(x);
       end

%{
MaxkWidth(x,k) find indices of k components with max width in the decreasing order
    returns kx1 real vector I which contains the indices of sub-intervals with max width in the decreasing order 
%}      
       function [w,idx]=MaxkWidth(x,k)
           n=length(x);
           store_width=zeros(n,1);
           for i=1:n
               store_width(i)=BiasWidth(x(i));
           end
           [w,idx]=maxk(store_width,k); % find the k components with max width

       end
      
%{
display function for INTERVAL objects       
%}
       
       function disp(x)
                 [n,m]=size(x);
                 if n==1 && m==1   % if scalar
                    formatspec='    [%f,%f] \n';
                    printInf=x.inf;
                    printSup=x.sup;
                    fprintf(formatspec,printInf,printSup);
                    %{
                    % No need to display inf and sup    19 feb20
                    header='     INTERVAL with properties :';
                    disp(header);
                    fprintf('     inf: %f \n',printInf);
                    fprintf('     sup: %f \n',printSup);
                    %}
                 elseif n>1 && m==1   % if column vector
                     for i=1:n
                         fprintf('[%f,%f] \n',x(i).inf,x(i).sup);
                     end
                     
                     
                 elseif n==1 && m>1    % if row vector
                     for i=1:m-1
                         fprintf('[%f,%f] ',x(i).inf,x(i).sup);
                     end
                     fprintf('[%f,%f]\n',x(m).inf,x(m).sup);
                 else     % if n x m  matrix
                     for i=1:n
                         for j=1:m-1
                             fprintf('[%f,%f]   ',x(i,j).inf,x(i,j).sup);
                         end
                             fprintf('[%f,%f] \n',x(i,m).inf,x(i,m).sup);
                         
                     end
                     
                 end
       end
       
       
    end  % end of methods
    
   
    
    methods (Static)
        
%{
HULL function, it is defined in static methods because in the methods
section above we can only define functions which take atleast one input which is an object of
the class.
        Restricted to the use of two or less input arguments only
it can take the following input arguments 
Hull(a) = [a , a]        
Hull(a,b) = [a , b]
Hull(a,A) = [a , A.sup] if a<A.inf
          = [A.inf , a] if a>A.sup
Hull(A,B) 
        
%}        
       function out=Hull(x,y)
          out=BiasHull(x,y);
       end
       
%{
Pred function, to find the predecessor of a number or an interval       
Pred(a)=b where b is smallest no. such that b<a   
Pred(A)=B where is the largest interval such that A.inf<B.inf and B.sup<A.sup     
%}   
       function  out=Pred(x)
           out=BiasPred(x);
           
       end
       
%{
Succ function, to find the successor of a number or an interval       
Succ(a)=b where b is the largest no. such that b>a   
Succ(A)=B where B is the largest interval such that B.inf<A.inf and A.sup<B.sup     
%}
       function out=Succ(x)
           out=BiasSucc(x);
       end
       
      



       
       
       
       
        
    end  % end of static methods
   
    
    
end % end of classdef

 
    