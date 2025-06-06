
function out=BiasCot(x)
 t1=plus(x,BiasPiHalfIncl);
 t2=BiasTan(t1);
 out=BiasNeg(t2);
end


function value=BiasPiHalfIncl  % this function gives enclosure of pi/2
 value=INTERVAL(pi/2);

end