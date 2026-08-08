function [points,u,lambda,A,b] = RBF(problem)

% Pontok generálása

if problem.type == "Curv"
    insidePoints = genInsidePointsCurv(problem);
    
    [boundaryPoints,boundaryType,...
     boundaryValue,boundaryNormal] = genBoundaryPointsCurv(problem);
else
    insidePoints = genInsidePointsPoly(problem);
    
    [boundaryPoints,boundaryType,...
     boundaryValue,boundaryNormal] = genBoundaryPointsPoly(problem);
end

points = [
    boundaryPoints;
    insidePoints
];

Nb = size(boundaryPoints,1);
Ntotal = size(points,1);

fprintf("Boundary points: %d\n", Nb);

epsilon = problem.epsilon;

phi = @(r) exp(-(epsilon*r).^2);

% 2D Laplace
lapPhi = @(r) ...
    4*epsilon^2 .* (epsilon^2*r.^2 - 1) ...
    .* exp(-(epsilon*r).^2);

% Normal derivative of phi
dPhi_dn = @(xi,xj,n) ...
    -2*epsilon^2 * dot(xi-xj,n) * phi(norm(xi-xj));


A = zeros(Ntotal,Ntotal);
b = zeros(Ntotal,1);


for i = 1:Ntotal

    xi = points(i,:);

    for j = 1:Ntotal

        xj = points(j,:);

        r = norm(xi-xj);

        if i <= Nb
            
            % Dirichlet
            if boundaryType(i) == 0

                A(i,j) = phi(r);
            % Neumann
            elseif boundaryType(i) == 1

                A(i,j) = dPhi_dn(xi,xj,boundaryNormal(i,:));

            end

        else

            % Laplace
            A(i,j) = lapPhi(r);

        end

    end

    if i <= Nb

        b(i) = boundaryValue(i);

    else

        % Laplace
        b(i) = 0;

    end

end


lambda = A\b;

u = zeros(Ntotal,1);

for i = 1:Ntotal

    xi = points(i,:);

    for j = 1:Ntotal

        r = norm(xi-points(j,:));

        u(i) = u(i) + lambda(j)*phi(r);

    end

end

end