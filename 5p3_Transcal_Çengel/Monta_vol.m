function [vol] = Monta_vol(k,P,T)
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
v1=(D/6);   v2=(D/6);   v3=(D/6);   vol=zeros(length(P),1);
for i=1:length(T)
    vol(T1(i))=v1(i)+vol(T1(i));
    vol(T2(i))=v2(i)+vol(T2(i));
    vol(T3(i))=v3(i)+vol(T3(i));
end