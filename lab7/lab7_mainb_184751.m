clc
clear all


%------------------------------------------
load dane_jezioro   % dane XX, YY, FF sa potrzebne jedynie do wizualizacji problemu. 
surf(XX,YY,FF)
shading interp
axis equal
%------------------------------------------


%------------------------------------------
% Implementacja Monte Carlo dla f(x,y) w celu obliczenia objetosci wody w zbiorniku wodnym. 
% Calka = ?
% Nalezy skorzystac z nastepujacej funkcji:
% z = glebokosc(x,y); % wyznaczanie glebokosci jeziora w punkcie (x,y),
% gdzie x i y sa losowane
%------------------------------------------

N = 1e5;
xmin = 0;
xmax = 100;
ymin = 0;
ymax = 100;
fmin = -50; % z
fmax = 0;

tic;
x = (xmax - xmin).*rand(N,1) + xmin;
y = (ymax-ymin).*rand(N,1) + ymin;
z = (fmax-fmin).*rand(N,1) + fmin;
n2 = 0;  % punkty nad krzywą
for i = 1:N
  f_x = glebokosc(x(i),y(i));
  if z(i) >= f_x
      n2 = n2 + 1;
  end
end
val = (n2/N) * (xmax - xmin) * (ymax - ymin) * (fmax -fmin)
writematrix(val, "wynik_b_184751.txt");
time = toc;
