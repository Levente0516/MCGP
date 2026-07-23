function [points, tri] = createMesh(problem)

model = createpde();

t = linspace(problem.alpha, problem.beta, problem.div);
t(end) = [];

x = problem.x(t);
y = problem.y(t);

size(x)
size(y)

P = unique([x' y'],'rows','stable');

n = numel(x);

gd = [2; n; x(:); y(:)];

ns = char('P1');
ns = ns';

sf = 'P1';

dl = decsg(gd, sf, ns);

geometryFromEdges(model, dl);

h = max( ...
    max(x)-min(x), ...
    max(y)-min(y));

msh = generateMesh(model,...
    "GeometricOrder","linear",...
    "Hmax", h/problem.div);

points = msh.Nodes';
tri = msh.Elements(1:3,:)';

end