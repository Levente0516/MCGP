function [X,k] = GetBasis(balBC,jobbBC,L,N)

X = cell(1,N);

n=1:N;


if balBC=="D" && jobbBC=="D"

    k=n*pi/L;

    for i=1:N
        X{i}=@(x) sin(k(i)*x);
    end


elseif balBC=="N" && jobbBC=="N"

    k=n*pi/L;

    for i=1:N
        X{i}=@(x) cos(k(i)*x);
    end


elseif balBC=="N" && jobbBC=="D"

    k=(2*n-1)*pi/(2*L);

    for i=1:N
        X{i}=@(x) cos(k(i)*x);
    end


elseif balBC=="D" && jobbBC=="N"

    k=(2*n-1)*pi/(2*L);

    for i=1:N
        X{i}=@(x) sin(k(i)*x);
    end

end

end