% 16 March20
function [out]=intervalMatrix(m,n)
%{
To generate a mxn matrix of empty intervals
%}
  out=INTERVAL;
  for i=1:m
      for j=1:n
          out(i,j)=INTERVAL;
      end
  end

%{  
  for i=1:n    blocked 29 Aug 20
      out(:,i)=intervalVec(m);
    
  end
%}  

end