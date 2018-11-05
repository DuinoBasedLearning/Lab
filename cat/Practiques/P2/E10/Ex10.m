clc;
close all;
clear all;
% Modelo del sistema (abrimos archivo creado en la práctica 1: ejercicio 4)
    K0=0.82;
    tau0=0.26;
    planta=tf([K0],[tau0 1]);
    
% Periodo de muestreo
Ts=0.01;

% Montaje del sistema teórico
sistema_discreto=c2d(planta,Ts,'zoh');
sistema_bilineal=d2c(sistema_discreto,'tustin');

% Imagen del Bode los márgenes de fase / ganancia
figure(1);
bode(sistema_bilineal);
hold on;
grid on;
[Gm,Pm,Wcg,Wcp]=margin(sistema_bilineal);
margin(sistema_bilineal);
title('Diagrama de Bode');

Vmax=5;
% Definimos un tiempo
Tx=0.0:Ts:50*Ts;
% Definimos unas consignas (escalón de altura Vmax)
X =[Vmax*ones(size(Tx))];
% Definimos un conjunto de Kp's con las cuales queremos 
% simular el sistema, expresadas como porcentaje de Gm (ó Kp_max)
Kp=[10 25 50 75 80]';
Kp=[Kp (1/100)*Kp*Gm];
% simulamos el comportamiento del sistema para diferentes Kp's
[fils cols]=size(Kp);
i=1;
% el vector Y almacena las respuestas del sistema ante la consigna 
% con diferentes constantes de proporcionalidad
Y=[];
while (i<=fils)
    % la función model_discret(...) contiene una modelización del sistema en lazo
    % cerrado y controlador proporcional
    Y=[Y; Kt*model_discret(0,K0,Kp(i,2),Kt,tau0,Ts,X)];
    i=i+1;
end

figure(2);
T_MAX=max(Tx);
T_MIN=min(Tx);
Y_MAX=max(max(Y));
Y_MIN=min(min(Y));

% Dibujamos la consigna
plot(Tx,X);
hold on;
grid on;
% Dibujamos las simulaciones del sistema
i=1;
styles=['r.-';'m.-';'k.-';'g.-';'y.-';'c.-'];
[sty_fil sty_col]=size(styles);
legenda={'consigna'};
while (i<=fils)
    plot(Tx,Y(i,:),styles(mod(i,sty_fil),:));
    legenda={char(legenda);strcat(strcat('Kp=',num2str(Kp(i,1))),'% de Gm')};
    i=i+1;
end
title('Respuesta teórica con diferentes valores de Kp');
legenda=char(legenda);
legend(legenda);

% Nyquist del sistema discreto
figure(3);
hold on;
nyquist(sistema_discreto,'b-');
freq_resp=freqresp(sistema_discreto,Wcp);
point=[real(freq_resp) imag(freq_resp)];

% Dibujamos el punto correspondiente al margen de fase y margen de ganancia
text(point(1,1)+0.02,point(1,2)-0.02,'Margen de fase');
plot(point(1,1),point(1,2),'r.');
freq_resp=freqresp(sistema_discreto,pi/Ts);
point=[real(freq_resp) imag(freq_resp)];
text(point(1,1)+0.02,point(1,2)-0.02,'Margen de ganancia');
plot(point(1,1),point(1,2),'r.');
axis([-1.5 1.5 -1.5 1.5]);
title('Diagrama de Nyquist');
xlabel('Eje Real');
ylabel('Eje Imaginario');
x=[0 point(1,1)]';
y=[0 point(1,2)]';
circumf;