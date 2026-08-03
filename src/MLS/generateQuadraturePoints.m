function [xQ_filtered,weightQ_filtered,xQb_filtered,weightQb_filtered] = ... 
    generateQuadraturePoints(center,rs,problem)

Nr = 10;
Nt = 24;

xQ = zeros(Nr*Nt,2);
weightQ = zeros(Nr*Nt,1);

dr = rs/Nr;
dtheta = 2*pi/Nt;

counter = 1;

for i = 1:Nr

    r = (i-0.5)*rs/Nr;

    for j = 1:Nt

        theta = 2*pi*(j-0.5)/Nt;

        xQ(counter,:) = [center(1)+r*cos(theta), center(2)+r*sin(theta)];
        
        weightQ(counter)=r*dr*dtheta;

        counter = counter+1;

    end
end

[in, on] = inpolygon(xQ(:,1), xQ(:,2), problem.x, problem.y);

valid_indices = in | on;
xQ_filtered = xQ(valid_indices, :);
weightQ_filtered = weightQ(valid_indices);


% boundary pontok
Nb = 30;

xQb = zeros(Nb,2);
weightQb = zeros(Nb,1);

for i = 1:Nb

    theta = 2*pi*(i-1)/Nb;

    xQb(i,:) = [center(1)+rs*cos(theta), center(2)+rs*sin(theta)];

    weightQb(i)=rs*dtheta;
end

[in, on] = inpolygon(xQb(:,1), xQb(:,2), problem.x, problem.y);

valid_indices = in | on;
xQb_filtered = xQb(valid_indices, :);
weightQb_filtered = weightQb(valid_indices);


end