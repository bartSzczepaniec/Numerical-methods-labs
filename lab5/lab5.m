% Zadanie 1
K = [5, 15, 25, 35];
size(K,2);
for i = 1:size(K,2)
    [x, y, f, xp, yp] = lazik(K(i));

    fig = figure('Position', get(0, 'Screensize'));
    sgtitle(strcat('Wykresy dla liczby punktów pomiarowych K = ',string(K(i))))

    subplot(2,2,1);
    plot(xp,yp,'-o','linewidth',3);
    xlabel('x[m]')
    ylabel('y[m]')
    title('Tor ruchu łazika')
    grid on

    subplot(2,2,2);
    plot3(x,y,f,'o');
    xlabel('x[m]')
    ylabel('y[m]')
    zlabel('f(x,y)')
    title('Zebrane wartości próbek')
    grid on
    
    [XX,YY] = meshgrid(linspace(0,100,101),linspace(0,100,101));
    [p] = polyfit2d(x,y,f);
    [FF] = polyval2d(XX,YY,p);

    subplot(2,2,3);
    surf(XX, YY, FF);
    xlabel('x[m]')
    ylabel('y[m]')
    zlabel('f(x,y)')
    title('Interpolacja wielomianowa')
    grid on
    shading flat

    [p] = trygfit2d(x,y,f);
    [FF] = trygval2d(XX,YY,p);

    subplot(2,2,4);
    surf(XX, YY, FF);
    xlabel('x[m]')
    ylabel('y[m]')
    zlabel('f(x,y)')
    title('Interpolacja trygonometryczna')
    grid on
    shading flat
    
    fig_name = '184751_zad1_k_' + string(K(i)) + '.png';
    saveas(fig, fig_name,'png');
end
% Zadanie 2
it = 1;
for i = 5:45
    [x, y, f] = lazik(i);
    [XX,YY] = meshgrid(linspace(0,100,101),linspace(0,100,101));
    %wielomianowe
    [p] = polyfit2d(x,y,f);
    [FF] = polyval2d(XX,YY,p);

    if i > 5
        divP(it) =  max(max(abs(FF - FF_poly_prev)));
    end
    FF_poly_prev = FF;
    % tryg
    [p] = trygfit2d(x,y,f);
    [FF] = trygval2d(XX,YY,p);

    if i > 5
        divT(it) =  max(max(abs(FF - FF_tryg_prev)));
        it = it + 1;
    end
    FF_tryg_prev = FF;

end

figure;
ks = 6:45;
plot(ks, divP);
xlabel('Liczba punktów pomiarowych K')
ylabel('Maksymalne wartości różnicy interpolowanych funkcji')
title('Wykres zbieżności dla interpolacji wielomianowej')
saveas(gcf, '184751_zad2_int_wielomianowa.png','png');

figure;
plot(ks, divT);
xlabel('Liczba punktów pomiarowych K')
ylabel('Maksymalne wartości różnicy interpolowanych funkcji')
title('Wykres zbieżności dla interpolacji trygonometrycznej')
saveas(gcf, '184751_zad2_int_trygonometryczna.png','png');