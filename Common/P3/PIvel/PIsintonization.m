%% Discrete PI controller for position

% Matlab program to automatically calculate the parameters of the
% controller by pole placement

K0=0.92;
tau0=0.24;

% De f i n i c i ´o d e l s pe r i ode de mos t ratge
Ts=0.01;

% Espezifikazioak
ts_2=0.8; % egonkortze denbora %2-eko irizpidearekin
Tdes=ts_2/4;

% Kontrolagailuaren diseinua
Zdes=exp(-Ts/Tdes);
alpha=exp(-Ts/tau0);
Kp=((1-Zdes)/(2*K0))*((1+alpha)/(1-alpha));
Ki=(2/Ts)*Kp*((1-alpha)/(1+alpha));



