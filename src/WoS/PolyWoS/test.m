%% Simple rectangle (Example 12.3.2)

clear;
clc;

L = 2;
H = 1;

problem.x = [0,0,L,L,0];
problem.y = [0,H,H,0,0];

problem.boundary(1).x = [0,0];
problem.boundary(1).y = [0,1];
problem.boundary(1).value = @(x,y) 0;

problem.boundary(2).x = [0,L];
problem.boundary(2).y = [H,H];
problem.boundary(2).value = @(x,y) 0;

problem.boundary(3).x = [L,L];
problem.boundary(3).y = [H,0];
problem.boundary(3).value = @(x,y) 0;

problem.boundary(4).x = [L,0];
problem.boundary(4).y = [0,0];
problem.boundary(4).value = @(x,y) x.*(x.^2 - 3*L*x + 2*L^2);

% Walks/point
problem.nWalks = 400;
% Tolarencia
problem.tol = 0.01;
% Mintavételezett pont az alakzat belsejéből
problem.points = 2000;

[points, u, walkPath, walkRadius]  = Solution(problem);

visualize(points, problem, u, walkPath, walkRadius);


%% Rotated rectangle (Example 12.3.2 Rotated)

clear;

L = 2;
H = 1;

x = [0,0,L,L,0];
y = [0,H,H,0,0];

theta = deg2rad(30);

cx = L/2;
cy = H/2;

xr = x - cx;
yr = y - cy;

problem.x = xr*cos(theta) - yr*sin(theta) + cx;
problem.y = xr*sin(theta) + yr*cos(theta) + cy;

problem.boundary(1).x = [0,0];
problem.boundary(1).y = [0,1];
problem.boundary(1).value = @(x,y) 0;

problem.boundary(2).x = [0,L];
problem.boundary(2).y = [H,H];
problem.boundary(2).value = @(x,y) 0;

problem.boundary(3).x = [L,L];
problem.boundary(3).y = [H,0];
problem.boundary(3).value = @(x,y) 0;

problem.boundary(4).x = [L,0];
problem.boundary(4).y = [0,0];
problem.boundary(4).value = @(x,y) x.*(x.^2 - 3*L*x + 2*L^2);

problem.div = 50;

rotate = @(x,y) deal( ...
    (x-cx)*cos(theta)-(y-cy)*sin(theta)+cx, ...
    (x-cx)*sin(theta)+(y-cy)*cos(theta)+cy);

[problem.boundary(1).x, problem.boundary(1).y] = ...
    rotate(problem.boundary(1).x, problem.boundary(1).y);
[problem.boundary(2).x, problem.boundary(2).y] = ...
    rotate(problem.boundary(2).x, problem.boundary(2).y);
[problem.boundary(3).x, problem.boundary(3).y] = ...
    rotate(problem.boundary(3).x, problem.boundary(3).y);
[problem.boundary(4).x, problem.boundary(4).y] = ...
    rotate(problem.boundary(4).x, problem.boundary(4).y);

problem.boundary(4).value = @(x,y) ...
    ((x-cx)*cos(theta)+(y-cy)*sin(theta)+cx) .* ...
    (((x-cx)*cos(theta)+(y-cy)*sin(theta)+cx).^2 ...
    - 3*L*((x-cx)*cos(theta)+(y-cy)*sin(theta)+cx) ...
    + 2*L^2);

% Walks/point
problem.nWalks = 400;
% Tolarencia
problem.tol = 0.01;
% Mintavételezett pont az alakzat belsejéből
problem.points = 2000;

[points, u, walkPath, walkRadius]  = Solution(problem);

visualize(points, problem, u, walkPath, walkRadius);

%% Hatszög 

clear;

problem.x = [0,1,2,2,1,0,0];
problem.y = [0,0.5,0,-1,-1.5,-1,0];

problem.div = 50;

problem.boundary(1).x = [0,1]; 
problem.boundary(1).y = [0,0.5];
problem.boundary(1).value = @(x,y) 0;

problem.boundary(2).x = [1,2]; 
problem.boundary(2).y = [0.5,0];
problem.boundary(2).value = @(x,y) 0;

problem.boundary(3).x = [2,2]; 
problem.boundary(3).y = [0,-1];
problem.boundary(3).value = @(x,y) 0;

problem.boundary(4).x = [2,1]; 
problem.boundary(4).y = [-1,-1.5];
problem.boundary(4).value = @(x,y) 0;

problem.boundary(5).x = [1,0]; 
problem.boundary(5).y = [-1.5,-1];
problem.boundary(5).value = @(x,y) sin(x)*1.5;

problem.boundary(6).x = [0,0]; 
problem.boundary(6).y = [-1,0];
problem.boundary(6).value = @(x,y) 0;


% Walks/point
problem.nWalks = 400;
% Tolarencia
problem.tol = 0.01;
% Mintavételezett pont az alakzat belsejéből
problem.points = 2000;

[points, u, walkPath, walkRadius]  = Solution(problem);

visualize(points, problem, u, walkPath, walkRadius);
