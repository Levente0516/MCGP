function [] = visualize(problem,points, tri)

clf;

t = linspace(problem.alpha, problem.beta, problem.div);

x = problem.x(t);
y = problem.y(t);

hold on

triplot(tri, points(:,1), points(:,2))

plot(x, y, 'y-', 'LineWidth', 1);

axis equal tight

%legend('grid pontok', 'perem', 'perempont approx.', ...
%    'Location','bestoutside');

title('Perempontok közelítéssel')

hold off

end