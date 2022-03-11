clc,clear,close all

%% Questão 1. 
% Os dados a seguir foram obtidos de um corpo de prova de uma liga
% de cobre com 12,830 mm de diâmetro e comprimento inicial de 5,080 cm. Após a
% fratura, o comprimento total era de 7,655 cm, com diâmetro de 9,500 mm.

%% Dados do problema
D0=20 % [mm]
Df=18.35 % [mm]
A0=(pi*D0^2)/4 % [mm^2]
I0 = 40 % [mm]
If= 47.42 %[mm]
Af=(pi*Df^2)/4 % [mm^2]
Carga=[0 111205 222410 333617 400340 467063 533787 528717 556028] % [N]
Deltal=[0 0.0185 0.0370 0.0555 0.2 0.6 1.56 4 7.52] % [mm]

%% Trace a curva tensão-deformação e calcule:
Tensao=ones(1,9)
Deformacao=ones(1,9)

for i=1:9
    Tensao(i)=Carga(i)/A0
    Deformacao(i)=Deltal(i)/I0
end

figure(1)
plot(Deformacao,Tensao)
ylabel('Tensão \sigma N/{mm}^2'),xlabel('Deformação \epsilon')

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