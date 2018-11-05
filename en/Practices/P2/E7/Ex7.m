% Parámetros de la planta
K_mot=0.82; %[rpm/V]
T_mot=0.24; %seg

% Periodo de muestreo
Ts=0.01;

% Función de transferencia analógico y digital del modelo
F=tf([K_mot],[T_mot 1])
Fd=c2d(F,Ts)

% Diagramas de Nyquist
figure
nyquist(F)
hold on 
nyquist(Fd,'red')

% Visualizamos el Nyquist para diferentes períodos de muestreo
    i=1;
    Ts=[0.001 0.005 0.01 0.05 0.1 0.25];
    [fils cols]=size(Ts);
    legenda={'modelo continuo'};
    while (i<=cols)
        legenda={char(legenda);strcat(strcat('modelo discreto (Ts=',num2str(Ts(1,i))),'s)')};
        i=i+1;
    end
    legenda=char(legenda);
    figure(2);
    nyquist(F);
    hold on;
    %legend('model continu');
    i=1;        
    while (i<=cols)
        nyquist(c2d(F,Ts(1,i),'zoh'));
        % legend(strcat(strcat('model discret(Ts=',num2str(Ts(1,i))),'s)'));
        i=i+1;
    end
    legend(legenda);
    title('Diagrama de Nyquist');
    xlabel('Eje Real');
    ylabel('Eje Imaginario');