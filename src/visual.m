function [] = visual(L,H,u)

x = linspace(0,L,100);
y = linspace(0,H,100);

[X,Y] = meshgrid(x,y);


subplot(1,2,1)

surf(X,Y,u)
xlabel("x")
ylabel("y")
zlabel("u(x,y)")
title("Laplace-egyenlet")
shading interp

subplot(1,2,2)

contourf(X, Y, u, 20, 'LineColor','none');
colorbar;
xlabel('x'); 
ylabel('y');
title('Laplace-egyenlet');
axis equal tight; 
colormap turbo;
