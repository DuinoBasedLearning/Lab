%% Vmotor
VinMotor=[-2.92 -2.18 -1.43 -0.7 0.057 0.78 1.548 2.3 3.03 3.8 4.52];
AppliedStep=[0 0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1]*(2^12-1);
plot(AppliedStep,VinMotor,'*k')
title('Calibración D/A')
ylabel('Valores a aplicar en Simulink')
xlabel('Tensión [V]')

P1=polyfit(VinMotor,AppliedStep,1)
P1_2=polyfit(AppliedStep,VinMotor,1)
hold on
valores=polyval(P1,VinMotor)
plot(AppliedStep,valores)

% funcion
e2=-5
u1=0.1342*e2+0.3926

%% Caracterizacion Vtaco - Bits entrada 
Bits=[650 995 1392 1732 1997 2382 2765 3188 3395];
Vtaco=[-3 -2 -0.94 0.0019 0.71 1.8 2.85 4.03 4.6];
plot(Bits,Vtaco);
P2=polyfit(Bits,Vtaco,1)

%funcion
e2=3412
u2=0.0028*e2-4.7809

%% Caracterizacion Taco Velocidad RPM - Bits entrada

RPM=[220 184 137 87 36 0 -40 -90 -137]
BitsVel=[3403 3197 2809 2420 2015 1730 1410 1015 655]
plot(BitsVel,RPM);
P2=polyfit(BitsVel,RPM,1)

u=3403
f=0.128*u-221.2915


%% Caracterización potenciómetro angulo - bits entrada
bitsPot=[0 275 600 920 1257 1593 1924 2283 2608 2952 3328 3550];
theta=[30 60 90 120 150 180 210 240 270 300 330 360]; 

Q=polyfit(bitsPot,theta,1);
% Deducción de la curva característica del potenciómetro circular
%                     theta = Q(1)*bitsPot + Q(2)                                          

% Comprobación gráfica de la linealidad del potenciómetro circular.
figure
plot(bitsPot,theta,'r*')


%% Caracterización potenciómetro Tension - bits entrada
Vpot=[-4.7 -3.7 -2.65 -1.25 0.263 1.7 2.82 5.1];
Bits=[27 380 764 1267 1812 2332 2734 3554];
polyfit(Bits,Vpot,1)
plot(Bits,Vpot)
Kpot=1.62;
