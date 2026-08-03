function [boundaryPoints,boundaryType,...
    boundaryValue,boundaryNormal] = genBoundaryPoints(problem)

Nb = length(problem.boundary);

Ninside = problem.points;

N = round(0.5*sqrt(Ninside)*4);

boundaryPoints = zeros(N,2);
boundaryType = zeros(N,1);
% 0 = Dirichlet
% 1 = Neumann
boundaryValue = zeros(N,1);
boundaryNormal = zeros(N,2);

% közelítő belső pont a normál irány ellenőrzéséhez
center = [
    mean(problem.x(1:end-1))
    mean(problem.y(1:end-1))
]';

pointsPerBoundary = floor(N/Nb);

% pointsPerBoundary = floor(N/Nb);

counter = 1;

for k = 1:Nb


    % utolsó oldal kapja a maradékot
    if k == Nb
        n = N-counter+1;
    else
        n = pointsPerBoundary;
    end


    x1 = problem.boundary(k).x(1);
    x2 = problem.boundary(k).x(2);

    y1 = problem.boundary(k).y(1);
    y2 = problem.boundary(k).y(2);


    t = linspace(0,1,n+1);
    t = t(1:end-1);

    x = x1 + t*(x2-x1);
    y = y1 + t*(y2-y1);



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

     % él iránya

    dx = x2-x1;
    dy = y2-y1;


    % egyik normál

    nx = -dy;
    ny = dx;


    % normalizálás

    len = sqrt(nx^2+ny^2);

    nx = nx/len;
    ny = ny/len;



    % él közepe

    mx = (x1+x2)/2;
    my = (y1+y2)/2;



    % vektor az él közepétől befelé

    vx = center(1)-mx;
    vy = center(2)-my;



    % ha a normál befelé mutat, fordítsuk meg

    if nx*vx + ny*vy > 0

        nx = -nx;
        ny = -ny;

    end



    % minden ponthoz ugyanaz a normál ezen az élen

    boundaryNormal(idx,:) = repmat([nx ny],n,1);


    counter = counter+n;


end

end