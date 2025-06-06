% 27 feb 20, this function generates a row vector of empty intervals of length n 
function  [out]=intervalVec(n)
   out=INTERVAL;
   for i=1:n
       out(i).inf=[];
       out(i).sup=[];
   end
   out=out';
end