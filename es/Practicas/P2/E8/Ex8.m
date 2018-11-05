% Vector de ganancias experimentales
G=[0.8 0.7 0.6 0.54 0.34 0.2 0.16 0.085 0.06];
% Vector de desfases experimentales (en radianes)
F=[18.45 32.4 46.08 52 68.4 86.4 108 126 144]*(-pi/180);
% Cálculo del complejo en forma cartesiana
X=real (G.*exp(F*j));
Y=imag(G.*exp(F*j));

% Introducción de los parámetros de la planta
K0=0.82;
tau0=0.26;
planta=tf([K0],[tau0,1])

% Modelos de tiempo discreto
Ts=0.01;
plantad=c2d(planta,Ts,'zoh');

% Dibujamos el diagrama de Nyquist teórico y experimental
figure(1)
nyquist(plantad,'g')
hold on
plot(X,Y, 'r*' )
legend('Diagrama de Nyquist teórico (Ts=0.01)','Diagrama de Nyquist experimental (Ts=0.01)')
