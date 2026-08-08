function boundaryEdges = findBoundaryEdges(points,tri,problem)

% Összes él kigyűjtése
edges = zeros(3*size(tri,1),2);

counter = 0;

for e = 1:size(tri,1)

    nodes = tri(e,:);

    localEdges = [
        nodes(1) nodes(2)
        nodes(2) nodes(3)
        nodes(3) nodes(1)
    ];

    for k = 1:3
        
        counter = counter + 1;

        edges(counter,:) = sort(localEdges(k,:));

    end

end


edges = edges(1:counter,:);


% Duplikált élek keresése

[uniqueEdges,~,idx] = unique(edges,'rows');

count = accumarray(idx,1);


% Ami egyszer szerepel az peremél

boundaryEdges.nodes = uniqueEdges(count==1,:);


N = size(boundaryEdges.nodes,1);


% Perem ID inicializálás

boundaryEdges.id = zeros(N,1);

% Megnézzük melyik boundary-hoz tartozik

for e = 1:N

    i = boundaryEdges.nodes(e,1);
    j = boundaryEdges.nodes(e,2);

    x1 = points(i,1);
    y1 = points(i,2);

    x2 = points(j,1);
    y2 = points(j,2);

    xm = (x1+x2)/2;
    ym = (y1+y2)/2;

    tol = 2/problem.div;

    for k = 1:length(problem.boundary)

        t = linspace(problem.boundary(k).alpha,...
                     problem.boundary(k).beta,200);

        xb = problem.x(t);
        yb = problem.y(t);

        d = (xb-xm).^2 + (yb-ym).^2;

        if min(d) < tol^2
            boundaryEdges.id(e) = k;
            break
        end

    end

end

end