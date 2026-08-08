function [shape, shapeDx, shapeDy] = calcShapefuncAndDeriv(x, nodes, r, d)

k = 1;

delta = r/2;

xi = zeros(size(d));

idx = d <= r;

xi(idx) = GaussianWeightFunc(1,d(idx),r,delta);

% P
dx = nodes(:,1)-x(1);
dy = nodes(:,2)-x(2);
P = [ones(size(dx)), dx, dy, dx.^2, dx.*dy, dy.^2]; 


% W
W = diag(xi);

% B(x)
B = P.'*W;

% A(x)
A = B*P;

% shape function 
pQ = [1;0;0;0;0;0];

C = A\B;

shape = pQ'*C;

% Px és Py
Px = [ ...
    zeros(size(dx)), ...
    -ones(size(dx)), ...
    zeros(size(dx)), ...
    -2*dx, ...
    -dy, ...
    zeros(size(dx))];

Py = [ ...
    zeros(size(dx)), ...
    zeros(size(dx)), ...
    -ones(size(dx)), ...
    zeros(size(dx)), ...
    -dx, ...
    -2*dy];

% wx és wy
dx = x(1)-nodes(:,1);
dy = x(2)-nodes(:,2);

c = delta;

wx = ((-2*k*dx/c^2).*exp(-(d/c).^2*k)) ...
     /(1-exp(-(r/c)^2*k));

wy = ((-2*k*dy/c^2).*exp(-(d/c).^2*k)) ...
     /(1-exp(-(r/c)^2*k));

% Wx és Wy 
Wx = diag(wx);
Wy = diag(wy);

% Ax és Ay
Ax = Px.'*W*P + P.'*Wx*P + P.'*W*Px;

Ay = Py.'*W*P + P.'*Wy*P + P.'*W*Py;

% Bx és By
Bx = Px.'*W + P.'*Wx;

By = Py.'*W + P.'*Wy;

% Derivatives Cx and Cy

Cx = -A\(Ax*C) + A\Bx;

Cy = -A\(Ay*C) + A\By;

%shapeD
pQx = [0;-1;0;0;0;0];
pQy = [0;0;-1;0;0;0];

shapeDx = pQx.'*C + pQ.'*Cx;
shapeDy = pQy.'*C + pQ.'*Cy;