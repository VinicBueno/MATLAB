%% Questão 6. 
% Os dados de fadiga para uma liga de latão são dados numa tabela a seguir:

% Amplitude da Tensão (MPa) Ciclos até a Falha
% 170                        37000
% 148                        100000
% 130                        300000
% 114                        1000000
% 92                         10000000
% 80                         100000000
% 74                         1000000000

clc,clear,close all

AmplitudeTensao=[170 148 130 114 92 80 74]
CiclosAteFalha=[37000 100000 300000 1000000 10000000 100000000 1000000000]

%% (a) Faça um gráfico σ-N (amplitude da tensão x log do número de ciclos) usando esses dados;
logCiclos=log10(CiclosAteFalha)
plot(logCiclos,AmplitudeTensao)
title('Amplitude da tensão \times log do número de ciclos')
ylabel('\sigma','FontSize',20),xlabel('N')

%% (b) Determine a resistência à fadiga para 4000000 de ciclos;

ResistenciaFadiga=(log10(4e6)-logCiclos(4))/(logCiclos(5)-logCiclos(4))*(AmplitudeTensao(4)-AmplitudeTensao(5))+AmplitudeTensao(5)

%% (c) Determine a vida em fadiga para 120 MPa.

logVidaEmFadiga=(120-AmplitudeTensao(4))/(AmplitudeTensao(3)-AmplitudeTensao(4))*(logCiclos(4)-logCiclos(3))+logCiclos(3)
VidaEmFadiga=10^logVidaEmFadiga