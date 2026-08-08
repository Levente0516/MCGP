function [] = visualize(problem,points, tri)

clf;

hold on



triplot(tri, points(:,1), points(:,2))

plot(problem.x, problem.y, 'y-', 'LineWidth', 1);

axis equal tight

%legend('grid pontok', 'perem', 'perempont approx.', ...
%    'Location','bestoutside');

title('Perempontok közelítéssel')

hold off

end