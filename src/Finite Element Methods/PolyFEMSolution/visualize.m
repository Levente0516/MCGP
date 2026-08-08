function [] = visualize(problem,points, tri, u)

clf;

subplot(1,2,1)

% FEM solution
trisurf(tri, ...
        points(:,1), ...
        points(:,2), ...
        u, ...
        'EdgeColor','none');

colorbar;
xlabel('X-axis');
ylabel('Y-axis');
zlabel('U-value');
title('FEM Solution Visualization');
shading interp

subplot(1,2,2)

hold on

trisurf(tri,...
        points(:,1),...
        points(:,2),...
        u,...
        'EdgeColor','none');

view(2);
axis equal tight

colorbar;

%triplot(tri, points(:,1), points(:,2), "Color", 'y')

plot(problem.x, problem.y, 'y-', 'LineWidth', 1);

axis equal tight


title('Perempontok közelítéssel')

hold off

end