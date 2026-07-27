function inside = onSegment(x,y,x1,y1,x2,y2)

tol=1e-10;


cross = abs((x2-x1)*(y-y1) - ...
             (y2-y1)*(x-x1));


length = sqrt((x2-x1)^2+(y2-y1)^2);


distance = cross/length;


inside = distance < tol && ...
         x>=min(x1,x2)-tol && ...
         x<=max(x1,x2)+tol && ...
         y>=min(y1,y2)-tol && ...
         y<=max(y1,y2)+tol;

end