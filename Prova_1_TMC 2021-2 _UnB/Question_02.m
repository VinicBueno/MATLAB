clc,clear,close all

%% Questão 2.
% O Tório é o elemento químico com maior ponto de fusão (mais de 3000°C) e, por isso, é muito utilizado em
% núcleos de reatores nucleares de potência. A sua massa específica é de 11,72g/cm3, sua estrutura cristalina é CFC e a sua
% massa atômica é de 232g/mol. Calcule: 

%% Dados do problema:
massa=11.72 % Massa específica [g/cm^3]
A=232 % Massa atômica [g/mol]
NA=6.02e23 % Número de avogrado [átomos/mol]

%% (b) o seu  raio atômico

R=((3*A)/(pi*massa*NA))^(1/3)

%% (a) o seu parâmetro de rede

a=(4*R)/sqrt(2)