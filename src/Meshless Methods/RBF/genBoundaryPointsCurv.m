function [boundaryPoints,boundaryType,...
    boundaryValue,boundaryNormal] = genBoundaryPointsCurv(problem)

Nb = length(problem.boundary);

Ninside = problem.points;

N = round(0.5*sqrt(Ninside)*4);

boundaryPoints = zeros(N,2);
boundaryType = zeros(N,1);
% 0 = Dirichlet
% 1 = Neumann
boundaryValue = zeros(N,1);
boundaryNormal = zeros(N,2);

% Numerikus derivált 
dxdt = @(t) (problem.x(t + 1e-6) - problem.x(t - 1e-6)) / (2e-6); 
dydt = @(t) (problem.y(t + 1e-6) - problem.y(t - 1e-6)) / (2e-6);

pointsPerBoundary = floor(N/Nb);

counter = 1;

for k = 1:Nb


    % utolsó oldal kapja a maradékot
    if k == Nb
        n = N-counter+1;
    else
        n = pointsPerBoundary;
    end


    alpha = problem.boundary(k).alpha;
    beta = problem.boundary(k).beta;


    t = linspace(alpha,beta,n+1);
    t = t(1:end-1);

    x = problem.x(t); 
    y = problem.y(t);

    idx = counter:counter+n-1;


    boundaryPoints(idx,:) = [x(:),y(:)];

    if problem.boundary(k).type == 'N'
        boundaryType(idx) = 1;
    end


    for i = idx

        boundaryValue(i)=problem.boundary(k).value(...
            boundaryPoints(i,1),...
            boundaryPoints(i,2));

    end

    for j = 1:n 
        
        tj = t(j); 
        
        % Tangens 
        tx = dxdt(tj); 
        ty = dydt(tj);

        % Egy normálvektor 
        nx = ty; 
        ny = -tx; 

        % Normalizálás 
        len = sqrt(nx^2 + ny^2); 
        nx = nx/len; 
        ny = ny/len; 

        % Boundary pont 
        px = x(j); 
        py = y(j); 

        % Egy kis lépés a normál irányába 
        testPoint = [ px + 1e-5*nx, py + 1e-5*ny ];

        % A tesztpontnak kívül kell lennie 
        inside = inpolygon(testPoint(1),testPoint(2),problem.x(linspace(... 
            problem.alpha,2000)),problem.y(linspace(problem.alpha,2000))); 

        % Ha a normál befelé mutat, % megfordítjuk 
        if inside 
            nx = -nx; 
            ny = -ny; 
        end 
        boundaryNormal(idx(j),:) = [nx,ny]; 
    end 
    
    counter = counter+n;


end

end