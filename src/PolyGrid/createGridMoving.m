function [grid] = createGridMoving(problem)

xx = linspace(min(problem.x), max(problem.x), problem.div);
yy = linspace(min(problem.y), max(problem.y), problem.div);

[X,Y] = meshgrid(xx,yy);

[inside, on] = inpolygon(X,Y,problem.x,problem.y);

boundary = false(size(X));

boundary(on) = true;

for i = 2:size(X,1)-1
    for j = 2:size(X,2)-1

        if inside(i,j) && ~on(i,j)
            
            if ~inside(i-1,j)
                [xi,yi] = polyxpoly( ...
                    [X(i,j), X(i-1,j)], ...
                    [Y(i,j), Y(i-1,j)], ...
                    problem.x, problem.y);
                if ~isempty(xi)
                    d = hypot(xi-X(i-1,j), yi-Y(i-1,j));
                    [~,id] = min(d);
                    X(i-1,j)=xi(id);
                    Y(i-1,j)=yi(id);
                    boundary(i-1,j)=true;
                end
            end
            if ~inside(i+1,j)
                [xi,yi] = polyxpoly( ...
                    [X(i,j), X(i+1,j)], ...
                    [Y(i,j), Y(i+1,j)], ...
                    problem.x, problem.y);
                if ~isempty(xi)
                    d = hypot(xi-X(i+1,j), yi-Y(i+1,j));
                    [~,id] = min(d);
                    X(i+1,j)=xi(id);
                    Y(i+1,j)=yi(id);
                    boundary(i+1,j)=true;
                end
            end
            if ~inside(i,j-1)
                [xi,yi] = polyxpoly( ...
                    [X(i,j), X(i,j-1)], ...
                    [Y(i,j), Y(i,j-1)], ...
                    problem.x, problem.y);
                if ~isempty(xi)
                    d = hypot(xi-X(i,j-1), yi-Y(i,j-1));
                    [~,id] = min(d);
                    X(i,j-1)=xi(id);
                    Y(i,j-1)=yi(id);
                    boundary(i,j-1)=true;
                end
            end
            if ~inside(i,j+1)
                [xi,yi] = polyxpoly( ...
                    [X(i,j), X(i,j+1)], ...
                    [Y(i,j), Y(i,j+1)], ...
                    problem.x, problem.y);
                if ~isempty(xi)
                    d = hypot(xi-X(i,j+1), yi-Y(i,j+1));
                    [~,id] = min(d);
                    X(i,j+1)=xi(id);
                    Y(i,j+1)=yi(id);
                    boundary(i,j+1)=true;
                end
            end
        end
    end
end
grid.X = X;
grid.Y = Y;
grid.inside = inside;
grid.boundary = boundary;
end