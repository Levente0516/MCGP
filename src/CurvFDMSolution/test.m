%% Curvs

%TODO

%% Kör

clear;

problem.x = @(t) cos(t);
problem.y = @(t) sin(t);

problem.alpha = 0;
problem.beta = 2*pi;

problem.boundary(1).alpha = 0; 
problem.boundary(1).beta = pi;
problem.boundary(1).type = 'D';
problem.boundary(1).value = @(x,y) 0.5;

problem.boundary(2).alpha = pi; 
problem.boundary(2).beta = 1.5*pi;
problem.boundary(2).type = 'D';
problem.boundary(2).value = @(x,y) 2;

problem.boundary(3).alpha = 1.5*pi; 
problem.boundary(3).beta = 2*pi;
problem.boundary(3).type = 'D';
problem.boundary(3).value = @(x,y) 0;


problem.div = 200;

problem.iteration = 1000;

problem.omega = 1.9;

grid1 = createGridApprox(problem);

grid2 = createGridMoving(problem);

u1 = Solution(grid1, problem);

u2 = Solution(grid2, problem);

visualize(u1,u2,grid1,grid2);

%% Ellipszis

problem.x = @(t) 2*cos(t);
problem.y = @(t) sin(t);

problem.alpha = 0;
problem.beta = 2*pi;

problem.div = 200;

problem.boundary(1).alpha = 0; 
problem.boundary(1).beta = pi;
problem.boundary(1).type = 'D';
problem.boundary(1).value = @(x,y) sin(x);

problem.boundary(2).alpha = pi; 
problem.boundary(2).beta = 2*pi;
problem.boundary(2).type = 'N';
problem.boundary(2).value = @(x,y) 0;

problem.iteration = 1000;

problem.omega = 1.9;

grid1 = createGridApprox(problem);

grid2 = createGridMoving(problem);

u1 = Solution(grid1, problem);

u2 = Solution(grid2, problem);

visualize(u1,u2,grid1,grid2);

%% Random

a = [0.15, 0.1, 0.05];
k = [3, 5, 8];

problem.x = @(t) ...
    (1 + a(1)*cos(k(1)*t) ...
       + a(2)*sin(k(2)*t) ...
       + a(3)*cos(k(3)*t)).*cos(t);


problem.y = @(t) ...
    (1 + a(1)*cos(k(1)*t) ...
       + a(2)*sin(k(2)*t) ...
       + a(3)*cos(k(3)*t)).*sin(t);


problem.alpha = 0;
problem.beta = 2*pi;

problem.div = 200;

problem.boundary(1).alpha = 0; 
problem.boundary(1).beta = pi;
problem.boundary(1).type = 'N';
problem.boundary(1).value = @(x,y) sin(x) + cos(x);

problem.boundary(2).alpha = pi; 
problem.boundary(2).beta = 2*pi;
problem.boundary(2).type = 'D';
problem.boundary(2).value = @(x,y) 0;

problem.iteration = 1000;

problem.omega = 1.9;

grid1 = createGridApprox(problem);

grid2 = createGridMoving(problem);

u1 = Solution(grid1, problem);

u2 = Solution(grid2, problem);

visualize(u1,u2,grid1,grid2);