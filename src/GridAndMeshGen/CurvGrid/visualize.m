function [] = visualize(problem,grid1,grid2)

clf;

t = linspace(problem.alpha, problem.beta, problem.div);

px = problem.x(t);
py = problem.y(t);


subplot(1,2,1)
hold on

plot(grid1.X(:), grid1.Y(:), '.b');


plot(px, py, 'y-', 'LineWidth', 1);

scatter(grid1.X(grid1.boundary), ...
        grid1.Y(grid1.boundary), ...
        20, 'r', 'filled');


axis equal tight

title('Perempontok közelítéssel')

hold off



subplot(1,2,2)
hold on

plot(grid2.X(:), grid2.Y(:), '.b');

plot(px, py, 'y-', 'LineWidth', 1);

scatter(grid2.X(grid2.boundary), ...
        grid2.Y(grid2.boundary), ...
        20, 'r', 'filled');


axis equal tight

title('Perempontok gridpontok mozgatásával peremre')

hold off

end