function [] = visualize(problem,boundary,boundaryType)

clf;

xx = linspace(min(problem.x), max(problem.x), problem.div);
yy = linspace(min(problem.y), max(problem.y), problem.div);

[X,Y] = meshgrid(xx,yy);


hold on

% teljes grid
plot(X(:), Y(:), '.b');

% Dirichlet pontok
D = boundaryType == 1;

scatter(X(D), Y(D), 20, 'r');


% Neumann pontok
N = boundaryType == 2;

scatter(X(N), Y(N), 20, 'g');


% alakzat pereme
plot(problem.x, problem.y, 'w-', 'LineWidth', 2);

axis equal tight
hold off

end