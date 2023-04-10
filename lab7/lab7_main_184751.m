% Zadanie 1
clc
clear all
close all
load P_ref.mat

it = 1;
fmin = gp(0);
fmax = gp(0);
for xb = 0:0.001:20
    vis(it) = gp(xb);
    it = it + 1;
    if gp(xb) < fmin
        fmin = gp(xb);
    end
    if gp(xb) > fmax
        fmax = gp(xb);
    end
end
plot(0:0.001:20,vis)

a = 0;
b = 5;

% wykresy bledow
it = 1;
for N = 5 : 50 : 10^4
    % metoda prostokatow
    [rect, time] = rect_method(a, b, N, @gp);
    errors(it) = abs(P_ref - rect);
    it = it + 1;
end

er = errors(it-1)
figure;
loglog(5:50:10^4, errors)
xlabel('Liczba podprzedziałów N')
ylabel('Błąd całkowania')
title('Wykres błedów całkowania dla metody prostokątów')
saveas(gcf, '184751_blad_prostokaty.png','png');

it = 1;
for N = 5 : 50 : 10^4
    % metoda trapezow
    [trapez, time] = trapez_method(a, b, N, @gp);
    errors_trapez(it) = abs(P_ref - trapez);
    it = it + 1;
end

et = errors_trapez(it-1)
figure;
loglog(5:50:10^4, errors_trapez)
xlabel('Liczba podprzedziałów N')
ylabel('Błąd całkowania')
title('Wykres błedów całkowania dla metody trapezów')
saveas(gcf, '184751_blad_trapezy.png','png');

it = 1;
for N = 5 : 50 : 10^4
    % metoda simpsona
    [simpson, time] = simpson_method(a, b, N, @gp);
    errors_simspon(it) = abs(P_ref - simpson);
    it = it + 1;
end

es = errors_simspon(it-1)
figure;
loglog(5:50:10^4, errors_simspon)
xlabel('Liczba podprzedziałów N')
ylabel('Błąd całkowania')
title('Wykres błedów całkowania dla metody Simpsona')
saveas(gcf, '184751_blad_simpson.png','png');

it = 1;
for N = 5 : 50 : 10^4
    % metoda Monte Carlo
    [montecarlo, time] = montecarlo_method(a, b, N, @gp, fmin, fmax);
    errors_montecarlo(it) = abs(P_ref - montecarlo);
    it = it + 1;
end

em = errors_montecarlo(it-1)
figure;
loglog(5:50:10^4, errors_montecarlo)
xlabel('Liczba podprzedziałów N')
ylabel('Błąd całkowania')
title('Wykres błedów całkowania dla metody Monte Carlo')
saveas(gcf, '184751_blad_montecarlo.png','png');

% Wykresy czasu
N = 10^7;
[v, time_rect] = rect_method(a, b, N, @gp);
[v, time_trapez] = trapez_method(a, b, N, @gp);
[v, time_simpson] = simpson_method(a, b, N, @gp);
[v, time_monte_carlo] = montecarlo_method(a, b, N, @gp, fmin, fmax);

figure;
X = categorical({'Prostokątów','Trapezów','Simpsona','Monte Carlo'});
X = reordercats(X,{'Prostokątów','Trapezów','Simpsona','Monte Carlo'});
bar(X,[time_rect, time_trapez, time_simpson, time_monte_carlo])
xlabel('Metody')
ylabel('Czas [s]')
title('Wykres czasu trwania danych metod')
saveas(gcf, '184751_czasy_a.png','png');

% Metoda prostokatow
function [val, time] = rect_method(a,b,k,f)
    tic;
    val = 0;
    x_dif = (b - a)/k;
    for i = 1:k
        x = a + (i-1) * x_dif;
        x_next = a + i * x_dif;
        [f_val] = f((x + x_next)/2);
        val = val + f_val * x_dif;
    end
    time = toc;
end

% Metoda trapezów
function [val, time] = trapez_method(a,b,k,f)
    tic;
    val = 0;
    x_dif = (b - a)/k;
    for i = 1:k
        x = a + (i-1) * x_dif;
        x_next = a + i * x_dif;
        [f_val] = f(x);
        [f_val_next] = f(x_next);
        val = val + ((f_val + f_val_next)/2) * x_dif;
    end
    time = toc;
end

% Metoda Simpsona
function [val, time] = simpson_method(a,b,k,f)
    tic
    val = 0;
    x_dif = (b - a)/k;
    for i = 1:k
        x = a + (i-1) * x_dif;
        x_next = a + i * x_dif;
        [f_val] = f(x);
        [f_val_next] = f(x_next);
        [f_val_mid] = f((x + x_next)/2);
        val = val + f_val + 4 * f_val_mid + f_val_next;
    end
    val = (val * x_dif)/6;
    time = toc;
end

% Metoda MonteCarlo
function [val, time] = montecarlo_method(a,b,k,f,fmin,fmax)
    tic;
    x = (b-a).*rand(k,1) + a;
    y = (fmax-fmin).*rand(k,1) + fmin;
    n1 = 0;  % punkty pod krzywą

    for i = 1:k
      f_x = f(x(i));
      if y(i) <= f_x
          n1 = n1 + 1;
      end
    end
    val = (n1/k) * (b-a) * (fmax -fmin);
    time = toc;
end

% Funkcja obliczajaca gestosc prawdopodobienstwa
function val = gp(t)
    s = 3;
    u = 10;
    val = exp(- ((t-u).^2)/(2*s.^2)) ./ (s * sqrt(2 * pi));
end