%% Discrete PID controller for position

% Matlab program to automatically calculate the parameters of the
% controller by pole placement

% Definition of the plant's parameters 
K0=0.82/0.017;
tau0=0.26;
N=9;
Kpot=1.62;

% Sampling period
Ts=0.01;

% Desired control specifications
Sp=80; % overshoot
Fd=0.5; % frequency

% Poles of the second order continuous system that will 
% fulfill the specifications
wd=2*pi*Fd ;
xi=sqrt((log(Sp/100))^2/(pi^2+log(Sp/100)^2))
wn=wd/ sqrt(1-xi^2)
s1=-xi*wn+j*wd
s2=-xi*wn-j*wd

% Poles of the second order discrete system that will fulfill the specifications
p1=exp(Ts* s1 )
p2=exp(Ts* s2 )

% Fix third pole
p3=0.01

% Plant's Z transfere function
Ptas=tf([K0*(1/N)*Kpot],[tau0,1,0]);
Ptaz=c2d(Ptas,Ts,'zoh');

% Denominator and numerator coefficients
[Nz ,Dz]= tfdata(Ptaz,'v')
a1=Nz(2);
a0=Nz(3);
b1=Dz(2);
b0=Dz(3);

% A and B matrix definitions (as it is explained in the practices
% statements)
A=[-1 -a1 -a1 -a1 ; p2+p3+p1 a1-a0 -a1-a0 -a0+2*a1 ; ...
   -p1*p2-p3*p1-p2*p3 a0 -a0 2*a0-a1 ; p1*p2*p3 0 0 -a0 ] ;
b=[p1+p2+p3-1+b1 ; -p1*p2-p3*p1-p3*p2+b0-b1 ; p1*p2*p3-b0 ; 0 ] ;

% x vector's determination of the controller 
x=inv(A)*b ; 

p4=x(1)
Kp=x(2)
Ki=(2/Ts)*x(3)
Kd=Ts*x(4)
% Anti-wind-up
pawd=0.2;
Kaw=1/Ki;

% Poles dominance calculation
dominancia=log(abs(p4))/log(abs(p1))
