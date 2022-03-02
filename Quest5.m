%% Questão 5
% Os dados a seguir foram coletados em um corpo-de-prova padronizado, com 1,283 cm de diâmetro,
% referente a uma liga de cobre (comprimento inicial (l0) = 5,08 cm). Após a fratura, o comprimento 
% total era de 7,655 cm, com diâmetro de 0,950 cm. Trace a curva tensão-deformação e calcule:
%%
clc,clear,close all

carga=[0 13345 26680 33362 40034 46706 53379 55158 50170]
deltai=[0 0.00424 0.00846 0.01059 0.02286 0.1016 0.66 1.27 2.59]

D0=1.283 % [cm]
Df=0.950 % [cm]
A0=(pi*D0^2)/4 % [cm^2]
I0 = 5,08 % [cm]
If= 7.655 %[cm]
Af=(pi*Df^2)/4 % [cm^2]
ex=(D0-Df)/D0

Tensao=ones(1,9)
Deformacao=ones(1,9)
alongamento=(If-I0)/I0
reducaoArea=(A0-Af)/A0

for i=1:9
    Tensao(i)=carga(i)/A0
    Deformacao(i)=deltai(i)/I0
end

elasticidade=Tensao(4)/Deformacao(4)
poisson=ex/alongamento
rigidez=elasticidade/(2+2*poisson)

figure(1)
plot(Deformacao,Tensao)
title('Tensão \times Deformação')
ylabel('\sigma N/{cm}^2'),xlabel('\epsilon','FontSize',20)