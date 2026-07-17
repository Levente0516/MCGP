function [u] = Solver(curve)

t = linspace(curve.alpha, curve.beta, curve.div.def);

x = curve.x(t);
y = curve.y(t);

%creating the space where our shape fits perfectly
xx = linspace(min(x), max(x), curve.div.x);
yy = linspace(min(y), max(y), curve.div.y);

%creating the grid of that space
[X,Y] = meshgrid(xx,yy);

%stepsizes
hx = xx(2)-xx(1); 
hy = yy(2)-yy(1);

%checking which of these points of the grid is in and on, in our shape
inside = inpolygon(X, Y, x, y);

%megnezzuk mely pontoknak van a síkidom kívüli szomszédjuk
hasOutsideNeighbor = false(size(inside));
hasOutsideNeighbor(2:end-1,2:end-1) = ...
    ~inside(1:end-2,2:end-1) | ~inside(3:end,2:end-1) | ...
    ~inside(2:end-1,1:end-2) | ~inside(2:end-1,3:end);
hasOutsideNeighbor([1 end],:) = true;
hasOutsideNeighbor(:,[1 end]) = true;

%boundaryCells = inside & hasOutsideNeighbor;   %perem
trueInside    = inside & ~hasOutsideNeighbor; %tényleges belső pontok

boundaryCells = cell(curve.bounds,1);

for n = 1:curve.bounds

    tt = linspace(curve.boundary(n).alpha,...
                  curve.boundary(n).beta,...
                  curve.div.def);

    xb = curve.x(tt);
    yb = curve.y(tt);

    segmentMask = false(size(X));

    for m = 1:length(xb)

        distance = (X-xb(m)).^2 + (Y-yb(m)).^2;

        segmentMask = segmentMask | ...
                      distance < max(hx,hy)^2;

    end

    boundaryCells{n} = segmentMask;

end

u = zeros(size(X));

for n = 1:curve.bounds

    if curve.boundary(n).type == "D"
        
        cells = boundaryCells{n};

        if isa(curve.boundary(n).value,'function_handle')

            u(cells) = curve.boundary(n).value(X(cells),Y(cells));
        else
            u(cells) = curve.boundary(n).value;
        end
    end
end




%Jegyzetben:
%   u(k-1,j) - 2*u(k,j) + u(k+1,j)/hx^2 + ... = f(k,j)
%   de mivel most Laplace-re oldunk meg a jobb oldal 0
%   így u(k-1,j) - 2*u(k,j) + u(k+1,j)/hx^2 + ... = 0
%   ha felszorzunk a nevezőben lévő tagokkal, majd kibontunk
%   akkor kitudjuk fejezni u(k,j) -t
%   majd megoldjuk egy iterációs módszerrel (jelenleg Gauss-Seidel)

omega = 1;

for k = 1:curve.iterSteps
    for i = 2:size(u,1)-1
        for j = 2:size(u,2)-1
            if trueInside(i,j)
                u_new = (hy^2 * (u(i-1,j) + u(i+1,j)) + ...
                    hx^2 * (u(i,j-1) + u(i,j+1))) / (2 * (hx^2 + hy^2));
                u(i,j) = (1-omega)*u(i,j) + omega*u_new;
            end
        end
    end
end

end