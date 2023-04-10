a = 5;
r_max = 1;
n_max = 250;
areas = zeros(1,n_max);
counts = zeros(1,n_max);
x = zeros(1,n_max);
y = zeros(1,n_max);
r = zeros(1,n_max);

counter = 1;
ox = rand(1) * a;
oy = rand(1) * a;
or = rand(1) * r_max;
while ox - or < 0 || oy - or < 0 || ox + or > a || oy + or > a
    ox = rand(1) * a;
    oy = rand(1) * a;
    or = rand(1) * r_max;
    counter = counter + 1;
end
axis equal
plot_circ(ox,oy,or)
pause(0.01)
title('Pęcherzyki')
xlabel('x')
ylabel('y')
hold on
n=1;
x(n) = ox;
y(n) = oy;
r(n) = or;
area = or*or* pi;
areas(n) = area;
counts(n) = counter;
fprintf(1, ' %s%5d%s%.3g\r ', 'n =', n, ' S = ', area)
while n < n_max
  inter = true;
  counter = 0;
  while inter
      ox = rand(1) * a;
      oy = rand(1) * a;
      or = rand(1) * r_max;
      counter = counter + 1;
      while ox - or < 0 || oy - or < 0 || ox + or > a || oy + or > a
        ox = rand(1) * a;
        oy = rand(1) * a;
        or = rand(1) * r_max;
        counter = counter + 1;
      end
      inter=false;
      for i=1:n
          xdif = x(i) - ox;
          ydif = y(i) - oy;
          xdif2 = xdif.^2;
          ydif2 = ydif.^2;
          if (sqrt(ydif2 + xdif2) < r(i) + or && sqrt(ydif2 + xdif2) > abs(r(i) - or))
              inter=true;
              break;
          end
          if(sqrt(ydif2 + xdif2) < r(i) || sqrt(ydif2 + xdif2) < or)
              inter=true;
              break;
          end
      end
  end
  n=n+1;
  x(n) = ox;
  y(n) = oy;
  r(n) = or;
  plot_circ(ox,oy,or)
  pause(0.01)
  area = area + or*or* pi;
  areas(n) = area;
  counts(n) = counter;
  fprintf(1, ' %s%5d%s%.3g\r ', 'n =', n, ' S = ', area)
end
hold off

f2 = figure;
semilogx(1:n_max,areas)
xlabel('n')
title('Powierzchnia całkowita')

f3 = figure;
aver = cumsum(counts);
ns = 1:n_max;
aver = aver ./ ns;
loglog(aver)
xlabel('n')
title('Srednia liczba losowan')

function plot_circ(X, Y, R)
       theta = linspace(0,2*pi);
       x = R*cos(theta) + X;
       y = R*sin(theta) + Y;
       plot(x,y)
end
