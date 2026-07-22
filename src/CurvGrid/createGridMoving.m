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
            
            if ~inside(i-1,j)
                [xi,yi] = polyxpoly( ...
                    [X(i,j), X(i-1,j)], ...
                    [Y(i,j), Y(i-1,j)], ...
                    x, y);
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
                    x, y);
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
                    x, y);
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
                    x, y);
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

boundary(on) = true;

grid.X = X;
grid.Y = Y;
grid.inside = inside;
grid.boundary = boundary;

end