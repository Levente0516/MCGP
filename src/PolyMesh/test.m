%% Hatszög

problem.x = [0,1,2,2,1,0,0];
problem.y = [0,0.5,0,-1,-1.5,-1,0];
    
problem.div = 10;

%problem.boundary(1).x = [0,1]; 
%problem.boundary(1).y = [0,0.5];
%problem.boundary(1).type = 'D';
%problem.boundary(1).value = 0;

[points, tri] = createMesh(problem);

visualize(problem,points, tri);

%% Háromszög

problem.x = [0,1,2,0];
problem.y = [0,1,0,0];

problem.div = 10;

[points, tri] = createMesh(problem);

visualize(problem,points, tri);

%% konvex deltoid

problem.x = [0,1,2,1,0];
problem.y = [0,1,0,-2,0];

problem.div = 10;

[points, tri] = createMesh(problem);

visualize(problem,points, tri);

%% konkáv deltoid

problem.x = [0,1,2,1,0];
problem.y = [0,-1,0,-2,0];

problem.div = 10;

[points, tri] = createMesh(problem);

visualize(problem,points, tri);

%% random sokszög

problem.x = [0,0.5,1,0.5,2.5, 0.2, 0];
problem.y = [0,-2,-2.5,-1,-1.3, 1, 0];

problem.div = 10;

[points, tri] = createMesh(problem);

visualize(problem,points, tri);