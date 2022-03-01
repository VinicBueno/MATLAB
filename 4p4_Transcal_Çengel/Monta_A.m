function [A,vol] = Monta_A(k,P,T)
% Rotina escrita pelo Prof. Fábio Alfaia da Cunha, Email:fabioalfaia@unb.br
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X=P(1,:);  Y=P(2,:);
T1=T(1,:); T2=T(2,:); T3=T(3,:);
X1=X(T1);  X2=X(T2);  X3=X(T3);
Y1=Y(T1);  Y2=Y(T2);  Y3=Y(T3);
Xo=(X1+X2+X3)/3;  Xa=(X1+X2)/2;    Xb=(X3+X2)/2;  Xc=(X1+X3)/2;
Yo=(Y1+Y2+Y3)/3;  Ya=(Y1+Y2)/2;    Yb=(Y3+Y2)/2;  Yc=(Y1+Y3)/2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nSx_ao=+(Yo-Ya); nSx_oa=-nSx_ao;
nSy_ao=-(Xo-Xa); nSy_oa=-nSy_ao;
nSx_bo=+(Yo-Yb); nSx_ob=-nSx_bo;
nSy_bo=-(Xo-Xb); nSy_ob=-nSy_bo;
nSx_co=+(Yo-Yc); nSx_oc=-nSx_co;
nSy_co=-(Xo-Xc); nSy_oc=-nSy_co;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
D=X2.*Y3-X3.*Y2+X3.*Y1-X1.*Y3+X1.*Y2-X2.*Y1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
C11=-k.*((Y2-Y3).*nSx_ao+(X3-X2).*nSy_ao+(Y2-Y3).*nSx_oc+(X3-X2).*nSy_oc)./D;
C12=-k.*((Y3-Y1).*nSx_ao+(X1-X3).*nSy_ao+(Y3-Y1).*nSx_oc+(X1-X3).*nSy_oc)./D;
C13=-k.*((Y1-Y2).*nSx_ao+(X2-X1).*nSy_ao+(Y1-Y2).*nSx_oc+(X2-X1).*nSy_oc)./D;
C21=-k.*((Y2-Y3).*nSx_oa+(X3-X2).*nSy_oa+(Y2-Y3).*nSx_bo+(X3-X2).*nSy_bo)./D;
C22=-k.*((Y3-Y1).*nSx_oa+(X1-X3).*nSy_oa+(Y3-Y1).*nSx_bo+(X1-X3).*nSy_bo)./D;
C23=-k.*((Y1-Y2).*nSx_oa+(X2-X1).*nSy_oa+(Y1-Y2).*nSx_bo+(X2-X1).*nSy_bo)./D;
C31=-k.*((Y2-Y3).*nSx_co+(X3-X2).*nSy_co+(Y2-Y3).*nSx_ob+(X3-X2).*nSy_ob)./D;
C32=-k.*((Y3-Y1).*nSx_co+(X1-X3).*nSy_co+(Y3-Y1).*nSx_ob+(X1-X3).*nSy_ob)./D;
C33=-k.*((Y1-Y2).*nSx_co+(X2-X1).*nSy_co+(Y1-Y2).*nSx_ob+(X2-X1).*nSy_ob)./D;
%%%%%%%%%%Montagem da matriz de coeficientes Globais%%%%%%%%%%%%%%%%%%%%%%%
Li=[T1;T1;T1;T2;T2;T2;T3;T3;T3]; %Coordenadas I da matriz global x Local
Lj=[T1;T2;T3;T1;T2;T3;T1;T2;T3]; %Coordenadas J da matriz global x Local
Lv=[C11;C12;C13;C21;C22;C23;C31;C32;C33];%Valores da matriz Local
A=sparse(Li,Lj,Lv); 
%%%%%%%%%%%Subvolumes de controle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
v1=(D/6);   v2=(D/6);   v3=(D/6);   vol=zeros(length(P),1);
for i=1:length(T)
    vol(T1(i))=v1(i)+vol(T1(i));
    vol(T2(i))=v2(i)+vol(T2(i));
    vol(T3(i))=v3(i)+vol(T3(i));
end