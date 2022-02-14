function [Aglobal]=area_contorno(P,E,T,n_bc)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rotina escrita pelo Prof. Fábio Alfaia da Cunha, Email:fabioalfaia@unb.br
% Para disciplina Transferência de Calor, da Universidade de Brasília.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if size(P,1)>size(P,2),P=P';end
if size(E,1)>size(E,2),E=E';end
if size(T,1)>size(T,2),T=T';end
if size(n_bc,1)>size(n_bc,2),n_bc=n_bc';end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ind1=ismember(E(1,:),n_bc);
ind2=ismember(E(2,:),n_bc);
ind=false(size(E(:,1)));
ind((ind1==1)&(ind2==1))=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
no_c1=E(1,ind);  no_c2=E(2,ind);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X=P(1,:);      Y=P(2,:); 
Xbc1i=X(no_c1); Ybc1i=Y(no_c1); %Coordenadas do nó 1 segmento de contorno
Xbc2i=X(no_c2); Ybc2i=Y(no_c2); %Coordenadas do nó 2 segmento de contorno
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%vetor normal
nx_bc=+(Ybc2i-Ybc1i)/2;  %component X do vetor normal ao segmento de contorno
ny_bc=-(Xbc2i-Xbc1i)/2;  %component y do vetor normal ao segmento de contorno
%vetor tangente
A_bc=(nx_bc.^2+ny_bc.^2).^0.5;
% início - montagem do vetor de áreas global
Aglobal=zeros(length(P),1);     %Criação do vetor de Area global
for i=1:length(no_c1)
Aglobal(no_c1(i))=A_bc(i)+Aglobal(no_c1(i));
Aglobal(no_c2(i))=A_bc(i)+Aglobal(no_c2(i));
end
%vetor de áreas local = Comprimento do segmento de contorno y
