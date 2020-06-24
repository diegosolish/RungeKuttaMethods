function RungeKuttaMetodos()
clc, clear all, close all;
    syms x y;
    h = 0.1;
    
    decisionUno = 0;
    while(decisionUno ~= [1 2 3])
        decisionUno = input("Teclee la función que desee \n1)f(x,y) = 4x^2-2y \n2)f(x,y) = x^2-3y \n3)f(x,y) = -2x^3+12x^2-20x \nOpción: ");
        fprintf("\n")
    end
    
    switch decisionUno
        case 1
            funcion = 4*x^2-2*y;
            xi = 0.4:0.1:4;
            yi = 3;
            arrYi = [yi];
            h = 0.1;
        case 2
            funcion = x^2-3*y;
            xi = 1:0.1:4;
            yi = 0;
            arrYi = [yi];
            h = 0.1;
        case 3
            funcion = -2*x^3+12*x^2-20*x + 8.5;
            xi = 0:0.1:4;
            yi = 1;
            arrYi = [yi];
            h = 0.1;
    end
    
    ordenUno(xi, arrYi, h, funcion);
    segundoOrdenHeun(xi, arrYi, h, funcion);
    segundoOrdenPuntoMedio(xi, arrYi, h, funcion)
    segundoOrdenRalston(xi, arrYi, h, funcion)
    cuartoOrden(xi, arrYi, h, funcion)
%     funcionOriginal(xi, arrYi, funcion); % Para el caso de las funciones que utilizan dos variables
                                         % es necesario graficarlas en un plano de tres dimensiones
    
end

function ordenUno(xi, arrYi,h, funcion) 
    syms x y;
    for i = 1:1:length(xi)-1
        arrYi(end+1) = arrYi(end) + double(subs(funcion, {x y}, {xi(i) arrYi(end)}))*h;
    end
    
    subplot(3,2,1)
    plot(xi,arrYi,'linewidth',2,'color','r')
    grid on;
    title('1er Orden')
end

function segundoOrdenHeun(xi, arrYi, h, funcion)
    syms x y;
    k1 = []; k2 = [];
    
    for i = 1:1:length(xi)-1
        k1(end+1) = double(subs(funcion, {x y}, {xi(i) arrYi(end)}));
        k2(end+1) = double(subs(funcion, {x y}, {(xi(i)+h), (arrYi(end)+k1(end)*h)}));
        arrYi(end+1) = arrYi(end) + (0.5*k1(end) + 0.5*k2(end))*h;
    end

    subplot(3,2,2)
    plot(xi,arrYi,'linewidth',2,'color','b');
    grid on;
    title('2do Orden - Heun')
end

function segundoOrdenPuntoMedio(xi, arrYi, h, funcion)
    syms x y;
    k1 = []; k2 = [];
    
    for i = 1:1:length(xi)-1
        k1(end+1) = double(subs(funcion, {x y}, {xi(i) arrYi(end)}));
        k2(end+1) = double(subs(funcion, {x y}, {(xi(i)+0.5*h), (arrYi(end)+0.5*k1(end)*h)}));
        arrYi(end+1) = arrYi(end) + k2(end)*h;
    end
    
    subplot(3,2,3)
    plot(xi,arrYi,'linewidth',2,'color','g')
    grid on;
    title('2do Orden - Punto Medio')
end

function segundoOrdenRalston(xi, arrYi, h, funcion)
    syms x y;
    k1 = []; k2 = [];
    
    for i = 1:1:length(xi)-1
        k1(end+1) = double(subs(funcion, {x y}, {xi(i) arrYi(end)}));
        k2(end+1) = double(subs(funcion, {x y}, {(xi(i)+0.75*h), (arrYi(end)+0.75*k1(end)*h)}));
        arrYi(end+1) = arrYi(end) + ((1/3)*k1(end)+(2/3)*k2(end))*h;
    end
    
    subplot(3,2,4)
    plot(xi,arrYi,'linewidth',2,'color','k')
    grid on;
    title('2do Orden - Ralston')
end


function cuartoOrden(xi, arrYi, h, funcion)
    syms x y;
    k1 = []; k2 =[]; k3 = []; k4 = [];

    for i = 1:1:length(xi)-1
        k1(end+1) = double(subs(funcion, {x y}, {xi(i) arrYi(end)}));
        k2(end+1) = double(subs(funcion, {x y}, {(xi(i)+0.5*h), (arrYi(end)+0.5*k1(end)*h)}));
        k3(end+1) = double(subs(funcion, {x y}, {(xi(i)+0.5*h), (arrYi(end)+0.5*k2(end)*h)}));
        k4(end+1) = double(subs(funcion, {x y}, {(xi(i)+h), (arrYi(end)+k3(end)*h)}));
        arrYi(end+1) = arrYi(end) + (1/6)*(k1(end)+2*k2(end)+2*k3(end)+k4(end))*h;
    end
    
    subplot(3,2,5)
    plot(xi,arrYi,'linewidth',2,'color','m')
    grid on;
    title('4to Orden');
end

function funcionOriginal(xi, arrYi, funcion) % Para el caso de las funciones que utilizan dos variables
                                             % es necesario graficarlas en un plano de tres dimensiones
    syms x y;
    funcion = int(funcion);
    for i = 1:1:length(xi)-1
        arrYi(end+1) = double(subs(funcion, {x y}, {xi(i) arrYi(end)}));
    end
    
    subplot(3,2,6)
    plot(xi,arrYi,'linewidth',2,'color','y');
    grid on;
    title('Funcion original')
    hold on
end
