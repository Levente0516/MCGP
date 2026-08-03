function [points,uValue,K] = MLSSolution(problem)

k = 1;

%% 1.
% Pontfelhő generálás Omegában
[insidePoints] = genInsidePoints(problem);

% Pontok felvétele Gammán
[boundaryPoints,boundaryType,...
    boundaryValue,boundaryNormal] = genBoundaryPoints(problem);

% Pontok összeszedése
points = [boundaryPoints; insidePoints];

Nb = size(boundaryPoints,1);
N = size(insidePoints,1);
TotalN = N + Nb;

% Bázis függvény --> 

% Súly függvény --> function [w] = GaussianWeightFunc(k,d,r,c)


% súlyfv parciális deriváltjai
wx = @(dx,d,r,c) ...
    (-2*k*dx/c^2).*exp(-(d/c).^2*k) ...
    /(1-exp(-(r/c).^2*k));

wy = @(dy,d,r,c) ...
    (-2*k*dy/c^2).*exp(-(d/c).^2*k) ...
    /(1-exp(-(r/c).^2*k));

% Stiffnes matrix és "load" vector
K = zeros(TotalN, TotalN);
F = zeros(TotalN, 1);

% 2. sub-domain létrehozás
center = zeros(TotalN,2);
radius = zeros(TotalN,1);

for i = 1:TotalN

    idx = knnsearch(points, points(i,:), 'K', problem.gamma);

    r = vecnorm(points(idx,:)-points(i,:),2,2);

    rs = 1.2*max(r) + 0.01;

    center(i,:) = points(i,:);
    radius(i) = rs;
end

% 3.
for i = 1: TotalN
    
    %3.1.
    [xQ,weightQ,xQb,weightQb] = ...
        generateQuadraturePoints(center(i,:), radius(i), problem);

    xQt = [xQ; xQb];

    if i <= Nb && boundaryType(i)==0
        
        K(i,:)=0;
        K(i,i)=1;
        F(i)=boundaryValue(i);

    else
        xi_center = center(i,:); 
        for j = 1: size(xQ,1)
            
            % 3(a)
            x = xQ(j,:);
    
            d = vecnorm(points-x,2,2);
            
            delta = radius(i)/2;
    
            xi = zeros(size(d));
    
            idx = d <= radius(i);
            
            xi(idx) = GaussianWeightFunc(1,d(idx), radius(i), delta);
            
            active = find(xi > 0);
    
            nodes = points(active,:);
            %weights = xi(active);
            dist = d(active);
            
            % 3(b)
            [shape, shapeDx, shapeDy] = ...
                calcShapefuncAndDeriv(x,nodes,radius(i),dist);
            
            % 3(c)
            dSrc  = norm(x - xi_center);
            dxSrc = x(1) - xi_center(1);
            dySrc = x(2) - xi_center(2);
        
            vx = wx(dxSrc, dSrc, radius(i), delta);
            vy = wy(dySrc, dSrc, radius(i), delta);

            integrand1 = (shapeDx*vx + shapeDy*vy) * weightQ(j);
    
            K(i,active) = K(i,active) + integrand1;
        end

        alpha = 1e3;

        for jb = 1: size(xQb,1)

            xb = xQb(jb,:);

            d = vecnorm(points-xb,2,2);
            idxb = d <= radius(i);
            xib = zeros(size(d));
            xib(idxb) = GaussianWeightFunc(1,d(idxb),radius(i),delta);
            activeb = find(xib > 0);
            nodesb = points(activeb,:);
            distb = d(activeb);

            [shapeb, shapeDxb, shapeDyb] = ...
                calcShapefuncAndDeriv(xb, nodesb, radius(i), distb);

            [btype, bvalue, bnormal] = nearestBoundaryInfo(xb, problem);

            dSrc = norm(xb - xi_center);
            vb = GaussianWeightFunc(1,dSrc,radius(i),delta);

            if btype == 0
                % Dirichlet: penalty + a normálderivált tag
                shapeDn = shapeDxb*bnormal(1) + shapeDyb*bnormal(2);

                K(i,activeb) = K(i,activeb) ...
                    + alpha*shapeb*vb*weightQb(jb) ...
                    - shapeDn*vb*weightQb(jb);

                F(i) = F(i) + alpha*bvalue*vb*weightQb(jb);
            else
                % Neumann: közvetlen fluxus a jobb oldalon
                F(i) = F(i) + bvalue*vb*weightQb(jb);
            end
        end
    end
end

u = K\F;

uValue = zeros(TotalN,1);
ux = zeros(TotalN,1);
uy = zeros(TotalN,1);

for i = 1:TotalN

    x = points(i,:);

    d = vecnorm(points-x,2,2);

    idx = d <= radius(i);

    active = find(idx);

    nodes = points(active,:);

    %delta = radius(i)/2;

    %weights = GaussianWeightFunc(1,d(idx),radius(i),delta);

    [shape,shapeDx,shapeDy] = ...
        calcShapefuncAndDeriv(x,nodes,radius(i),d(idx));

    coeff = u(active);

    uValue(i) = shape*coeff;
    ux(i) = shapeDx*coeff;
    uy(i) = shapeDy*coeff;

end
end