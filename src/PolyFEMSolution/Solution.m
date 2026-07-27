function [u] = Solution(problem,points,tri)

N = size(points,1);

K = zeros(N,N);
F = zeros(N,1);

boundaryNodes = false(N,1);
%boundaryID = zeros(N,1);

for e = 1:size(tri,1)

    nodes = tri(e,:);

    x = points(nodes,1);
    y = points(nodes,2);

    A = 0.5*abs(det([1, x(1), y(1); ...
                     1, x(2), y(2); ...
                     1, x(3), y(3); ...
                     ]));
    
    b=[
        y(2)-y(3);
        y(3)-y(1);
        y(1)-y(2)
    ];

    c=[
        x(3)-x(2);
        x(1)-x(3);
        x(2)-x(1)
    ];

    Ke = zeros(3,3);
    
    
    for i = 1:3
        for j = 1:3

            Ke(i,j) = (b(i)*b(j)+c(i)*c(j))/(4*A);

        end
    end


    for i = 1:3
        for j = 1:3

            K(nodes(i),nodes(j)) = K(nodes(i),nodes(j)) + Ke(i,j);

        end
    end

end

for i = 1:N

    x = points(i,1);
    y = points(i,2);

    for k = 1:length(problem.boundary)
        
        xb = problem.boundary(k).x;
        yb = problem.boundary(k).y;


        if onSegment(x,y,xb(1),yb(1),xb(2),yb(2))

            boundaryNodes(i)=true;

        end

    end
    
end

for k=1:length(problem.boundary)


    type = problem.boundary(k).type;


    xb = problem.boundary(k).x;
    yb = problem.boundary(k).y;

    nodes=[];


    for i=1:N

        if onSegment(points(i,1),points(i,2),...
                xb(1),yb(1),xb(2),yb(2))

            nodes(end+1)=i;

        end

    end

    if type=='D'


        for i=nodes

            x=points(i,1);
            y=points(i,2);


            value = problem.boundary(k).value(x,y);


            K(i,:)=0;
            K(i,i)=1;

            F(i)=value;

        end

    elseif type=='N'

        L = sqrt((xb(2)-xb(1))^2 + ...
                 (yb(2)-yb(1))^2);

        xm=(xb(1)+xb(2))/2;
        ym=(yb(1)+yb(2))/2;


        g = problem.boundary(k).value(xm,ym);


        tol = 1e-10;
        
        n1 = find(abs(points(:,1)-xb(1)) < tol & ...
                  abs(points(:,2)-yb(1)) < tol);
        
        n2 = find(abs(points(:,1)-xb(2)) < tol & ...
                  abs(points(:,2)-yb(2)) < tol);


        F(n1)=F(n1)+g*L/2;
        F(n2)=F(n2)+g*L/2;


    end

end


u = K\F;


end