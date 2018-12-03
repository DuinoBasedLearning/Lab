% Plant parameters
K_mot=0.82; %[rpm/V]
T_mot=0.24; %seg

% Sampling period
Ts=0.01;

% Model's analogic and discrete transfer functions
F=tf([K_mot],[T_mot 1])
Fd=c2d(F,Ts)

% Nyquist Diagram 
figure
nyquist(F)
hold on 
nyquist(Fd,'red')

% Visualize the Nyquist for different sampling periods
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
    i=1;        
    while (i<=cols)
        nyquist(c2d(F,Ts(1,i),'zoh'));
        i=i+1;
    end
    legend(legenda);
    title('Nyquist Diagram');
    xlabel('Real');
    ylabel('Imag');