function [] = visualize(curve, u)

t = linspace(curve.alpha,curve.beta,curve.div.def);

x = curve.x(t);
y = curve.y(t);

xx = linspace(min(x), max(x), curve.div.x);
yy = linspace(min(y), max(y), curve.div.y);

[X,Y] = meshgrid(xx,yy);

inside = inpolygon(X,Y,x,y);

u_plot = u;
u_plot(~inside) = NaN;

%hold on;
%plot(x,y,'Color','w')
%axis equal tight
%grid on

%for n = 1:curve.bounds
%
%    if  curve.boundary(n).type == "D"
%        tt = linspace(curve.boundary(n).alpha, ...
%            curve.boundary(n).beta, curve.div);
%        xx = curve.x(tt);
%        yy = curve.y(tt);
%        plot(xx,yy, 'Color', 'r')
%
%    elseif curve.boundary(n).type == "N"
%        tt = linspace(curve.boundary(n).alpha, ...
%            curve.boundary(n).beta, curve.div);
%        xx = curve.x(tt);
%        yy = curve.y(tt);
%        plot(xx,yy, 'Color', 'b')
%
%    end
%
%end

subplot(1,2,1);

contourf(X, Y, u_plot, 20, 'LineColor','none');
colorbar;
xlabel('x'); 
ylabel('y');
title('');
axis equal tight; 
colormap turbo;


subplot(1,2,2)

surf(X,Y,u_plot)
xlabel("x")
ylabel("y")
zlabel("u(x,y)")
title("")
shading interp