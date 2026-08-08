function [] = visualize(points, problem, u)

clf


if problem.type == "Curv"

    % Paraméteres görbe mintavételezése

    Nt = problem.nt;

    t = linspace(...
        problem.alpha,...
        problem.beta,...
        Nt);

    boundaryX = problem.x(t);
    boundaryY = problem.y(t);

else

    % Poligon

    boundaryX = problem.x;
    boundaryY = problem.y;

end

subplot(1,2,1)

hold on

plot(boundaryX,...
     boundaryY,...
     'y-',...
     'LineWidth',2);


scatter(points(:,1),...
        points(:,2),...
        30,...
        u,...
        'filled');


axis equal
axis tight

colorbar

hold off

subplot(1,2,2)

scatter3(points(:,1),...
         points(:,2),...
         u,...
         30,...
         u,...
         'filled');

colorbar

axis tight

view(3)

end

