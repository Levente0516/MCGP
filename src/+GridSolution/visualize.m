function [] = visualize(u1,u2,grid1,grid2)

clf
close all;
figure

u1_plot = u1;
u1_plot(~grid1.inside) = NaN;

u2_plot = u2;
u2_plot(~grid2.inside) = NaN;

subplot(1,2,1)

surf(grid1.X,grid1.Y,u1_plot)
xlabel("x")
ylabel("y")
zlabel("u(x,y)")
title("Approx.")
shading interp

subplot(1,2,2)

contourf(grid1.X, grid1.Y, u1_plot, 20, 'LineColor','none');
colorbar;
xlabel('x'); 
ylabel('y');
title('Approx.');
axis equal tight; 
colormap turbo;

figure

subplot(1,2,1)

surf(grid2.X,grid2.Y,u2_plot)
xlabel("x")
ylabel("y")
zlabel("u(x,y)")
title("Moving")
shading interp

subplot(1,2,2)

contourf(grid2.X, grid2.Y, u2_plot, 20, 'LineColor','none');
colorbar;
xlabel('x'); 
ylabel('y');
title('Moving');
axis equal tight; 
colormap turbo;

end