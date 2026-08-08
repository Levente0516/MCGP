function [btype, bvalue, bnormal] = nearestBoundaryInfo(x, problem)
% Megkeresi az x ponthoz legközelebbi globális perem-szakaszt.

Nb = length(problem.boundary);

center = [
    mean(problem.x(1:end-1))
    mean(problem.y(1:end-1))
]';

bestDist = inf;
btype = 0;
bvalue = 0;
bnormal = [0,0];

for k = 1:Nb
    x1 = problem.boundary(k).x(1); x2 = problem.boundary(k).x(2);
    y1 = problem.boundary(k).y(1); y2 = problem.boundary(k).y(2);

    ex = x2-x1; ey = y2-y1;
    elen2 = ex^2+ey^2;
    t = ((x(1)-x1)*ex + (x(2)-y1)*ey)/elen2;
    t = min(max(t,0),1);
    px = x1+t*ex; py = y1+t*ey;
    dist = hypot(x(1)-px, x(2)-py);

    if dist < bestDist
        bestDist = dist;

        if problem.boundary(k).type == 'N'
            btype = 1;
        else
            btype = 0;
        end
        bvalue = problem.boundary(k).value(x(1),x(2));

        nx = -ey; ny = ex;
        len = sqrt(nx^2+ny^2);
        nx = nx/len; ny = ny/len;

        mx = (x1+x2)/2; my = (y1+y2)/2;
        vx = center(1)-mx; vy = center(2)-my;
        if nx*vx+ny*vy > 0
            nx = -nx; ny = -ny;
        end
        bnormal = [nx,ny];
    end
end
end