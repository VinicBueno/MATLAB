clc,clear all,close all %#ok<CLALL>
[P,E,T]=poimesh('squareg',10,5); %Geração da Malha
P(1,:)=0.04*(P(1,:)+1)/2; X=P(1,:);  %Reposicionamento do domínio - X
P(2,:)=0.01*(P(2,:)+1)/2; Y=P(2,:);  %Reposicionamento do domínio - Y
%Propriedades Térmicas
k=110;%W/(mK)
ro=8530;%kg/m^3
cp=380; %J/kg-K
%Numeração dos nós de contorno
n_cnv=union(E(1:2,E(5,:)==2),E(1:2,E(5,:)==4))';%Nós convecção
Nbc=[];                                         %Nós temp. especificada
%Condição inicial de Temperatura,tmp=0
tmp=0;                   % tmp inicial
Temp=20*ones(length(P),2); % temperatura inicial no domínio.
dt=2;                      % passo de tmp em segundos
%Termo de fonte
Tinf=500;% Temperatura do meio ambiente em ºC
h0=120;  % Coeficiente convectivo de troca de calor em W/(m^2*K)
[Aglobal]=area_contorno2(P,E,n_cnv);
SP=h0*Aglobal;      %Parte do termo de fonte dependente da temperatura
SC=h0*Aglobal*Tinf;%Parte do termo de fonte independente da temperatura
%%%Evolução tmpral do campo de temperatura.
for j=2:200000
Temp(:,2)=Temp(:,1); tmp=tmp+dt; %Atualização da temperatura e do tmp
[Temp]=CAL_TEMP(k/cp,ro,dt,SP/cp,SC/cp,Temp,Nbc,P,T); Twall=mean(Temp(n_cnv,1));
figure(1),trisurf(T(1:3,:)',X,Y,Temp(:,1)),view(0,90),shading interp;colorbar,colormap jet
str=sprintf('Tempo=%1.1fs, Temp. parede=%1.2fºC',tmp,Twall);title(str);axis equal;drawnow;
fprintf('passos:%1.0f, tmp(s):%1.2f, Temp. parede(ºC):%1.2f\n',j,tmp,mean(Temp(n_cnv,1)))
if tmp==420,break,end
end
%Gráfico 2
Xbo=(X(E(1,:))+X(E(2,:)))/2; Ybo=(Y(E(1,:))+Y(E(2,:)))/2;
figure(2);pdemesh(P,E,T),axis equal,title('Numeração segmentos de contorno')
for i=1:length(Xbo)
text(Xbo(i),Ybo(i),{E(5,i)})
end
%Gráfico 3
figure(3);pdemesh(P,E,T),axis equal,title('Área de contorno')
for i=1:length(Xbo)
text(X(E(1,i)),Y(E(1,i)),{Aglobal(E(1,i))})
end