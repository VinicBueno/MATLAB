function [FI]=CAL_TEMP(gama,ro,dt,SP_vol,SC_vol,FI,N_bc,P,T)
%processamento%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[A,vol] = Monta_A(gama,P,T); 
%processamento%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Massa=ro.*vol;
%termo transiente implicito%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:length(P)
    A(i,i)=A(i,i)+(1/dt)*Massa(i)+SP_vol(i);
end
%termo transiente explicito%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
B_M=(1/dt)*Massa.*FI(:,2)+SC_vol;
%Condição de contorno implicita%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:length(N_bc)
    A(N_bc(i),:)=0;
    A(N_bc(i),N_bc(i))=1;
    B_M(N_bc(i))=FI(N_bc(i),1);
end
%solução sistema de equações%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FI(:,1)=A\B_M;