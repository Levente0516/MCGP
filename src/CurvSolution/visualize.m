function [] = visualize(curve)

t = linspace(curve.alpha,curve.beta,curve.div);

x = curve.x(t);
y = curve.y(t);

hold on;
plot(x,y,'Color','w')
axis equal tight
grid on

for n = 1:curve.bounds

    if  curve.boundary(n).type == "D"
        tt = linspace(curve.boundary(n).alpha, ...
            curve.boundary(n).beta, curve.div);
        xx = curve.x(tt);
        yy = curve.y(tt);
        plot(xx,yy, 'Color', 'r')

    elseif curve.boundary(n).type == "N"
        tt = linspace(curve.boundary(n).alpha, ...
            curve.boundary(n).beta, curve.div);
        xx = curve.x(tt);
        yy = curve.y(tt);
        plot(xx,yy, 'Color', 'b')

    end

end

hold off;