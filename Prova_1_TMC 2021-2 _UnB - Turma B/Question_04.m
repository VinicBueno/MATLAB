clc,clear,close all

%% Questão 6. 
% Os dados de fadiga para uma liga de latão são dados numa tabela a seguir:

% Amplitude da Tensão (MPa) Ciclos até a Falha
% 470                        1e4
% 440                        3e4
% 390                        1e5
% 350                        3e5
% 310                        1e6
% 290                        3e6
% 290                        1e7
% 290                        1e8


AmplitudeTensao=[470 440 390 350 310 290 290 290]
CiclosAteFalha=[1e4 3e4 1e5 3e5 1e6 3e6 1e7 1e8]

%% (a) Trace um gráfico S-N
figure(1)
plot(log10(CiclosAteFalha),AmplitudeTensao)
ylabel('Amplitude de Tensão [MPa]'),xlabel('Logaritmo do número de ciclos até a falha')

%% (b) Qual é o limite de resistência à fadiga dessa liga?
% O limite de resistência à fadiga é o nível de tensão no qual a curva se
% torna horizontal, podemos observar pelo gráfico que esse limite é 290 Mpa

LimiteResistenciaFadiga = AmplitudeTensao(end)*1e6

%% (c) Determinar as vidas em fadiga para 415 MPa e 275 MPa.
%Precisa de uma interpolação para a tensão 415 MPa

VidaemFadiga = (415-AmplitudeTensao(3))/(AmplitudeTensao(2)-AmplitudeTensao(3))*(CiclosAteFalha(3)-CiclosAteFalha(2))+CiclosAteFalha(2)

figure(2)
plot(log10(CiclosAteFalha),AmplitudeTensao), hold on
ylabel('Amplitude de Tensão [MPa]'),xlabel('Logaritmo do número de ciclos até a falha')
plot([4 log10(CiclosAteFalha(2))],[440 440],'--','Color','#D95319'),plot([log10(CiclosAteFalha(2)) log10(CiclosAteFalha(2))],[440 280],'--','Color','#D95319')
plot(log10(CiclosAteFalha(2)),440,'ko')
plot([4 log10(CiclosAteFalha(3))],[390 390],'--','Color','#D95319'),plot([log10(CiclosAteFalha(3)) log10(CiclosAteFalha(3))],[390 280],'--','Color','#D95319')
plot(log10(CiclosAteFalha(3)),390,'ko')
plot([4 log10(VidaemFadiga)],[415 415],'--','Color','#D95319'),plot([log10(VidaemFadiga) log10(VidaemFadiga)],[415 280],'--','Color','#D95319')
plot(log10(VidaemFadiga),415,'ko')

% plot(4.7385,415,'ko')
%Para a amplitude de 275 MPa, podemos observar que o gráfico não se aplica,
%pois, este valor é menor que o limite a fadiga, portanto a liga suportaria
%um número infinito de ciclos sem falhas. Ou seja, para 275 MPa, o corpo
%não sofre falha por fadiga

%% d) Estime as resistências à fadiga a 2e4 e 6e5 ciclos

% Podemos estimar as resistências a fadiga a partir da análise gráfica.

ResistenciaFadiga1 = (2e4-CiclosAteFalha(1))/(CiclosAteFalha(2)-CiclosAteFalha(1))*(AmplitudeTensao(1)-AmplitudeTensao(2))+AmplitudeTensao(2)

figure(3)
plot(log10(CiclosAteFalha),AmplitudeTensao), hold on
ylabel('Amplitude de Tensão [MPa]'),xlabel('Logaritmo do número de ciclos até a falha')
plot([4 log10(CiclosAteFalha(1))],[470 470],'--','Color','#D95319'),plot([log10(CiclosAteFalha(1)) log10(CiclosAteFalha(1))],[470 280],'--','Color','#D95319')
plot(log10(CiclosAteFalha(1)),470,'ko')
plot([4 log10(CiclosAteFalha(2))],[440 440],'--','Color','#D95319'),plot([log10(CiclosAteFalha(2)) log10(CiclosAteFalha(2))],[440 280],'--','Color','#D95319')
plot(log10(CiclosAteFalha(2)),440,'ko')
plot([4 log10(2e4)],[ResistenciaFadiga1 ResistenciaFadiga1],'--','Color','#D95319'),plot([log10(2e4) log10(2e4)],[ResistenciaFadiga1 280],'--','Color','#D95319')
plot(log10(2e4),ResistenciaFadiga1,'ko')

ResistenciaFadiga2 = (6e5-CiclosAteFalha(4))/(CiclosAteFalha(5)-CiclosAteFalha(4))*(AmplitudeTensao(4)-AmplitudeTensao(5))+AmplitudeTensao(5)

figure(4)
plot(log10(CiclosAteFalha),AmplitudeTensao), hold on
ylabel('Amplitude de Tensão [MPa]'),xlabel('Logaritmo do número de ciclos até a falha')
plot([4 log10(CiclosAteFalha(4))],[350 350],'--','Color','#D95319'),plot([log10(CiclosAteFalha(4)) log10(CiclosAteFalha(4))],[350 280],'--','Color','#D95319')
plot(log10(CiclosAteFalha(4)),350,'ko')
plot([4 log10(CiclosAteFalha(5))],[310 310],'--','Color','#D95319'),plot([log10(CiclosAteFalha(5)) log10(CiclosAteFalha(5))],[310 280],'--','Color','#D95319')
plot(log10(CiclosAteFalha(5)),310,'ko')
plot([4 log10(6e5)],[ResistenciaFadiga2 ResistenciaFadiga2],'--','Color','#D95319'),plot([log10(6e5) log10(6e5)],[ResistenciaFadiga2 280],'--','Color','#D95319')
plot(log10(6e5),ResistenciaFadiga2,'ko')
