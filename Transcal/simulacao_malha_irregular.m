clc,clear all,close all  
% load malha_irregular
load malhateste1

X=P(1,:); Y=P(2,:);

X1=X(T(1,:));   X2=X(T(2,:));   X3=X(T(3,:));  
Y1=Y(T(1,:));   Y2=Y(T(2,:));   Y3=Y(T(3,:));  
   
Xo=(X1+X2+X3)/3; Xa=(X1+X2)/2;      Xb=(X2+X3)/2;     Xc=(X3+X1)/2;
Yo=(Y1+Y2+Y3)/3; Ya=(Y1+Y2)/2;      Yb=(Y2+Y3)/2;     Yc=(Y3+Y1)/2;

k=ones(1,length(T))*0.15; %condutividade térmica
[A] = Monta_A(k,P,T); Acompleto=A;%Cálculo Matriz dos coeficientes A

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

%inico - Ajuste das condiçõe de contorno
Aglobal=Aglobal1+Aglobal2+Aglobal3+Aglobal4; Aglobal(Aglobal==0)=1;

Temperatura_lado1=40;
Temperatura_lado2=40;
Temperatura_lado3=20;
Temperatura_lado4=40;

B=Aglobal1./Aglobal*Temperatura_lado1+Aglobal2./Aglobal*Temperatura_lado2...
    +Aglobal3./Aglobal*Temperatura_lado3+Aglobal4./Aglobal*Temperatura_lado4;

%fim - Ajuste das condiçõe de contorno

Temp=A\B; %Cálculo das temperaturas
figure(1),trisurf(T(1:3,:)',P(1,:),P(2,:),Temp),view(0,90),shading interp,
colorbar,title('Campo Temperatura'),axis equal,colormap jet

%Cálculo taxa de transferência de calor
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

malha_uniforme=[25 225 676 2601 10201 40401 63001 90601 123201 160801 203401 251001 303601 361201 491401 641601 1002001];
Q_uniforme=[6.3304 1.1147e+01 13.3642 16.0126 18.6604 19.4903 17.5241 18.2205 17.4354 17.9454 17.3784 17.7809 17.3415 17.6739 17.5993 17.5444 17.4692];

malha_irregular=[185 697 2705 10657 42305 168577 673025];
Q_irregular=[9.7913 12.7492 1.5537e+01 1.8227e+01 1.8895e+01 1.7144e+01 1.7260e+01];

figure(2)
plot(malha_uniforme,Q_uniforme,'-ok',malha_irregular,Q_irregular,'-ob','LineWidth',1.5,'MarkerSize',2)
legend('malha uniforme','malha irregular')
xlabel('número de nós da malha')
ylabel('Taxa de transferência de calor (W)')
axis([0 673025 0 25])
