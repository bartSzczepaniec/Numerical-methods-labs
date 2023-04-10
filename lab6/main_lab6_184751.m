% Zadanie 2
clc
clear all
close all

warning('off','all')

load trajektoria1

plot3(x,y,z,'o')
title("Położenie drona")
xlabel("Współrzędne x")
ylabel("Współrzędne y")
zlabel("Współrzędne z")
grid on
axis equal
saveas(gcf, '184751_Szczepaniec_zad2.png','png');

% Zadanie 4
clc
clear all
close all

warning('off','all')

load trajektoria1

N = 50;  % aproksymacja
[ wsp_wielomianu, xa ] = aproksymacjaWiel(n,x,N);  % x
[ wsp_wielomianu, ya ] = aproksymacjaWiel(n,y,N);  % y
[ wsp_wielomianu, za ] = aproksymacjaWiel(n,z,N);  % z

plot3(x,y,z,'o')
hold on
plot3(xa,ya,za,'lineWidth',4)

title("Trajektoria drona bazująca na lokalizacji i aproksymowana")
xlabel("Współrzędne x")
ylabel("Współrzędne y")
zlabel("Współrzędne z")

grid on
axis equal

saveas(gcf, '184751_Szczepaniec_zad4.png','png');

% Zadanie 5
clc
clear all
close all

warning('off','all')

load trajektoria2

N = 60;  % aproksymacja

[ wsp_wielomianu, xa ] = aproksymacjaWiel(n,x,N);  % x
[ wsp_wielomianu, ya ] = aproksymacjaWiel(n,y,N);  % y
[ wsp_wielomianu, za ] = aproksymacjaWiel(n,z,N);  % z

plot3(x,y,z,'o')
hold on
plot3(xa,ya,za,'lineWidth',4)

title("Trajektoria drona bazująca na lokalizacji i aproksymowana")
xlabel("Współrzędne x")
ylabel("Współrzędne y")
zlabel("Współrzędne z")

grid on
axis equal

saveas(gcf, '184751_Szczepaniec_zad5.png','png');
hold off
f = figure;

N = [1:71];
size(N,2);
M = size(n,2);
for i = 1:size(N,2)
    [ wsp_wielomianu, xa ] = aproksymacjaWiel(n,x,N(i));  % x
    [ wsp_wielomianu, ya ] = aproksymacjaWiel(n,y,N(i));  % y
    [ wsp_wielomianu, za ] = aproksymacjaWiel(n,z,N(i));  % z
    errx = sqrt(sum((x-xa).^2)) / M;
    erry = sqrt(sum((y-ya).^2)) / M;
    errz = sqrt(sum((z-za).^2)) / M;
    err(i) = errx + erry + errz;
end
semilogy(N,err)
title("Wykres błędu aproksymacji w zależności od N")
xlabel("N")
ylabel("Bład err")
saveas(gcf, '184751_Szczepaniec_zad5_b.png','png');
%  Dla N od 18 do 44 - bład bardzo mały w porównaniu do innych

% Zadanie 6 - aprox_tryg.m

% Zadanie 7
clc
clear all
close all

warning('off','all')

load trajektoria2

N = 60;  % aproksymacja

[ xa ] = aprox_tryg(n,x,N);  % x
[ ya ] = aprox_tryg(n,y,N);  % y
[ za ] = aprox_tryg(n,z,N);  % z

plot3(x,y,z,'o')
hold on
plot3(xa,ya,za,'lineWidth',4)

title("Trajektoria drona bazująca na lokalizacji i aproksymowana")
xlabel("Współrzędne x")
ylabel("Współrzędne y")
zlabel("Współrzędne z")

grid on
axis equal

saveas(gcf, '184751_Szczepaniec_zad7.png','png');
hold off
f = figure;

N = [1:71];
size(N,2);
M = size(n,2);
for i = 1:size(N,2)
    [ xa ] = aprox_tryg(n,x,N(i));  % x
    [ ya ] = aprox_tryg(n,y,N(i));  % y
    [ za ] = aprox_tryg(n,z,N(i));  % z
    errx = sqrt(sum((x-xa).^2)) / M;
    erry = sqrt(sum((y-ya).^2)) / M;
    errz = sqrt(sum((z-za).^2)) / M;
    err(i) = errx + erry + errz;
end
semilogy(N,err)
title("Wykres błędu aproksymacji w zależności od N")
xlabel("N")
ylabel("Bład err")
saveas(gcf, '184751_Szczepaniec_zad7_b.png','png');

% Automatyczne określanie wartości rzędu aproksymacji N bazując na wykresie
% błędu
Best_N = 1;
smallest_err = err(1);
for i = 1:size(N,2)
    if(err(i) < smallest_err)
        smallest_err = err(i);
        Best_N = i;
    end
end
Best_N
