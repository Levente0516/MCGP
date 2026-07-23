%% Kör

problem.x = @(t) cos(t);
problem.y = @(t) sin(t);

problem.alpha = 0;
problem.beta = 2*pi;

problem.div = 20;

[points, tri] = createMesh(problem);

visualize(problem,points, tri);

%% Ellipszis


problem.x = @(t) 2*cos(t);
problem.y = @(t) sin(t);

problem.alpha = 0;
problem.beta = 2*pi;

problem.div = 20;

[points, tri] = createMesh(problem);

visualize(problem,points, tri);

%% Csillag

problem.x = @(t) (1 + 0.3*cos(5*t)).*cos(t);
problem.y = @(t) (1 + 0.3*cos(5*t)).*sin(t);

problem.alpha = 0;
problem.beta = 2*pi;

problem.div = 20;

[points, tri] = createMesh(problem);

visualize(problem,points, tri);

%% Virág

problem.x = @(t) (1 + 0.2*sin(8*t)).*cos(t);
problem.y = @(t) (1 + 0.2*sin(8*t)).*sin(t);

problem.alpha = 0;
problem.beta = 2*pi;

problem.div = 20;

[points, tri] = createMesh(problem);

visualize(problem,points, tri);

%% Szív

problem.x = @(t) 16*sin(t).^3 / 16;
problem.y = @(t) (13*cos(t)-5*cos(2*t)-2*cos(3*t)-cos(4*t))/16;

problem.alpha = 0;
problem.beta = 2*pi;

problem.div = 20;

[points, tri] = createMesh(problem);

visualize(problem,points, tri);

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

problem.div = 40;

[points, tri] = createMesh(problem);

visualize(problem,points, tri);