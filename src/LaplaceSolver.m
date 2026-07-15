function u = LaplaceSolver(L,H,N,BC)

x = linspace(0,L,100);
y = linspace(0,H,100);

[X,Y] = meshgrid(x,y);

u = zeros(size(X));

balBC   = BC.bal.type;
jobbBC  = BC.jobb.type;
alsoBC  = BC.also.type;
felsoBC = BC.felso.type;


f0 = BC.also.value;
f1 = BC.felso.value;
g0 = BC.bal.value;
g1 = BC.jobb.value;


[Xfunc,kx] = GetBasis(balBC,jobbBC,L,N);

for n = 1:N

    kn = kx(n);

    Xn = @(x) Xfunc{n}(x);

    if BC.also.homogen == false

        An = (2/L)*integral(@(t) ...
            f0(t).*Xn(t),0,L);

        if alsoBC=="D" && felsoBC=="D"

            Yn = @(y) sinh(kn*y)/sinh(kn*H);

        elseif alsoBC=="D" && felsoBC=="N"

            Yn = @(y) sinh(kn*y)/(kn*cosh(kn*H));

        elseif alsoBC=="N" && felsoBC=="D"

            Yn = @(y) cosh(kn*y)/sinh(kn*H);

        elseif alsoBC=="N" && felsoBC=="N"

            Yn = @(y) cosh(kn*y)/cosh(kn*H);

        end

        u = u + An.*Xn(X).*Yn(Y);

    end

    if BC.felso.homogen == false

        An = (2/L)*integral(@(t) ...
            f1(t).*Xn(t),0,L);

        if alsoBC=="D" && felsoBC=="D"

            Yn = @(y) sinh(kn*(H-y))/sinh(kn*H);

        elseif alsoBC=="D" && felsoBC=="N"

            Yn = @(y) cosh(kn*(H-y))/(kn*sinh(kn*H));

        elseif alsoBC=="N" && felsoBC=="D"

            Yn = @(y) cosh(kn*(H-y))/cosh(kn*H);

        elseif alsoBC=="N" && felsoBC=="N"

            Yn = @(y) cosh(kn*(H-y))/cosh(kn*H);

        end

        u = u + An.*Xn(X).*Yn(Y);

    end


end

[Yfunc,ky] = GetBasis(alsoBC,felsoBC,H,N);

for n=1:N

    kn = ky(n);


    Yn = @(y) Yfunc{n}(y);

    if BC.bal.homogen == false


        An = (2/H)*integral(@(t) ...
            g0(t).*Yn(t),0,H);

        if balBC=="D" && jobbBC=="D"

            Xn = @(x) sinh(kn*x)/sinh(kn*L);


        elseif balBC=="D" && jobbBC=="N"

            Xn = @(x) sinh(kn*x)/(kn*cosh(kn*L));


        elseif balBC=="N" && jobbBC=="D"

            Xn = @(x) cosh(kn*x)/sinh(kn*L);


        elseif balBC=="N" && jobbBC=="N"

            Xn = @(x) cosh(kn*x)/cosh(kn*L);

        end


        u = u + An.*Xn(X).*Yn(Y);


    end

    if BC.jobb.homogen == false


        An = (2/H)*integral(@(t) ...
            g1(t).*Yn(t),0,H);



        if balBC=="D" && jobbBC=="D"

            Xn = @(x) sinh(kn*(L-x))/sinh(kn*L);


        elseif balBC=="D" && jobbBC=="N"

            Xn = @(x) cosh(kn*(L-x))/(kn*sinh(kn*L));


        elseif balBC=="N" && jobbBC=="D"

            Xn = @(x) cosh(kn*(L-x))/cosh(kn*L);


        elseif balBC=="N" && jobbBC=="N"

            Xn = @(x) cosh(kn*(L-x))/cosh(kn*L);

        end


        u = u + An.*Xn(X).*Yn(Y);

    end

end

end