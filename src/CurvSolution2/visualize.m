function [] = visualize(problem,geometry)

clf;

hold on

plot(geometry.X(:), geometry.Y(:), '.b');

plot(problem.x, problem.y, 'y-', 'LineWidth', 1);

scatter(geometry.X(geometry.boundary), ...
    geometry.Y(geometry.boundary), 20, 'r');


% alakzat pereme


axis equal tight
hold off

end