% dibuix d'una circumferència de radi=1 centrada a l'origen
x=-1:0.005:1;
y1=sqrt(1-x.^2);
y2=-sqrt(1-x.^2);
plot(x,y1,'k--');
hold on;
plot(x,y2,'k--');
clear x;
clear y1;
clear y2;

