% File corresponding to the modeling of the system
function [Y]=model_discret(y0,K0,Kp,Kt,tau0,Ts,X)
    i=2;
    [fils cols]=size(X);
    Y=[y0];
    while (i<=cols)
        Y=[Y X(1,i-1)*Kp*K0*(1-exp(-Ts/tau0))-(Kt*Kp*K0*(1-exp(-Ts/tau0))-exp(-Ts/tau0))*Y(1,i-1)];
        i=i+1;
    end
