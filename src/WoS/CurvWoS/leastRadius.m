function [r,boundaryID] = leastRadius(x0, problem)

r = inf;

for i = 1:length(problem.x)-1
    
    A = [problem.x(i), problem.y(i)];
    B = [problem.x(i+1), problem.y(i+1)];

    AB = B - A;

    t = dot(x0-A, AB) / dot(AB,AB);

    t = max(0, min(1, t));

    Q = A + t*AB;

    d = norm(x0-Q);

    if d < r
        r = d;
        boundaryID = i;
    end

end