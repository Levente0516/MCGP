%% Hatszög

problem.x = [0,1,2,2,1,0,0];
problem.y = [0,0.5,0,-1,-1.5,-1,0];

problem.div = 10;

problem.boundary(1).x = [0,1]; 
problem.boundary(1).y = [0,0.5];
problem.boundary(1).type = 'D';
problem.boundary(1).value = 0;

problem.boundary(2).x = [1,2]; 
problem.boundary(2).y = [0.5,0];
problem.boundary(2).type = 'N';
problem.boundary(2).value = 0;

problem.boundary(3).x = [2,2]; 
problem.boundary(3).y = [0,-1];
problem.boundary(3).type = 'D';
problem.boundary(3).value = 0;

problem.boundary(4).x = [2,1]; 
problem.boundary(4).y = [-1,-1.5];
problem.boundary(4).type = 'D';
problem.boundary(4).value = 0;

problem.boundary(5).x = [1,0]; 
problem.boundary(5).y = [-1.5,-1];
problem.boundary(5).type = 'N';
problem.boundary(5).value = 0;

problem.boundary(6).x = [0,0]; 
problem.boundary(6).y = [-1,0];
problem.boundary(6).type = 'D';
problem.boundary(6).value = 0;

geometry = createGrid(problem);

%geometry = createGridMoving(problem);

visualize(problem,geometry);

%% Háromszög

problem.x = [0,1,2,0];
problem.y = [0,1,0,0];

problem.div = 10;

problem.boundary(1).x = [0,1]; 
problem.boundary(1).y = [0,1];
problem.boundary(1).type = 'D';
problem.boundary(1).value = 1;

problem.boundary(2).x = [1,2]; 
problem.boundary(2).y = [1,0];
problem.boundary(2).type = 'N';
problem.boundary(2).value = 0;

problem.boundary(3).x = [2,0]; 
problem.boundary(3).y = [0,0];
problem.boundary(3).type = 'D';
problem.boundary(3).value = 1;

geometry = createGrid(problem);

visualize(problem,geometry);
