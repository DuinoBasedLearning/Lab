clc;
close all;
clear all;
% System model (we open file created in practice 1: exercise 4)
    K0=0.82;
    tau0=0.26;
    Kt=0.017;
    planta=tf([K0],[tau0 1]);
    
% Sampling period
Ts=0.01;

% Theoretical system
sistema_discreto=c2d(planta,Ts,'zoh');
sistema_bilineal=d2c(sistema_discreto,'tustin');

% Image of the Bode phase / gain margins
figure(1);
bode(sistema_bilineal);
hold on;
grid on;
[Gm,Pm,Wcg,Wcp]=margin(sistema_bilineal);
margin(sistema_bilineal);
title('Diagrama de Bode');

Vmax=5;
% Define a time interval
Tx=0.0:Ts:50*Ts;
% Define reference (step of Vmax of height)
X =[Vmax*ones(size(Tx))];
% Define a set of Kp's with which we want to simulate the system,
% expressed as a percentage of Gm (or Kp_max)
Kp=[10 25 50 75 80]';
Kp=[Kp (1/100)*Kp*Gm];
% Simulate the behavior of the system for different Kp's
[fils cols]=size(Kp);
i=1;
% The vector Y stores the responses of the system to the step 
% with different constants of proportionality

Y=[];
while (i<=fils)
    % the model_discret (...) function contains a closed-loop
    % system modeling and proportional controller
    Y=[Y; Kt*model_discret(0,K0/Kt,Kp(i,2),Kt,tau0,Ts,X)];
    i=i+1;
end

figure(2);
T_MAX=max(Tx);
T_MIN=min(Tx);
Y_MAX=max(max(Y));
Y_MIN=min(min(Y));

% Draw the reference
plot(Tx,X);
hold on;
grid on;
% Draw system simulations
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

% Discrete system's Nyquist
figure(3);
hold on;
nyquist(sistema_discreto,'b-');
freq_resp=freqresp(sistema_discreto,Wcp);
point=[real(freq_resp) imag(freq_resp)];

% Draw the point corresponding to the margin of phase and profit margin
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