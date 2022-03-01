function [A] = Monta_A(k,P,T)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rotina escrita pelo Prof. Fábio Alfaia da Cunha, Email:fabioalfaia@unb.br
% Para disciplina Transferência de Calor, da Universidade de Brasília.
%%%%%%%%%Correção do formato do Vetores%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if size(k,1)>size(k,2),k=k';end
if size(P,1)>size(P,2),P=P';end
if size(T,1)>size(T,2),T=T';end
%%%%%%%%%Coordenadas internas dos elementos%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X=P(1,:);  Y=P(2,:);
T1=T(1,:); T2=T(2,:); T3=T(3,:);
X1=X(T1);  X2=X(T2);  X3=X(T3);
Y1=Y(T1);  Y2=Y(T2);  Y3=Y(T3);
Xo=(X1+X2+X3)/3;  Xa=(X1+X2)/2;    Xb=(X3+X2)/2;  Xc=(X1+X3)/2;
Yo=(Y1+Y2+Y3)/3;  Ya=(Y1+Y2)/2;    Yb=(Y3+Y2)/2;  Yc=(Y1+Y3)/2;
%%%%%%%%Componenetes dos vetores normais%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Sao_x=+(Yo-Ya); Soa_x=-Sao_x;
Sao_y=-(Xo-Xa); Soa_y=-Sao_y;
Sbo_x=+(Yo-Yb); Sob_x=-Sbo_x;
Sbo_y=-(Xo-Xb); Sob_y=-Sbo_y;
Sco_x=+(Yo-Yc); Soc_x=-Sco_x;
Sco_y=-(Xo-Xc); Soc_y=-Sco_y;
%%%%%%%%Determinate=2*Área%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D=X2.*Y3-X3.*Y2+X3.*Y1-X1.*Y3+X1.*Y2-X2.*Y1;
%%%%%%%%Cálculos dos coeficientes Locais%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C11=k.*((Y2-Y3).*(Sao_x+Soc_x)+(X3-X2).*(Sao_y+Soc_y))./D;
C12=k.*((Y3-Y1).*(Sao_x+Soc_x)+(X1-X3).*(Sao_y+Soc_y))./D;
C13=k.*((Y1-Y2).*(Sao_x+Soc_x)+(X2-X1).*(Sao_y+Soc_y))./D;
C21=k.*((Y2-Y3).*(Soa_x+Sbo_x)+(X3-X2).*(Soa_y+Sbo_y))./D;
C22=k.*((Y3-Y1).*(Soa_x+Sbo_x)+(X1-X3).*(Soa_y+Sbo_y))./D;
C23=k.*((Y1-Y2).*(Soa_x+Sbo_x)+(X2-X1).*(Soa_y+Sbo_y))./D;
C31=k.*((Y2-Y3).*(Sco_x+Sob_x)+(X3-X2).*(Sco_y+Sob_y))./D;
C32=k.*((Y3-Y1).*(Sco_x+Sob_x)+(X1-X3).*(Sco_y+Sob_y))./D;
C33=k.*((Y1-Y2).*(Sco_x+Sob_x)+(X2-X1).*(Sco_y+Sob_y))./D;
%%%%%%%%%%Montagem da matriz de coeficientes Globais%%%%%%%%%%%%%%%%%%%%%%%
Li=[T1;T1;T1;T2;T2;T2;T3;T3;T3]; %Coordenadas I da matriz global x Local
Lj=[T1;T2;T3;T1;T2;T3;T1;T2;T3]; %Coordenadas J da matriz global x Local
Lv=[C11;C12;C13;C21;C22;C23;C31;C32;C33];%Valores da matriz Local
A=sparse(Li,Lj,Lv); % Montagem da matriz global a apartir dos termos Locais
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%