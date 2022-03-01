clc,clear,close all

%% início- Malha de elementos finitos.
load MalhaMedia

n_nos=length(P) %número de nós
n_ele=length(T) %número de elementos
% fim- Malha de elementos finitos.

%% início - propriedades do material
k=15*ones(size(T(1,:)));
e_dot = 2e6 % geração de calor interna W/(m^3)
qr = 5000 % fluxo de calor W/(m^2)
% fim - propriedades do material

%% início-pré-calculo
X=P(1,:);    Y=P(2,:);
% inicio - apresentação gráfica da malha

% fim - apresentação gráfica da malha

%% Montagem da matriz global (Aij) a partir das matrizes locais Cij
[A] = Monta_A(k,P,T);
[vol] = Monta_vol(k,P,T);
% fim - montagem da matriz global (Aij) a partir das matrizes locais Cij

% Nós dos contornos, conforme exemplo 4.3 do livro
no_cc1=union(E(1,E(5,:)==1),E(2,E(5,:)==1)); %nós do contorno 1
no_cc2=union(E(1,E(5,:)==2),E(2,E(5,:)==2)); %nós do contorno 2
no_cc3=union(E(1,E(5,:)==3),E(2,E(5,:)==3)); %nós do contorno 3
no_cc4=union(E(1,E(5,:)==4),E(2,E(5,:)==4)); %nós do contorno 4
no_cc5=union(E(1,E(5,:)==5),E(2,E(5,:)==5)); %nós do contorno 3
no_cc6=union(E(1,E(5,:)==6),E(2,E(5,:)==6)); %nós do contorno 4

%%Cálculos das áreas associadas ao contorno 4, submetido a convecção.
[Aglobal_1] = area_contorno2(P,E,no_cc1);
[Aglobal_2] = area_contorno2(P,E,no_cc2);
[Aglobal_3] = area_contorno2(P,E,no_cc3);
[Aglobal_4] = area_contorno2(P,E,no_cc4);
[Aglobal_5] = area_contorno2(P,E,no_cc5);
[Aglobal_6] = area_contorno2(P,E,no_cc6);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fim - montagem do vetor de áreas global


%% Vetor de termos independentes%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
B=zeros(length(P),1);  % termo independente

% Condição de contorno de convecção
T_inf=25;%(K)
h0=80;%W/(m^2*K)
for jj=no_cc4 
    A(jj,jj)=A(jj,jj)-h0*Aglobal_4(jj); %adição do termo convectivo em Aii
    B(jj)=-h0*Aglobal_4(jj)*T_inf;      %adição do termo convectivo em Bi
end
for jj=no_cc5 
    A(jj,jj)=A(jj,jj)-h0*Aglobal_5(jj); %adição do termo convectivo em Aii
    B(jj)=-h0*Aglobal_5(jj)*T_inf;      %adição do termo convectivo em Bi
end
for jj=no_cc6
    A(jj,jj)=A(jj,jj)-h0*Aglobal_6(jj); %adição do termo convectivo em Aii
    B(jj)=-h0*Aglobal_6(jj)*T_inf;      %adição do termo convectivo em Bi
end

for jj=no_cc3
    A(jj,jj)=A(jj,jj)+h0*Aglobal_3(jj); %adição do fluxo em Aii
    B(jj)=B(jj)-qr*Aglobal_3(jj);      %adição do fluxo em Bi
end
%geração de calor
ev=-vol.*e_dot;
B=B+ev;
    
%condição de contorno de temeperatura especificada
for jj=no_cc2 %O vetor no_cc3 deve ter os elemento em linha!
    A(jj,:)=0;    %zera a equação jj
    A(jj,jj)=1;   %faz o Ajj=1
    B(jj)=90;
end
% fim- modificação da matriz global para incluir as condições de contorno

% início - solução sistema de equações
Temp=A\B;
% fim - solução sistema de equações

%% Coordenadas de pontos representativos do elemento finito
X=P(1,:); Y=P(2,:);
X1=X(T(1,:));   X2=X(T(2,:));   X3=X(T(3,:));  
Y1=Y(T(1,:));   Y2=Y(T(2,:));   Y3=Y(T(3,:));  
Xo=(X1+X2+X3)/3; Xa=(X1+X2)/2;      Xb=(X2+X3)/2;     Xc=(X3+X1)/2;
Yo=(Y1+Y2+Y3)/3; Ya=(Y1+Y2)/2;      Yb=(Y2+Y3)/2;     Yc=(Y3+Y1)/2;

%% Apresentação gráfica do resultado
figure(4), trisurf(T(1:3,:)',X,Y,Temp),view(0,90),shading interp,
    colorbar,colormap jet,title('Campo Temperaturas')
    
% Cálculo da taxa de transferência de calor convectiva
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
title('Malha Média 201 nós e 344 elementos')
