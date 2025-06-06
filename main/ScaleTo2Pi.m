%{
ScaleTo2Pi function
to scale the interval x to [0,2pi]
%}
function out=ScaleTo2Pi(x) % x is an interval
   out=INTERVAL;
if (x.inf>=0) && (x.sup< (pi/2)) % if interval x lies bw 0 and pi/2
    out.inf=x.inf;
    out.sup=x.sup;
    return
end
q=BiasInf(x)/(2*pi);
q=floor(BiasPred(q));
q=q*2*pi;
q=BiasSucc(q);
if q>0
    q=q*(1+eps);
    q=BiasSucc(q);
    
end
x_inf=BiasInf(x)-q;
x_inf=BiasPred(x_inf);
if x_inf<0
    x_inf=x_inf+(2*pi);
    x_inf=BiasPred(x_inf);
end
q=BiasSup(x)/(2*pi);
q=floor(BiasPred(q));
q=q*(2*pi);
q=BiasPred(q);
if q<0
    q=q*(1+eps);
    q=BiasPred(q);
end
x_sup=BiasSup(x)-q;
x_sup=BiasSucc(x_sup);
if x_sup > (2*pi)
    x_sup=x_sup-(2*pi);
    x_sup=BiasSucc(x_sup);
end
% For debugging
if x_inf<0
    disp('Error: ScaleTo2Pi, inf < 0');
elseif x_sup>(2*pi)
    disp('Error: ScaleTo2Pi, sup > 2pi');
end

out.inf=x_inf;
out.sup=x_sup;


end