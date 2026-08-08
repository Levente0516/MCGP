function [u, walkPaths, walkRadii] = Solver(problem,xStart)

sum = 0;

walkPaths = cell(1, problem.nWalks);
walkRadii = cell(1, problem.nWalks);

for i = 1:problem.nWalks
    
    x = xStart;
    path = x;
    radii = [];
    R = inf;
    numlocalwalks = 0;

    while R > problem.tol && numlocalwalks < 16
        
        % legkisebb rádiusz megtalálása amely az adott pont középpontjából
        % beírható az alakzatba
        [R,boundaryID] = leastRadius(x, problem);
        

        % do - while ciklus cosplay
        if R <= problem.tol
            break;
        end

        radii = [radii; R];
        
        % random szög "eltolás"
        theta = rand() * 2 * pi;

        % új pont felvétele a körön az eltolás segítségével
        x = x + R * [cos(theta), sin(theta)];

        path = [path; x];

        numlocalwalks = numlocalwalks + 1;

    end

    sum = sum + problem.boundary(boundaryID).value(x(1),x(2));

    walkPaths{i} = path;
    walkRadii{i} = radii;

end

u = sum / problem.nWalks;

end