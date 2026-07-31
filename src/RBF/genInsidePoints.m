function [insidePoints] = genInsidePoints(problem)

N = problem.points;

insidePoints=zeros(N,2);

xmin=min(problem.x);
xmax=max(problem.x);
ymin=min(problem.y);
ymax=max(problem.y);

count=0;

while count<N

    x=xmin+rand()*(xmax-xmin);
    y=ymin+rand()*(ymax-ymin);

    inside=inpolygon(x,y,problem.x,problem.y);

    if inside

        count=count+1;
        insidePoints(count,:)=[x,y];

    end

end

end