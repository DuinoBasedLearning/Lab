%% I-PD controller
% Parametros de la planta 
K0=0.82/0.017;
tau0=0.26;
N=9;
Kpot=1.62;

% Periodo de muestreo
Ts=0.01;

% Especificaciones de control deseadas
Sp=80; % sobreimpulso
Fd=0.5; % frecuencia

% Polos de segundo orden continuo que cumpliran las especificaciones
wd=2*pi*Fd ;
xi=sqrt((log(Sp/100))^2/(pi^2+log(Sp/100)^2))
wn=wd/ sqrt(1-xi^2)
s1=-xi*wn+j*wd
s2=-xi*wn-j*wd

% Polos discretos de segundo orden que cumpliran las especificaciones
p1=exp(Ts*s1)
p2=exp(Ts*s2)

% Insertar el tercer y cuarto polo (no dominantes)
p3=0.8
p4=0.8

% Función de transferencia discreta de la planta 
Ptas=tf([K0*(1/N)*Kpot],[tau0,1,0]);
Ptaz=c2d(Ptas,Ts,'zoh');

% Coeficientes del denominador y enumerador 
[Nz ,Dz]= tfdata(Ptaz,'v')
a1=Nz(2);
a0=Nz(3);
b1=Dz(2);
b0=Dz(3);

% Definiciones de las matrices A y B
A=[1 a1 0 0; ...
   b1-1 a0 a1 0; 
   b0-b1 0 a0 a1; 
  -b0 0 0 a0];
b=[-b1+1-p1-p2-p3-p4; 
   -b0+b1+p1*p2-(-p1-p2)*p3-(-p1-p2-p3)*p4; 
   b0-p1*p2*p3-(p1*p2-(-p1-p2)*p3)*p4; 
   p1*p2*p3*p4];

% Controlador 
x=inv(A)*b; 

alpha=x(1)
c2=x(2)
c1=x(3)
c0=x(4)

A2=[1 1 1; alpha-1 alpha+1 -2; -alpha alpha 1];
B2=[c2;c1;c0];

x2=inv(A2)*B2;

kp = x2(1)
ki = (2/Ts)*x2(2)
kd = Ts*x2(3)


