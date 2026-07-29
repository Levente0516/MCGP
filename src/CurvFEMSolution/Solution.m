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

boundaryEdges = findBoundaryEdges(points,tri,problem);

for e=1:size(boundaryEdges.nodes,1)


    nodes=boundaryEdges.nodes(e,:);


    id=boundaryEdges.id(e);

    if problem.boundary(id).type=='N'


        i=nodes(1);
        j=nodes(2);


        x1=points(i,1);
        y1=points(i,2);

        x2=points(j,1);
        y2=points(j,2);


        L=hypot(x2-x1,y2-y1);


        g1=problem.boundary(id).value(x1,y1);
        g2=problem.boundary(id).value(x2,y2);



        Fe=L/6*[
            2*g1+g2
            g1+2*g2
        ];


        F(i)=F(i)+Fe(1);
        F(j)=F(j)+Fe(2);


    end

    if problem.boundary(id).type=='D'


        nodes=boundaryEdges.nodes(e,:);


        for n=nodes

            x=points(n,1);
            y=points(n,2);


            value=problem.boundary(id).value(x,y);


            F=F-K(:,n)*value;


            K(:,n)=0;
            K(n,:)=0;

            K(n,n)=1;

            F(n)=value;


        end


    end

end

u = K\F;

end