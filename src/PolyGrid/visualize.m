function [] = visualize(problem,grid1,grid2)

clf;

subplot(1,2,1)
hold on
plot(grid1.X(:), grid1.Y(:), '.b');

plot(problem.x, problem.y, 'y-', 'LineWidth', 1);

scatter(grid1.X(grid1.boundary), ...
    grid1.Y(grid1.boundary), 20, 'r');

axis equal tight

%legend('grid pontok', 'perem', 'perempont approx.', ...
%    'Location','bestoutside');

title('Perempontok közelítéssel')

hold off


subplot(1,2,2)

hold on
plot(grid2.X(:), grid2.Y(:), '.b');

plot(problem.x, problem.y, 'y-', 'LineWidth', 1);

scatter(grid2.X(grid2.boundary), ...
    grid2.Y(grid2.boundary), 20, 'r');

axis equal tight

title('Perempontok gridpontok mozgatásával peremre')

hold off

end