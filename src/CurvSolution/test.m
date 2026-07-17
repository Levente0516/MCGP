%% Circle

curve.x = @(t) sin(t);
curve.y = @(t) cos(t);

curve.alpha = 0;    %lower boundary for t
curve.beta = 2*pi;  %upper boundary for t   t \in [alpha, beta]

curve.div = 100; %divison of linspace

%Default
curve.boundary(1).alpha = 0;
curve.boundary(1).beta = 1.2*pi;
curve.boundary(1).type = "D";
curve.boundary(1).value = 0;

curve.boundary(2).alpha = 1.2*pi;
curve.boundary(2).beta = 2*pi;
curve.boundary(2).type = "N";
curve.boundary(2).value = 0;

curve.bounds = 2;

%Solver(curve)
visualize(curve)