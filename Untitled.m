%%
syms Va Vb
equa1 = Va/2==5+(Va-Vb)/8
equa2 = (Va-Vb)/8==3+Vb/4

matx = vpasolve([equa1,equa2],[Va,Vb]);

v1 = matx.Va
v2 = matx.Vb