function [grid] = createGridMoving(problem)

t = linspace(problem.alpha, problem.beta, problem.div);

x = problem.x(t);
y = problem.y(t);

xx = linspace(min(x), max(x), problem.div);
yy = linspace(min(y), max(y), problem.div);

[X,Y] = meshgrid(xx,yy);

[inside, on] = inpolygon(X,Y,x,y);

boundary = false(size(X));

for i = 2:size(X,1)-1
    for j = 2:size(X,2)-1

        if inside(i,j) && ~on(i,j)

            intersections = [];

            if ~inside(i-1,j)
                [xi,yi] = polyxpoly( ...
                    [X(i,j), X(i-1,j)], ...
                    [Y(i,j), Y(i-1,j)], ...
                    x, y);

                intersections = [intersections; xi(:), yi(:)];
            end

            if ~inside(i+1,j)
                [xi,yi] = polyxpoly( ...
                    [X(i,j), X(i+1,j)], ...
                    [Y(i,j), Y(i+1,j)], ...
                    x, y);

                intersections = [intersections; xi(:), yi(:)];
            end

            if ~inside(i,j-1)
                [xi,yi] = polyxpoly( ...
                    [X(i,j), X(i,j-1)], ...
                    [Y(i,j), Y(i,j-1)], ...
                    x, y);

                intersections = [intersections; xi(:), yi(:)];
            end

            if ~inside(i,j+1)
                [xi,yi] = polyxpoly( ...
                    [X(i,j), X(i,j+1)], ...
                    [Y(i,j), Y(i,j+1)], ...
                    x, y);

                intersections = [intersections; xi(:), yi(:)];
            end

            if ~isempty(intersections)
                d = hypot( ...
                    intersections(:,1)-X(i,j), ...
                    intersections(:,2)-Y(i,j));
            
                [~,id] = min(d);
            
                X(i,j)=intersections(id,1);
                Y(i,j)=intersections(id,2);
            
                boundary(i,j)=true;
            end

        end
    end
end

boundary(on) = true;

grid.X = X;
grid.Y = Y;
grid.inside = inside;
grid.boundary = boundary;

end