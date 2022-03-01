clc,clear,close all

%% in�cio- Malha de elementos finitos.
load MalhaMedia

n_nos=length(P) %n�mero de n�s
n_ele=length(T) %n�mero de elementos
% fim- Malha de elementos finitos.

%% in�cio - propriedades do material
k=15*ones(size(T(1,:)));
e_dot = 2e6 % gera��o de calor interna W/(m^3)
qr = 5000 % fluxo de calor W/(m^2)
% fim - propriedades do material

%% in�cio-pr�-calculo
X=P(1,:);    Y=P(2,:);
% inicio - apresenta��o gr�fica da malha

% fim - apresenta��o gr�fica da malha

%% Montagem da matriz global (Aij) a partir das matrizes locais Cij
[A] = Monta_A(k,P,T);
[vol] = Monta_vol(k,P,T);
% fim - montagem da matriz global (Aij) a partir das matrizes locais Cij

% N�s dos contornos, conforme exemplo 4.3 do livro
no_cc1=union(E(1,E(5,:)==1),E(2,E(5,:)==1)); %n�s do contorno 1
no_cc2=union(E(1,E(5,:)==2),E(2,E(5,:)==2)); %n�s do contorno 2
no_cc3=union(E(1,E(5,:)==3),E(2,E(5,:)==3)); %n�s do contorno 3
no_cc4=union(E(1,E(5,:)==4),E(2,E(5,:)==4)); %n�s do contorno 4
no_cc5=union(E(1,E(5,:)==5),E(2,E(5,:)==5)); %n�s do contorno 3
no_cc6=union(E(1,E(5,:)==6),E(2,E(5,:)==6)); %n�s do contorno 4

%%C�lculos das �reas associadas ao contorno 4, submetido a convec��o.
[Aglobal_1] = area_contorno2(P,E,no_cc1);
[Aglobal_2] = area_contorno2(P,E,no_cc2);
[Aglobal_3] = area_contorno2(P,E,no_cc3);
[Aglobal_4] = area_contorno2(P,E,no_cc4);
[Aglobal_5] = area_contorno2(P,E,no_cc5);
[Aglobal_6] = area_contorno2(P,E,no_cc6);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fim - montagem do vetor de �reas global


%% Vetor de termos independentes%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
B=zeros(length(P),1);  % termo independente

% Condi��o de contorno de convec��o
T_inf=25;%(K)
h0=80;%W/(m^2*K)
for jj=no_cc4 
    A(jj,jj)=A(jj,jj)-h0*Aglobal_4(jj); %adi��o do termo convectivo em Aii
    B(jj)=-h0*Aglobal_4(jj)*T_inf;      %adi��o do termo convectivo em Bi
end
for jj=no_cc5 
    A(jj,jj)=A(jj,jj)-h0*Aglobal_5(jj); %adi��o do termo convectivo em Aii
    B(jj)=-h0*Aglobal_5(jj)*T_inf;      %adi��o do termo convectivo em Bi
end
for jj=no_cc6
    A(jj,jj)=A(jj,jj)-h0*Aglobal_6(jj); %adi��o do termo convectivo em Aii
    B(jj)=-h0*Aglobal_6(jj)*T_inf;      %adi��o do termo convectivo em Bi
end

for jj=no_cc3
    A(jj,jj)=A(jj,jj)+h0*Aglobal_3(jj); %adi��o do fluxo em Aii
    B(jj)=B(jj)-qr*Aglobal_3(jj);      %adi��o do fluxo em Bi
end
%gera��o de calor
ev=-vol.*e_dot;
B=B+ev;
    
%condi��o de contorno de temeperatura especificada
for jj=no_cc2 %O vetor no_cc3 deve ter os elemento em linha!
    A(jj,:)=0;    %zera a equa��o jj
    A(jj,jj)=1;   %faz o Ajj=1
    B(jj)=90;
end
% fim- modifica��o da matriz global para incluir as condi��es de contorno

% in�cio - solu��o sistema de equa��es
Temp=A\B;
% fim - solu��o sistema de equa��es

%% Coordenadas de pontos representativos do elemento finito
X=P(1,:); Y=P(2,:);
X1=X(T(1,:));   X2=X(T(2,:));   X3=X(T(3,:));  
Y1=Y(T(1,:));   Y2=Y(T(2,:));   Y3=Y(T(3,:));  
Xo=(X1+X2+X3)/3; Xa=(X1+X2)/2;      Xb=(X2+X3)/2;     Xc=(X3+X1)/2;
Yo=(Y1+Y2+Y3)/3; Ya=(Y1+Y2)/2;      Yb=(Y2+Y3)/2;     Yc=(Y3+Y1)/2;

%% Apresenta��o gr�fica do resultado
figure(4), trisurf(T(1:3,:)',X,Y,Temp),view(0,90),shading interp,
    colorbar,colormap jet,title('Campo Temperaturas')
    
% C�lculo da taxa de transfer�ncia de calor convectiva
Q=h0.*Aglobal_1(no_cc1).*(Temp(no_cc1)-T_inf);
QT=sum(Q);

figure(7); pdemesh(P,E,T),axis equal,hold on
hold on,plot([Xa;Xo],[Ya;Yo],'-r',[Xb;Xo],[Yb;Yo],'-r',[Xc;Xo],[Yc;Yo],'-r'),hold on
title('Volumes Finitos')

[k_dT_dxi,k_dT_dyi] = gradiente(k,Temp,P,T);
figure(8)
quiver(X,Y,-k_dT_dxi',-k_dT_dyi',2,'color','k'),axis equal
title('Vetores de Fluxo de calor')

%% 
pdemesh(P,E,T),hold on
title('Malha M�dia 201 n�s e 344 elementos')
