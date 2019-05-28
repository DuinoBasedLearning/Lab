%% Exercici 13:Disseny d’un controlador d’avanç de fase
close all
clear all
%
% Introducció dels paràmetres de la planta (veure ex.4)
% (Cal Aplicar els paràmeters de la vostra planta)
%
Kpot=1.62;
N=9;
K0=0.82/0.017;
tau0=0.26;
planta=tf([Kpot*K0/N],[tau0,1,0])
%
% Models de Temps discret
%
Ts=0.01;
plantad=c2d(planta,Ts,'zoh') ;
% Transformada Bilineal
plantaw=d2c(plantad,'tustin') ;
%
% Comprovació de la coincidència en el càlcul dels marges
%
[Gmw,Pmw,Wcgw,Wcpw]=margin(plantaw)
[Gmd,Pmd,Wcgd,Wcpd]=margin (plantad)
margin(plantaw)
hold on
margin(plantad)

%% Exercici 14
%Ex e r c i c i s 13 , 14 : Disseny d ’ un c ont r ol ador d ’ avan¸c de f a s e
close all
clear all
%
% Int r odu c c i ´o d e l s par`ametres de l a pl ant a
% o b t i n g u t s en l ’ e x e r c i c i 4
%
Kpot=1.62;
N=9;
K0=0.82/0.017;
tau0=0.26;
planta=tf([Kpot*K0/N],[tau0,1,0])
%
% Models de Temps d i s c r e t
%
Ts=0.01;
plantad=c2d(planta,Ts,'zoh') ;
% Transformada Bi l i n e a l
plantaw=d2c(plantad,'tustin') ;
%
% C`al cul d e l guany n e c e s s a r i
% Co e f i c i e n t d ’ e r r or de v e l o c i t a t
%
errordes=0.1;
Kv=(1/errordes);
%
% C`al cul de l ’ increment de guany n e c e s s a r i
% (Guany d e l c ont r ol ador )
%
Kvplanta=Kpot*K0/N;
Kcontrolador=Kv/Kvplanta
%
% C`al cul d e l Marge de Fase
%
[Gm,Pm,Wcg,Wcp]=margin(Kcontrolador*plantaw)
%
%C`al cul de l a Fase que ha d ’ a f e g i r e l c ont r ol ador
%
gamma=45;
delta=15;
theta=(gamma+delta-Pm)* pi /180;
%
% C`al cul d e l par`ametre alpha
%
alpha=(1+sin(theta))/(1-sin(theta));
%
% B´usqueda d e l punt on e l s i s t ema t´e guany 1/ s q r t ( alpha )
%
[aux1,aux2,aux3,wc]=margin(Kcontrolador*plantaw*sqrt(alpha));
wc
%
% Col . loquem e l pol i z e ro
%
wz=wc/sqrt(alpha); %AVANC¸
wp=wz*alpha ;
%
%Cons t rucci´o d e l c ont r ol ador
%
Gcw=tf([1/wz,1],[1/wp,1]);
%
% Bi l i n e a l Inv e r sa : Obtenci´o d e l Cont rolador
%
Gcz=c2d(Gcw,Ts,'tustin')
%
% Resposta Fr e quenc ial en Lla¸c ob e r t
% ( Ve r i f i c a c i ´o d e l compl iment de l e s e s p e c i f i c a c i o n s )
figure
Gczplantad=series(Kcontrolador*Gcz,plantad);
Gczplantaw=d2c(Gczplantad,'tustin');
margin(Kcontrolador*plantaw)
hold on


margin(Gczplantaw)
grid

disp('mireu si us agrada el nou marge de fase ; premeu qualsevol tecla')
pause
%
% Cons t rucci´o d e l Sistema en Lla¸c t anc at
%
closed=feedback(Gczplantad,1);
err=1-closed;
%
% Ve r i f i c a c i ´o de l a r e s pot a temporal
%
figure(2)
grao=tf([1 0],[1,-1],Ts);
step(minreal(err*grao)*Ts ) ;
grid
title('Error en la Resposta Rampa')
%
% Preparem l e s dades p e l Simul ink
%
disp('coeficients de la funció de transferencia del controlador de guany unitari en z')
Kc=dcgain(Gcz)
Zc=zero(Gcz)
Pc=pole(Gcz)

%% Exercici 15

%Ex e r c i c i 15: An `a l i s i en s imu l ac i ´o
%
%Generem e l s r e t a r d s
%
unret=tf([1],[1 0],Ts);
dosret=tf([1],[1 0 0],Ts);
tresret=tf([1],[1 0 0 0],Ts);
%
% Vi s u a l i t z a c i ´o d e l Di f e r e n t s Diagrames de Bode
%
figure(3)
margin(unret*Gcz*plantad*Kcontrolador)
figure(4)
margin(dosret*Gcz*plantad*Kcontrolador)
figure(5)
margin(tresret*Gcz*plantad*Kcontrolador)


