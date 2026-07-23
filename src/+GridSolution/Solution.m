function [u] = Solution(grid,problem)

u = zeros(size(grid.X));
neum = false(size(grid.X));
neumID = zeros(size(grid.X));

hx = grid.X(1,2)-grid.X(1,1);
hy = grid.Y(2,1)-grid.Y(1,1);

for i = 1:size(u,1)
    for j = 1:size(u,2)
        if grid.boundary(i,j)
            x = grid.X(i,j);
            y = grid.Y(i,j);
            for k = 1:length(problem.boundary)
                if problem.type == "Poly"
                    if x >= min(problem.boundary(k).x) ...
                            && x <= max(problem.boundary(k).x) ...
                            && y >= min(problem.boundary(k).y) ...
                            && y <=  max(problem.boundary(k).y)
                        if problem.boundary(k).type == 'D'
                            u(i,j) = problem.boundary(k).value(x,y);
                        end
                        if problem.boundary(k).type == 'N'
                           neum(i,j) = true;
                           neumID(i,j) = k;
                        end
                    end
                end
                if problem.type == "Curv"
                    t = linspace(problem.boundary(k).alpha,...
                        problem.boundary(k).beta, problem.div);
                    
                    cx = problem.x(t);
                    cy = problem.y(t);
                
                    dist = sqrt((cx-x).^2+(cy-y).^2);
                
                    tolerance = max(hx,hy)*0.5;
                    
                    if min(dist) < tolerance
                
                        if problem.boundary(k).type == 'D'
                            u(i,j)=problem.boundary(k).value(x,y);
                        end
                
                        if problem.boundary(k).type == 'N'
                            neum(i,j)=true;
                            neumID(i,j)=k;
                        end
                
                    end
                end
            end
        end
    end
end

for k = 1:problem.iteration
    for i = 2:size(u,1) - 1
        for j = 2:size(u,2) - 1
            if grid.inside(i,j) && ~grid.boundary(i,j)
                up = u(i+1,j);
                down = u(i-1,j);
                left = u(i,j-1);
                right = u(i,j+1);
                if neum(i+1,j)
                    x = grid.X(i,j);
                    y = grid.Y(i,j);
                    g = problem.boundary(neumID(i+1,j)).value(x,y);
                    up = u(i,j) + hy*g;
                end
                if neum(i-1,j)
                    x = grid.X(i,j);
                    y = grid.Y(i,j);
                    g = problem.boundary(neumID(i-1,j)).value(x,y);
                    down = u(i,j) + hy*g;
                end
                if neum(i,j+1)
                    x = grid.X(i,j);
                    y = grid.Y(i,j);
                    g = problem.boundary(neumID(i,j+1)).value(x,y);
                    right = u(i,j) + hx*g;
                end
                if neum(i,j-1)
                    x = grid.X(i,j);
                    y = grid.Y(i,j);
                    g = problem.boundary(neumID(i,j-1)).value(x,y);
                    left = u(i,j) + hx*g;
                end
                
                new_u = 0.25 * ...
                    (up + ...
                    down + ...
                    right + ...
                    left);

                u(i,j) = (1 - problem.omega) * u(i,j) ...
                    + problem.omega * new_u;
            end
        end
    end
end

end