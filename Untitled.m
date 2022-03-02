clc,clear,close all
%%
syms Va Vb
equa1 = Va/2==5+(Va-Vb)/8
equa2 = (Va-Vb)/8==3+Vb/4

matx = vpasolve([equa1,equa2],[Va,Vb]);

v1 = matx.Va
v2 = matx.Vb

%%
x = 0:pi/2:4*pi;
a = cos(x);
xq = 0:pi/12:4*pi;
aq = interp1(x,a,xq);
plot(x,a,'o',xq,aq,':.');
title('Default Interpolation');

%%
a = [0  1.21  1  1.21  0  -1.21  -1  -1.21 0];
xq = 2.5:9.5;
aq = interp1(a,xq);
plot((1:9),a,'o',xq,aq,'*');
legend('a','aq');