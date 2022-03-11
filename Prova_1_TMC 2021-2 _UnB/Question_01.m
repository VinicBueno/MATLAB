clc,clear,close all

%% Questão 1. 
% Os dados a seguir foram obtidos de um corpo de prova de uma liga
% de cobre com 12,830 mm de diâmetro e comprimento inicial de 5,080 cm. Após a
% fratura, o comprimento total era de 7,655 cm, com diâmetro de 9,500 mm.

%% Dados do problema
D0=1.283 % [cm]
Df=0.950 % [cm]
A0=(pi*D0^2)/4 % [cm^2]
I0 = 5,08 % [cm]
If= 7.655 %[cm]
Af=(pi*Df^2)/4 % [cm^2]
Carga=[0 13345 26680 33362 40034 46706 53379 55158 50170]
Deltal=[0 0.00424 0.00846 0.01059 0.02286 0.10160 0.66 1.27 5.59]

%% Trace a curva tensão-deformação e calcule:
Tensao=ones(1,9)
Deformacao=ones(1,9)

for i=1:9
    Tensao(i)=Carga(i)/A0
    Deformacao(i)=Deltal(i)/I0
end

figure(1)
plot(Deformacao,Tensao)
title('Tensão \times Deformação')
ylabel('\sigma N/{cm}^2'),xlabel('\epsilon','FontSize',20)

%% a) o módulo de elasticidade;

ModuloElasticidade = Tensao(4)/Deformacao(4)

%% b) a ductilidade;

Ductilidade = (A0-Af)/A0*100

%% c) a tensão de escoamento;

TensaoEscoamento = Tensao(5)

%% d) o limite de resistência à tração;

LimiteResistenciaTracao = max(Tensao)

%% e) a tensão de ruptura;

TensaoRuptura = Tensao(end)

%% f) a rigidez;

Poisson = ((D0-Df)/D0)/((If-I0)/I0)
Rigidez = ModuloElasticidade/(2+2*Poisson)

%% g) a tensão verdadeira na fratura

TensaoVerdadeira = TensaoRuptura*(1+((If-I0)/I0))