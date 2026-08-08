function [] = visualize(points, problem, u, walkPath, walkRadius)

close all

figure

subplot(1,2,1)

hold on

plot(problem.x, problem.y, 'k-', 'LineWidth', 2);

scatter(points(:,1), points(:,2), ...
        30, u, 'filled');

axis equal tight;
colorbar;

xlabel('x');
ylabel('y');
title('WoS solution points');

hold off

subplot(1,2,2)

F = scatteredInterpolant( ...
    points(:,1), ...
    points(:,2), ...
    u, ...
    'natural', ...
    'none');

[xq,yq] = meshgrid( ...
    linspace(min(problem.x), max(problem.x), 100), ...
    linspace(min(problem.y), max(problem.y), 100));

U = F(xq,yq);

surf(xq, yq, U);

shading interp;

xlabel('x');
ylabel('y');
zlabel('u');

title('Interpolated WoS solution');

colorbar;

axis tight;
view(3);

% figure
% 
% hold on;
% 
% plot(problem.x, problem.y, 'k-', 'LineWidth', 2);
% 
% theta = linspace(0, 2*pi, 100);
% 
% path = walkPath{1,1};
% plot(path(:,1), path(:,2), '.');
% 
% for i = 1:problem.points
%     for j = 1:problem.nWalks
%         path = walkPath{1,j};
%         radii = walkRadius{1,j};
% 
%         plot(path(:,1), path(:,2), '-o');
% 
%         for k = 1:length(radii)
% 
%             center = path(k,:);
%             R = radii(k);
% 
%             xc = center(1) + R*cos(theta);
%             yc = center(2) + R*sin(theta);
% 
%             plot(xc, yc);
% 
%         end
% 
%     end
% end
% 
% axis equal;
% hold off;

end