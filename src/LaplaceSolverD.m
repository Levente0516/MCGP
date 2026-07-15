%  (0,H)  -----------  (L,H)
%        |           |
%        |           |
%        |           |
%  (0,0)  -----------  (L,0) 
%
% u_xx + u_yy = 0
% u(x,0) = f_0 (x)     , 0 <= x <= L    alsó
% u(x,H) = f_1 (x)     , 0 <= x <= L    felső
% u(0,y) = g_0 (y)     , 0 <= y <= H    bal
% u(L,y) = g_1 (y)     , 0 <= y <= H    jobb

L = 2; H = 1;
x = linspace(0, L, 100);
y = linspace(0, H, 100);
[X, Y] = meshgrid(x, y);

N = 10; % iteráció

%Peremfeltételek

f_0 = @(x) x.*(x.^2 - 3*L*x + 2*L^2);     %also
f_1 = @(x) 0;   %felso
g_0 = @(y) 0;   %bal
g_1 = @(y) 0;   %jobb

U = zeros(size(X));

for n = 1:N

    An_1 = (2/L)*integral(@(t) ...
        f_0(t).*sin(n*pi*t/L),0,L);

    An_2 = (2/L)*integral(@(t) ...
        f_1(t).*sin(n*pi*t/L), 0, L);

    An_3 = (2/H)*integral(@(t) ...
        g_0(t).*sin(n*pi*t/H), 0, H);

    An_4 = (2/H)*integral(@(t) ...
        g_1(t).*sin(n*pi*t/H), 0, H); 

    U = U + An_1 * sin(n*pi*X/L) ...
        .* (sinh(n*pi*(H - Y)/L) ./ sinh(n*pi*H/L)); % also

    U = U + An_2 * sin(n*pi*X/L) ...
        .* (sinh(n*pi*(Y)/L) ./ sinh(n*pi*H/L)); % felso

    U = U + An_3 * sin(n*pi*Y/H) ...
        .* (sinh(n*pi*(L - X)/L) ./ sinh(n*pi*L/H)); % bal

    U = U + An_4 * sin(n*pi*Y/H) ...
        .* (sinh(n*pi*(X)/H) ./ sinh(n*pi*L/H)); % jobb   
end


contourf(X, Y, U, 20, 'LineColor','none');
colorbar;
xlabel('x'); 
ylabel('y');
title('Laplace-egyenlet Dirichlet peremfeltétellel');
axis equal tight; 
colormap turbo;
