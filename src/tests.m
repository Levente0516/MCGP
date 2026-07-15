%%Example 12.3.2

L = 2;
H = 1;
N = 10;

BC.bal.type = "D";
BC.jobb.type = "D";
BC.also.type = "D";
BC.felso.type = "D";

BC.bal.value = @(y) 0*y;
BC.jobb.value = @(y) 0*y;
BC.also.value = @(x) x.*(x.^2 - 3*L*x + 2*L^2);
BC.felso.value = @(x) 0*x;

BC.bal.homogen = true;
BC.jobb.homogen = true;
BC.also.homogen = false;
BC.felso.homogen = true;

u = LaplaceSolver(L,H,N,BC);

visual(L,H,u)

%% Example 12.3.4

L = 2;
H = 1; 
N = 10;

BC.bal.type = "N";
BC.jobb.type = "N";
BC.also.type = "D";
BC.felso.type = "N";

BC.bal.value = @(y) 0*y;
BC.jobb.value = @(y) 0*y;
BC.also.value = @(x) 0*x;
BC.felso.value = @(x) x;

BC.bal.homogen = true;
BC.jobb.homogen = true;
BC.also.homogen = true;
BC.felso.homogen = false;

u = LaplaceSolver(L,H,N,BC);

visual(L,H,u)


%% Example 12.3.6

L = 2;
H = 1; 
N = 10;

BC.bal.type = "D";
BC.jobb.type = "N";
BC.also.type = "D";
BC.felso.type = "N";

BC.bal.value = @(y) y .* (2*y.^2 - 9*H*y + 12*H^2);
BC.jobb.value = @(y) 0*y;
BC.also.value = @(x) 0*x;
BC.felso.value = @(x) 0*x;

BC.bal.homogen = false;
BC.jobb.homogen = true;
BC.also.homogen = true;
BC.felso.homogen = true;

u = LaplaceSolver(L,H,N,BC);

visual(L,H,u)

%% Example 12.3.8

L = 2;
H = 1; 
N = 10;

BC.bal.type = "N";
BC.jobb.type = "N";
BC.also.type = "N";
BC.felso.type = "D";

BC.bal.value = @(y) 0*y;
BC.jobb.value = @(y) y-H;
BC.also.value = @(x) 0*x;
BC.felso.value = @(x) 0*x;

BC.bal.homogen = true;
BC.jobb.homogen = false;
BC.also.homogen = true;
BC.felso.homogen = true;

u = LaplaceSolver(L,H,N,BC);

visual(L,H,u)