%{
BiasLog is the natural log for an interval.
%}
function out=BiasLog(x)
    if BiasInf(x)< 0
        disp('Error: argument is a negative number.')
        out=[];
        return
    else
        roundDown
        y_inf=log(BiasInf(x));
        roundUp
        y_sup=log(BiasSup(x));
        out=BiasHull(y_inf,y_sup);
    end

end