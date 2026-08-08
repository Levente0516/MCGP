function [insidePoints, u, walkPath, walkRadius] = Solution(problem)

% Pontok generálása az alakzaton belül
insidePoints = genInsidePointsPoly(problem);

u = zeros(problem.points,1);

walkPath = cell(problem.points, problem.nWalks);
walkRadius = cell(problem.points, problem.nWalks);


for i = 1 : problem.points

    [u(i),walkPath(i,:), walkRadius(i,:)] = ...
        Solver(problem,insidePoints(i,:));

end

end