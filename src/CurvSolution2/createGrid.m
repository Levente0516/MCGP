function [boundary, boundaryType] = createGrid(problem)

xx = linspace(min(problem.x), max(problem.x), problem.div);
yy = linspace(min(problem.y), max(problem.y), problem.div);

[X,Y] = meshgrid(xx,yy);

bx = [];
by = [];
btype = [];

inside = inpolygon(X,Y,problem.x,problem.y);

boundaryType = zeros(size(X));

% 0 = nem perem, 1 = Dirichlet, 2 = Neumann


%A szokszög élein mintavételezés
for k = 1:length(problem.x)-1

    newx = linspace(problem.x(k),problem.x(k+1),problem.div);
    newy = linspace(problem.y(k),problem.y(k+1),problem.div);
    
    bx = [bx newx];
    by = [by newy];

    if problem.boundary(k).type == 'D'

        btype = [btype ones(1,length(newx))];

    elseif problem.boundary(k).type == 'N'

        btype = [btype 2*ones(1,length(newx))];

    end

end

sdf = inf(size(X));

for k = 1:length(bx)

    d = (X-bx(k)).^2 + (Y-by(k)).^2;

    mask = d < sdf;

    sdf(mask) = d(mask);

    boundaryType(mask) = btype(k);

end

sdf = sqrt(sdf);

hx = xx(2) - xx(1);
hy = yy(2) - yy(1);

tol = max(hx,hy);

boundary = sdf < tol;

boundaryType(~inside & ~boundary) = 0;

end