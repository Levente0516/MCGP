function [points, tri] = createMesh(problem)

model = createpde();

x = problem.x(:);
y = problem.y(:);

if x(1)==x(end) && y(1)==y(end)
    x(end) = [];
    y(end) = [];
end

n = length(x);

gd = [2; n; x; y];

ns = char('P1');
ns = ns';

sf = 'P1';

dl = decsg(gd, sf, ns);

geometryFromEdges(model, dl);

msh = generateMesh(model,...
    "GeometricOrder","linear",...
    "Hmax", max(range(x),range(y))/problem.div);

points = msh.Nodes';
tri = msh.Elements(1:3,:)';

end