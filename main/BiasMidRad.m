% to find the midpoint and radius 
function  [m,r]=BiasMidRad(x)  % input x an interval
                               % output m midpoint, r radius
         roundUp
         r=(x.sup-x.inf)/2;  % midpoint
         m=x.inf+r;
         roundDefault
end