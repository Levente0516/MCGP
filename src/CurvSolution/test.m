%% Circle

curve.x = @(t) sin(t);
curve.y = @(t) cos(t);

curve.alpha = 0;    %lower boundary for t
curve.beta = 2*pi;  %upper boundary for t   t \in [alpha, beta]

curve.div.def = 1000; %divison of linspace
curve.div.x = 200;
curve.div.y = 200;

%Default
curve.boundary(1).alpha = 0;
curve.boundary(1).beta = 0.7*pi;
curve.boundary(1).type = "D";
curve.boundary(1).value = @(x,y) sin(3*x).*cos(2*y);

curve.boundary(2).alpha = 0.7*pi;
curve.boundary(2).beta = 1.2*pi;
curve.boundary(2).type = "D";
curve.boundary(2).value = @(x,y) sin(3*x).*cos(2*y);

curve.boundary(3).alpha = 1.2*pi;
curve.boundary(3).beta = 1.8*pi;
curve.boundary(3).type = "D";
curve.boundary(3).value = @(x,y) sin(3*x).*cos(2*y);

curve.boundary(4).alpha = 1.8*pi;
curve.boundary(4).beta = 2*pi;
curve.boundary(4).type = "D";
curve.boundary(4).value = @(x,y) sin(3*x).*cos(2*y);

curve.bounds = 4;

curve.iterSteps = 1000;
 
u = Solver(curve);
visualize(curve, u)