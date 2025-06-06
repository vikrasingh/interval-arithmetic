%{
BiasLog10 is the log with base 10
%}
function out=BiasLog10(x)
   if BiasInf(x)< 0
        disp('Error: argument is a negative number.')
        out=[];
        return
   else
        
        
        t1=BiasLog(x);
        out=BiasDiv(t1,BiasLn10Incl);
    end
end

function value=BiasLn10Incl  % enclosure of ln 10
  value=INTERVAL(log(10));
end