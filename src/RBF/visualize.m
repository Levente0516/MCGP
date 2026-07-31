function [] = visualize(points, problem, u)

clf

disp(size(points))
disp(size(u))

disp(min(u))
disp(max(u))
disp(any(isnan(u)))
disp(any(isinf(u)))


subplot(1,2,1)

hold on

plot(problem.x, problem.y, 'y-', 'LineWidth', 2)

scatter(points(:,1),...
         points(:,2),...
         30,...
         u,...
         'filled');

axis equal tight

hold off

subplot(1,2,2)

scatter3(points(:,1),...
         points(:,2),...
         u,...
         30,...
         u,...
         'filled');

colorbar
axis equal

end