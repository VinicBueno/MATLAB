clc,clear,close all

%% in�cio- Malha de elementos finitos.
m=40 % n�mero de elementos na dire��o x
n=40% n�mero de elementos na dire��o y
[P,E,T]=poimesh('squareg',m,n);%cria��o da malha de elementos triangulares
P=(P+1)*0.5; %alguns ajustes na malha!!
n_nos=length(P) %n�mero de n�s
n_ele=length(T) %n�mero de elementos
% fim- Malha de elementos finitos.

%% in�cio - propriedades do material
k=ones(size(T(1,:)));
% fim - propriedades do material

%% in�cio-pr�-calculo
X=P(1,:);    Y=P(2,:);
% inicio - apresenta��o gr�fica da malha
figure(1); pdemesh(P,E,T),axis equal
for i=1:length(E)
    text(X(E(1,i)),Y(E(1,i)),{E(5,i)},'FontSize',13,'HorizontalAlignment','left','color','blue'),
    text(X(E(2,i)),Y(E(2,i)),{E(5,i)},'FontSize',13,'HorizontalAlignment','right','color','red'),
end

title('r�tulo dos n�s nos contornos')
% fim - apresenta��o gr�fica da malha

%% Montagem da matriz global (Aij) a partir das matrizes locais Cij
[A] = Monta_A(k,P,T);
% fim - montagem da matriz global (Aij) a partir das matrizes locais Cij

% N�s dos contornos, conforme exemplo 4.3 do livro
no_cc1=union(E(1,E(5,:)==1),E(2,E(5,:)==1)); %n�s do contorno 1
no_cc2=union(E(1,E(5,:)==2),E(2,E(5,:)==2)); %n�s do contorno 2
no_cc3=union(E(1,E(5,:)==3),E(2,E(5,:)==3)); %n�s do contorno 3
no_cc4=union(E(1,E(5,:)==4),E(2,E(5,:)==4)); %n�s do contorno 4

%%C�lculos das �reas associadas ao contorno 4, submetido a convec��o.
[Aglobal] = area_contorno2(P,E,no_cc4);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fim - montagem do vetor de �reas global

%% apresenta��o dos valores de �reas associadas aso contornos
figure(3); pdemesh(P,E,T),axis equal,
for i=1:length(Aglobal)
    text(X(i),Y(i),{Aglobal(i)})
end
title('�reas associadas aos segmentos dos contornos - numera��o Global')

% Vetor de termos independentes%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
B=zeros(length(P),1);  % termo independente

% Condi��o de contorno de convec��o
% Sabemos que Q=h0*Aglobal*(Ti-T_inf);
% Qconv=h0*Aglobal*Ti-h0*Aglobal*T_inf;
% Parte explicita(Pe)=> -h0*Aglobal*T_inf, pois todos os termos s�o conhecidos!
% Parte implicita(Pi)=>  h0*Aglobal*Ti, pois Ti n�o � conhecido!
% Considerando a equa��o: A*Temp=B, "Pe" vai para o B e "Pi" vai para o A.

% => A*Temp=B
% => A*Temp=Qconv
% =>                 A*Temp=(h0*Aglobal*Ti)-(h0*Aglobal*T_inf)
% =>            A*Temp -(h0*Aglobal*Ti)=-(h0*Aglobal*T_inf), Se A*Temp=(Aii*Ti+sumAnbTnb) e Bn=-(h0*Aglobal*T_inf)
% => (Aii*Ti+sumAnbTnb)-(h0*Aglobal*Ti)=Bn,
% => (Aii-h0*Aglobal)*Ti+sumAnbTnb=Bn,

% Ent�o, para incluir a condi��o de convec��o, deve-se proceder como:
% Aii=Aii-h0*Aglobal
% B=-h0*Aglobal*T_inf

% Condi��o de contorno de convec��o
T_inf=300;%(K)
h0=10;%W/(m^2*K)
for jj=no_cc4 %O vetor no_cc4 deve ter os elemento em linha!
    A(jj,jj)=A(jj,jj)-h0*Aglobal(jj); %adi��o do termo convectivo em Aii
    B(jj)=-h0*Aglobal(jj)*T_inf;      %adi��o do termo convectivo em Bi
end
%condi��o de contorno de temeperatura especificada
for jj=no_cc1 %O vetor no_cc1 deve ter os elemento em linha!
    A(jj,:)=0;    %zera a equa��o jj
    A(jj,jj)=1;   %faz o Ajj=1
    B(jj)=500;
end
%condi��o de contorno de temeperatura especificada
for jj=no_cc2 %O vetor no_cc2 deve ter os elemento em linha!
    A(jj,:)=0;    %zera a equa��o jj
    A(jj,jj)=1;   %faz o Ajj=1
    B(jj)=500;
end
%condi��o de contorno de temeperatura especificada
for jj=no_cc3 %O vetor no_cc3 deve ter os elemento em linha!
    A(jj,:)=0;    %zera a equa��o jj
    A(jj,jj)=1;   %faz o Ajj=1
    B(jj)=500;
end
% fim- modifica��o da matriz global para incluir as condi��es de contorno

% in�cio - solu��o sistema de equa��es
Temp=A\B;
% fim - solu��o sistema de equa��es

%% Apresenta��o gr�fica do resultado
figure(4), trisurf(T(1:3,:)',X,Y,Temp),view(0,90),shading interp,
colorbar,colormap jet,title('Campo Temperaturas')
figure(5); pdemesh(P,E,T),axis equal,
for i=1:length(E)
    text(X(E(1,i)),Y(E(1,i)),{Temp(E(1,i))}),title('Temperaturas nos contornos')
end

figure(6), plot([0 0.25 0.50 0.75 1],[500 356.99 339.05 356.99 500],'o'...
    ,Y(find(X<0.00000000001)),Temp(find(X<0.00000000001)),'-')
axis([0 1 300 500]), title('Compara��o entre solu��es')
xlabel('Posi��o(m)'),ylabel('Temperatura(K)')
legend('Resultados do Exemplo 4.3','Simula��o CVFEM')

% C�lculo da taxa de transfer�ncia de calor convectiva
Q=h0.*Aglobal(no_cc4).*(Temp(no_cc4)-T_inf);
QT=sum(Q);
disp(['Taxa obtida no Livro foi de Q=883W. A taxa obtida com o CVFEM=',num2str(QT),'W para malha de 5x5 n�s'])

figure(7)
%efeito da malha
plot([5*5 7*7 11*11 21*21 31*31 41*41],[882.603 771.9985 694.9921 648.6766 636.8092 631.8639],'-ob')
xlabel('N�mero de n�s da malha'),ylabel('Taxa de transfer�ncia de calor convectiva (W)')
