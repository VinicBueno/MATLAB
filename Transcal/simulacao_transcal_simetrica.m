clc,clear all,close all
malha1s %executa o script "malha1"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k=ones(1,length(T))*0.15; %condutividade térmica
[A] = Monta_A(k,P,T);  Acompleto=A;   %Cálculo Matriz dos coeficientes A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
B=zeros(length(P),1);     %termo independente de Temp.
no=1; A(no,:)=0; A(no,no)=1; B(no)=40;
no=2; A(no,:)=0; A(no,no)=1; B(no)=40;
no=3; A(no,:)=0; A(no,no)=1; B(no)=40;
no=6; A(no,:)=0; A(no,no)=1; B(no)=40;
no=9; A(no,:)=0; A(no,no)=1; B(no)=40;
no=12; A(no,:)=0; A(no,no)=1; B(no)=40;
no=13; A(no,:)=0; A(no,no)=1; B(no)=20;
no=14; A(no,:)=0; A(no,no)=1; B(no)=20;
no=15; A(no,:)=0; A(no,no)=1; B(no)=30;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Temp=A\B;  %Cálculo das temperaturas
%%Coordenadas de pontos representativos do elemento finito
X=P(1,:); Y=P(2,:);
X1=X(T(1,:));    X2=X(T(2,:));  X3=X(T(3,:));  
Y1=Y(T(1,:));    Y2=Y(T(2,:));  Y3=Y(T(3,:));  
Xo=(X1+X2+X3)/3; Xa=(X1+X2)/2;  Xb=(X2+X3)/2;  Xc=(X3+X1)/2;
Yo=(Y1+Y2+Y3)/3; Ya=(Y1+Y2)/2;  Yb=(Y2+Y3)/2;  Yc=(Y3+Y1)/2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1)%Gráfico do campo de temperatura
trisurf(T(1:3,:)',X,Y,Temp),view(0,90),shading interp,colorbar,
title('Campo Temperatura'),axis equal,colormap jet
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2);%Malha de elementos e temperaturas nos nós de contorno
pdemesh(P,E,T),hold on
for i=1:length(E),text(X(E(1,i)),Y(E(1,i)),{Temp(E(1,i))},'Fontsize',16),end
title('Temperaturas nos contornos')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3);%Malha de elementos e temperaturas em todos os nós da malha
pdemesh(P,E,T),hold on
for i=1:length(X),text(X(i),Y(i),{Temp(i)},'Fontsize',16),end
title('Temperatura em cada nó da malha')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(4); %Malha de elementos, com numeração dos nós e elementos
pdemesh(P,E,T,'ElementLabels','on','NodeLabels','on'),hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Cálculo taxa de transferência de calor:
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
Qt=(Q1+Q2+Q4)*2
%Cálculo taxa de transferência de calor, modo aproximado:
Qi=(Acompleto*Temp);
Qtotal=sum(Qi(no_lado3))*2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Gr�fico: Fluxo de calor
figure(10)
pdemesh(P,E,T),hold on
quiver(X,Y,-k_dT_dxi',-k_dT_dyi',2,'color','k')