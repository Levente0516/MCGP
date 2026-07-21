function [grid] = createGridApprox(problem)

xx = linspace(min(problem.x), max(problem.x), problem.div);
yy = linspace(min(problem.y), max(problem.y), problem.div);

[X,Y] = meshgrid(xx,yy);

[inside, on] = inpolygon(X,Y,problem.x,problem.y);

boundary = false(size(X));

for i = 2:size(X,1)-1
    for j = 2:size(X,2)-1
        if inside(i,j) && ~on(i,j)
            if ~inside(i-1,j)
                boundary(i-1,j) = true;
            end
            if  ~inside(i+1,j)
                boundary(i+1,j) = true;
            end
            if ~inside(i,j-1)
                boundary(i,j-1) = true;
            end
            if ~inside(i,j+1)
                boundary(i,j+1) = true;
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