clc,clear all,close all  
[P,E,T]= poimesh('squareg',10,10);%criação da malha de elementos triangulares
P=(P+1)*0.5; %alguns ajustes na malha
%%Coordenadas de pontos representativos do elemento finito
X=P(1,:); Y=P(2,:);
X1=X(T(1,:));   X2=X(T(2,:));   X3=X(T(3,:));  
Y1=Y(T(1,:));   Y2=Y(T(2,:));   Y3=Y(T(3,:));  
Xo=(X1+X2+X3)/3; Xa=(X1+X2)/2;      Xb=(X2+X3)/2;     Xc=(X3+X1)/2;
Yo=(Y1+Y2+Y3)/3; Ya=(Y1+Y2)/2;      Yb=(Y2+Y3)/2;     Yc=(Y3+Y1)/2;

k=ones(1,length(T))*0.15; %condutividade térmica
[A] = Monta_A(k,P,T); %Cálculo Matriz dos coeficientes A

%vetor que guarda os nós de cada lado
no_lado1=find(Y<0.01);
no_lado2=find(X<0.01);
no_lado3=find(Y>0.99);
no_lado4=find(X>0.99);

%Ajuste condições de contorno
for i=1:length(E(1,:))
    A(E(1,i),:)=0;     A(E(1,i),E(1,i))=1;
end


%Cálculo das áreas associadas a cada lado
[Aglobal1]=area_contorno(P,E,T,no_lado1);
[Aglobal2]=area_contorno(P,E,T,no_lado2);
[Aglobal3]=area_contorno(P,E,T,no_lado3);
[Aglobal4]=area_contorno(P,E,T,no_lado4);

Aglobal=Aglobal1+Aglobal2+Aglobal3+Aglobal4; Aglobal(Aglobal==0)=1;

Temperatura_lado1=40;
Temperatura_lado2=40;
Temperatura_lado3=20;
Temperatura_lado4=40;

B=Aglobal1./Aglobal*Temperatura_lado1+Aglobal2./Aglobal*Temperatura_lado2...
    +Aglobal3./Aglobal*Temperatura_lado3+Aglobal4./Aglobal*Temperatura_lado4;

%fim - Ajuste das condiçõe de contorno
Temp=A\B;   %Cálculo das temperaturas

%Gráfico: distribuição de temperatura
figure(1),trisurf(T(1:3,:)',P(1,:),P(2,:),Temp),view(0,90),shading interp,
colorbar,title('Campo Temperatura'),axis equal,colormap jet

%Cálculo taxa de transferência de calor
[k_dT_dxi,k_dT_dyi] = gradiente(k,Temp,P,T);
Q1=-sum(Aglobal1(no_lado1).*k_dT_dyi(no_lado1))
Q2=-sum(Aglobal2(no_lado2).*k_dT_dxi(no_lado2))
Q3=-sum(Aglobal3(no_lado3).*k_dT_dyi(no_lado3))
Q4=+sum(Aglobal4(no_lado4).*k_dT_dxi(no_lado4))
Qt=Q1+Q2+Q4

% % domínio
% % 2 3 3 3 3
% % 2       4
% % 2       4
% % 2       4
% % 1 1 1 1 4

%Gráfico: Fluxo de calor
figure(2)
pdemesh(P,E,T),hold on
quiver(X,Y,-k_dT_dxi',-k_dT_dyi',2,'color','k')
