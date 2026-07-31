function [points,u] = GlobalRBF(problem)

% generating points INSIDE the shape

N = problem.points;

insidePoints = genInsidePoints(problem);
[boundaryPoints,boundaryType,...
    boundaryValue,boundaryNormal] = genBoundaryPoints(problem);

points = [
    boundaryPoints;
    insidePoints
    ];

Nb=size(boundaryPoints,1);

epsilon = problem.epsilon;

phi = @(r) exp(-(epsilon*r).^2);

lapPhi = @(r) 4*epsilon^2*(epsilon^2*r.^2-1).*exp(-(epsilon*r).^2);

dPhi_dn = @(xi,xj,n) -2*epsilon^2 * (dot(xi-xj,n)) * phi(norm(xi-xj));

Ntotal=size(points,1);

A = zeros(Ntotal,Ntotal);
b = zeros(Ntotal,1);

for i = 1:Ntotal

    for j = 1:Ntotal

        r = norm(points(i,:)-points(j,:));


        if i<=Nb

            if boundaryType(i) == 0
                
                % Dirichlet
        
                A(i,j) = phi(r);
        
        
            elseif boundaryType(i)==1
                
                % Neumann
            
                A(i,j)=dPhi_dn(points(i,:),points(j,:),boundaryNormal(i,:));
        
            end
        
        
        else
        
            A(i,j) = lapPhi(r);
        
        end

    end


    if i <= Nb

        b(i) = boundaryValue(i);

    else

        b(i) = 0;

    end

end

fprintf("rank(A) = %d / %d\n",rank(A),size(A,1));
fprintf("cond(A) = %.3e\n",cond(A));

lambda=(A+1e-12*eye(size(A)))\b;

u=zeros(Ntotal,1);


for i=1:Ntotal

    for j=1:Ntotal

        r=norm(points(i,:)-points(j,:));

        u(i)=u(i)+lambda(j)*phi(r);

    end

end

end