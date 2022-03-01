clc,clear all,close all %#ok<CLALL>
MalhaGrossa

%% Propriedades Térmicas
k=15;%W/(mK)
ro=9014.423076; %kg/m^3
cp=520; %J/kg-K
rhocp = 4687500 % m^3*K/W*s
edot = 2e6 % geração de calor interna W/(m^3)
qr = 5000 % fluxo de calor W/(m^2)

%% início-pré-calculo
X=P(1,:);    Y=P(2,:);

%% Numeração dos nós de contorno
n_cnv=[1 2 3 6 7 8 9];%Nós convecção
Nbc=[10 11 12 13 14 15];%Nós temp. especificada
Nfl=[9]; %Nó de fluxo especificado

%Condição inicial de Temperatura,tmp=0
tmp=0;                   % tmp inicial
Temp=90*ones(length(P),2); % temperatura inicial no domínio.
dt=100;                      % passo de tmp em segundos

%Termo de fonte
Tinf=25;% Temperatura do meio ambiente em ºC
h0=80;  % Coeficiente convectivo de troca de calor em W/(m^2*K)
[Aglobal]=area_contorno2(P,E,n_cnv);
SP=h0*Aglobal;      %Parte do termo de fonte dependente da temperatura
SC=h0*Aglobal*Tinf;%Parte do termo de fonte independente da temperatura

%% Evolução temporal do campo de temperatura.
for j=2:200000
Temp(:,2)=Temp(:,1); tmp=tmp+dt; %Atualização da temperatura e do tmp
[Temp]=CAL_TEMP(k/cp,ro,dt,SP/cp,SC/cp,Temp,Nbc,Nfl,qr,h0,edot,k,tmp,P,E,T); T3=(Temp(3,1));
figure(1),trisurf(T(1:3,:)',X,Y,Temp(:,1)),view(0,90),shading interp;colorbar,colormap jet
str=sprintf('Tempo = %1.1fs, Temp. nó 3 = %1.2fºC',tmp,T3);title(str);axis equal;drawnow;
fprintf('passos:%1.0f, tmp(s):%1.2f, Temp. nó 3(ºC):%1.2f\n',j,tmp,(Temp(3,1)))
if tmp==3600,break,end
end

figure(2); 
pdemesh(P,E,T),hold on
for i=1:length(X),text(X(i),Y(i),{Temp(i)}),end
title('Temperatura em cada nó')