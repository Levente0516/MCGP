function [] = visualize(points, problem, u)

clf

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

% tri = delaunay(points(:,1), points(:,2));
% 
% 
% trisurf(tri,...
%         points(:,1),...
%         points(:,2),...
%         u,...
%         'EdgeColor','none');
% 
% 
% view(3)

axis tight
colorbar
colormap turbo

scatter3(points(:,1),...
         points(:,2),...
         u,...
         30,...
         u,...
         'filled');

colorbar
axis tight

end