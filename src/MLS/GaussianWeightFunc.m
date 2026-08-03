function [w] = GaussianWeightFunc(k,d,r,c)

if d >= 0 & d <= r
    w = (exp(-(d/c).^2*k)-exp(-(r/c).^2*k))/(1-exp(-(r/c).^2*k));
else
    w = 0;
end
end