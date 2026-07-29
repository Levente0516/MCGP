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

problem.div = 20;

[points, tri] = createMesh(problem);

u = Solution(problem, points, tri);

visualize(problem, points, tri, u);

%% Ellipszis

clear;

problem.x = @(t) 2*cos(t);
problem.y = @(t) sin(t);

problem.alpha = 0;
problem.beta = 2*pi;

problem.boundary(1).alpha = 0; 
problem.boundary(1).beta = pi;
problem.boundary(1).type = 'D';
problem.boundary(1).value = @(x,y) sin(x);

problem.boundary(2).alpha = pi; 
problem.boundary(2).beta = 2*pi;
problem.boundary(2).type = 'N';
problem.boundary(2).value = @(x,y) 0;


problem.div = 50;

[points, tri] = createMesh(problem);

u = Solution(problem, points, tri);

visualize(problem, points, tri, u);
%% Csillag

clear;

problem.x = @(t) (1 + 0.3*cos(5*t)).*cos(t);
problem.y = @(t) (1 + 0.3*cos(5*t)).*sin(t);

problem.alpha = 0;
problem.beta = 2*pi;

problem.boundary(1).alpha = 0; 
problem.boundary(1).beta = pi;
problem.boundary(1).type = 'N';
problem.boundary(1).value = @(x,y) sin(x) + cos(x);

problem.boundary(2).alpha = pi; 
problem.boundary(2).beta = 2*pi;
problem.boundary(2).type = 'D';
problem.boundary(2).value = @(x,y) 0;

problem.div = 50;

[points, tri] = createMesh(problem);

u = Solution(problem, points, tri);

visualize(problem, points, tri, u);

%% Virág

clear;

problem.x = @(t) (1 + 0.2*sin(8*t)).*cos(t);
problem.y = @(t) (1 + 0.2*sin(8*t)).*sin(t);

problem.alpha = 0;
problem.beta = 2*pi;

problem.boundary(1).alpha = 0; 
problem.boundary(1).beta = pi;
problem.boundary(1).type = 'N';
problem.boundary(1).value = @(x,y) sin(x) + cos(x);

problem.boundary(2).alpha = pi; 
problem.boundary(2).beta = 2*pi;
problem.boundary(2).type = 'D';
problem.boundary(2).value = @(x,y) 0;

problem.div = 50;

[points, tri] = createMesh(problem);

u = Solution(problem, points, tri);

visualize(problem, points, tri, u);
%% Szív

clear;

problem.x = @(t) 16*sin(t).^3 / 16;
problem.y = @(t) (13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t))/16;

problem.alpha = 0;
problem.beta = 2*pi;

problem.boundary(1).alpha = 0; 
problem.boundary(1).beta = pi;
problem.boundary(1).type = 'N';
problem.boundary(1).value = @(x,y) sin(x) + cos(x);

problem.boundary(2).alpha = pi; 
problem.boundary(2).beta = 2*pi;
problem.boundary(2).type = 'D';
problem.boundary(2).value = @(x,y) 0;

problem.div = 20;

[points, tri] = createMesh(problem);

u = Solution(problem, points, tri);

visualize(problem, points, tri, u);
%% Random

clear;

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

problem.boundary(1).alpha = 0; 
problem.boundary(1).beta = pi;
problem.boundary(1).type = 'N';
problem.boundary(1).value = @(x,y) sin(x) + cos(x);

problem.boundary(2).alpha = pi; 
problem.boundary(2).beta = 2*pi;
problem.boundary(2).type = 'D';
problem.boundary(2).value = @(x,y) 0;

problem.div = 40;

[points, tri] = createMesh(problem);

u = Solution(problem, points, tri);

visualize(problem, points, tri, u);