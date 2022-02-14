clc,clear all,close all
malha1 %executa o script "malha1"
k=ones(1,length(T))*0.15; %condutividade térmica
[A] = Monta_A(k,P,T); Acompleto=A; %Cálculo Matriz dos coeficientes A
%%ajuste das temperaturas nos contornos
B=zeros(length(P),1);
no=1; A(no,:)=0; A(no,no)=1; B(no)=40;
no=2; A(no,:)=0; A(no,no)=1; B(no)=40;
no=3; A(no,:)=0; A(no,no)=1; B(no)=40;
no=4; A(no,:)=0; A(no,no)=1; B(no)=40;
no=5; A(no,:)=0; A(no,no)=1; B(no)=40;
no=6; A(no,:)=0; A(no,no)=1; B(no)=40;
no=10; A(no,:)=0; A(no,no)=1; B(no)=40;
no=11; A(no,:)=0; A(no,no)=1; B(no)=40;
no=15; A(no,:)=0; A(no,no)=1; B(no)=40;
no=16; A(no,:)=0; A(no,no)=1; B(no)=40;
no=20; A(no,:)=0; A(no,no)=1; B(no)=40;
no=21; A(no,:)=0; A(no,no)=1; B(no)=30;
no=22; A(no,:)=0; A(no,no)=1; B(no)=20;
no=23; A(no,:)=0; A(no,no)=1; B(no)=20;
no=24; A(no,:)=0; A(no,no)=1; B(no)=20;
no=25; A(no,:)=0; A(no,no)=1; B(no)=30;
Temp=A\B; %Cálculo das temperaturas

%%Coordenadas de pontos representativos do elemento finito
X=P(1,:); Y=P(2,:);
X1=X(T(1,:));   X2=X(T(2,:));   X3=X(T(3,:));  
Y1=Y(T(1,:));   Y2=Y(T(2,:));   Y3=Y(T(3,:));  
Xo=(X1+X2+X3)/3; Xa=(X1+X2)/2;      Xb=(X2+X3)/2;     Xc=(X3+X1)/2;
Yo=(Y1+Y2+Y3)/3; Ya=(Y1+Y2)/2;      Yb=(Y2+Y3)/2;     Yc=(Y3+Y1)/2;
%%Gráficos
figure(1),
trisurf(T(1:3,:)',X,Y,Temp),view(0,90),shading interp,colorbar,
title('Campo de Temperatura'),axis equal,colormap jet
figure(2); 
pdemesh(P,E,T),hold on
for i=1:length(E),text(X(E(1,i)),Y(E(1,i)),{Temp(E(1,i))},'Fontsize',16),end
title('Temperaturas nos nós dos contornos')
figure(3); 
pdemesh(P,E,T),hold on
for i=1:length(X),text(X(i),Y(i),{Temp(i)},'Fontsize',16),end
title('Temperatura em cada nó')
%seleção dos nós de cada lado
no_lado1=find(Y<0.01);
no_lado2=find(X<0.01);
no_lado3=find(Y>0.99);
no_lado4=find(X>0.99);
%cálculo das áreas dos lados
[Aglobal1]=area_contorno(P,E,T,no_lado1);
[Aglobal2]=area_contorno(P,E,T,no_lado2);
[Aglobal3]=area_contorno(P,E,T,no_lado3);
[Aglobal4]=area_contorno(P,E,T,no_lado4);
%Cálculo taxa de transferência de calor:
[k_dT_dxi,k_dT_dyi] = gradiente(k,Temp,P,T);
Q1=-sum(Aglobal1(no_lado1).*k_dT_dyi(no_lado1))
Q2=-sum(Aglobal2(no_lado2).*k_dT_dxi(no_lado2))
Q3=-sum(Aglobal3(no_lado3).*k_dT_dyi(no_lado3))
Q4=+sum(Aglobal4(no_lado4).*k_dT_dxi(no_lado4))
Qt=Q1+Q2+Q4
%Cálculo taxa de transferência de calor, modo aproximado:
Qi=(Acompleto*Temp);
Qtotal=sum(Qi(no_lado3))

% % domínio
% % 2 3 3 3 3
% % 2       4
% % 2       4
% % 2       4
% % 1 1 1 1 4

% inicio - apresentação gráfica da malha
figure(4); pdemesh(P,E,T),axis equal,hold on
for i=1:length(P)
    text(X(i),Y(i),{Aglobal1(i)}),
end
hold on,plot([Xa;Xo],[Ya;Yo],'-r',[Xb;Xo],[Yb;Yo],'-r',[Xc;Xo],[Yc;Yo],'-r'),hold on
title('Valor de area em cada nó - lado 1')

figure(5); pdemesh(P,E,T),axis equal,hold on
for i=1:length(P)
    text(X(i),Y(i),{Aglobal2(i)}),
end
hold on,plot([Xa;Xo],[Ya;Yo],'-r',[Xb;Xo],[Yb;Yo],'-r',[Xc;Xo],[Yc;Yo],'-r'),hold on
title('Valor de area em cada nó - lado 2')

figure(6); pdemesh(P,E,T),axis equal,hold on
for i=1:length(P)
    text(X(i),Y(i),{Aglobal3(i)}),
end
hold on,plot([Xa;Xo],[Ya;Yo],'-r',[Xb;Xo],[Yb;Yo],'-r',[Xc;Xo],[Yc;Yo],'-r'),hold on
title('Valor de area em cada nó - lado 3')

figure(7); pdemesh(P,E,T),axis equal,hold on
for i=1:length(P)
    text(X(i),Y(i),{Aglobal4(i)}),
end
hold on,plot([Xa;Xo],[Ya;Yo],'-r',[Xb;Xo],[Yb;Yo],'-r',[Xc;Xo],[Yc;Yo],'-r'),hold on
title('Valor de area em cada nó - lado 4')

figure(8); pdemesh(P,E,T),axis equal,hold on
for i=1:length(P)
    text(X(i),Y(i),{i}),
end
hold on,plot([Xa;Xo],[Ya;Yo],'-r',[Xb;Xo],[Yb;Yo],'-r',[Xc;Xo],[Yc;Yo],'-r'),hold on
title('rótulo dos nós')

  