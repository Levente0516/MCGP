function [insidePoints] = genInsidePointsCurv(problem)

N = problem.points;

Nt = problem.nt;

t = linspace(problem.alpha, problem.beta, Nt);

boundaryX = problem.x(t); 
boundaryY = problem.y(t);

insidePoints=zeros(N,2);

xmin = min(boundaryX); 
xmax = max(boundaryX); 
ymin = min(boundaryY); 
ymax = max(boundaryY);

count=0;

while count<N

    x=xmin+rand()*(xmax-xmin);
    y=ymin+rand()*(ymax-ymin);

    inside=inpolygon(x,y,boundaryX,boundaryY);

    if inside

        count=count+1;
        insidePoints(count,:)=[x,y];

    end

end

end