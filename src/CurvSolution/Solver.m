function [u] = Solver(curve)

t = linspace(curve.alpha, curve.beta, curve.div);

x = curve.x(t);
y = curve.y(t);

xmin = min(x);
xmax = max(x);

ymin = min(y);
ymax = max(y);

xx = linspace(xmin, xmax, curve.div);
yy = linspace(ymin, ymax, curve.div);

[X,Y] = meshgrid(xx,yy);

u = zeros(size(X));

end