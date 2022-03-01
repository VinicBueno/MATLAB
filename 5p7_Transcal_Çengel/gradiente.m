function [k_dT_dxi,k_dT_dyi] = gradiente(k,Temp,P,T)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rotina escrita pelo Prof. Fábio Alfaia da Cunha, Email:fabioalfaia@unb.br
% Para disciplina Transferência de Calor, da Universidade de Brasília.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if size(k,1)>size(k,2),k=k';end
if size(P,1)>size(P,2),P=P';end
if size(T,1)>size(T,2),T=T';end
if size(Temp,1)>size(Temp,2),Temp=Temp';end
%coordenadas
X=P(1,:);  Y=P(2,:);
%matriz de conectividade
T1=T(1,:); T2=T(2,:); T3=T(3,:);
%coordenadas dos três elementos de cada elemento
X1=X(T1); X2=X(T2); X3=X(T3);
Y1=Y(T1); Y2=Y(T2); Y3=Y(T3);
%Temperaturas dos três elementos de cada elemento
Temp1=Temp(T1); Temp2=Temp(T2); Temp3=Temp(T3);
%Determinante baseado nas coordenadas dos três nós dos elementos
D=X2.*Y3-X3.*Y2+X3.*Y1-X1.*Y3+X1.*Y2-X2.*Y1;
%Área de um elemento
Atri=D/2;
%Sub-áreas associadas a cada nó do elemento.
Atri1=Atri/3; Atri2=Atri/3; Atri3=Atri/3;
%Cálculo da das áreas associadas aos nós com base nas áreas do elementos.
A_i=zeros(length(P),1);
for i=1:length(T)
A_i(T(1,i))=Atri1(i)+A_i(T(1,i));
A_i(T(2,i))=Atri2(i)+A_i(T(2,i));
A_i(T(3,i))=Atri3(i)+A_i(T(3,i));
end
%Derivada na direção x, "A", e na direção "y", B, baseada nos elementos.
k_dT_dx =k.*(Temp1.*(Y2-Y3) + Temp2.*(Y3-Y1) + Temp3.*(Y1-Y2))./D;
k_dT_dy =k.*(Temp1.*(X3-X2) + Temp2.*(X1-X3) + Temp3.*(X2-X1))./D;
%Cálculo das derivadas nos nós, com base nas derivadas dos elementos
k_dT_dxA=zeros(length(P),1);
k_dT_dyA=zeros(length(P),1);
for i=1:length(T)
k_dT_dxA(T(1,i))=Atri1(i)*k_dT_dx(i)+k_dT_dxA(T(1,i));
k_dT_dxA(T(2,i))=Atri2(i)*k_dT_dx(i)+k_dT_dxA(T(2,i));
k_dT_dxA(T(3,i))=Atri3(i)*k_dT_dx(i)+k_dT_dxA(T(3,i));
k_dT_dyA(T(1,i))=Atri1(i)*k_dT_dy(i)+k_dT_dyA(T(1,i));
k_dT_dyA(T(2,i))=Atri2(i)*k_dT_dy(i)+k_dT_dyA(T(2,i));
k_dT_dyA(T(3,i))=Atri3(i)*k_dT_dy(i)+k_dT_dyA(T(3,i));
end
k_dT_dxi=k_dT_dxA./A_i; k_dT_dyi=k_dT_dyA./A_i;