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

c = problem.c;


switch problem.RBFtype

    case 'G'

        phi = @(r) exp(-(c*r).^2);

        lapPhi = @(r) ...
            4*c^2 .* (c^2*r.^2 - 1) .* ...
            exp(-(c*r).^2);

        dPhi_dn = @(xi,xj,n) ...
            -2*c^2 * dot(xi-xj,n) * ...
            phi(norm(xi-xj));


    case 'M'

        phi = @(r) sqrt(r.^2 + c.^2);

        lapPhi = @(r) ...
            (r.^2 + 2*c.^2) ./ ...
            (r.^2 + c.^2).^(3/2);

        dPhi_dn = @(xi,xj,n) ...
            dot(xi-xj,n) / ...
            sqrt(norm(xi-xj)^2 + c^2);


    case 'S'

        phi = @(r) (r > 0) .* r.^2 .* log(r);

        lapPhi = @(r) 4*log(r) + 4;

        dPhi_dn = @(xi,xj,n) ...
            (2*log(norm(xi-xj)) + 1) * ...
            dot(xi-xj,n);

end

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