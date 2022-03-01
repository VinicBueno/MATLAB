close all, clear all,clc

carga=[0 13345 26680 33362 40034 46706 53379 55158 50170]
deltai=[0 0.00424 0.00846 0.01059 0.02286 0.1016 0.66 1.27 2.59]
A0=(pi*1.283^2)/4
I0=5,08

Tensao=ones(1,9)
Deformacao=ones(1,9)

for i=1:9
    Tensao(i)=carga(i)/A0
    Deformacao(i)=deltai(i)/I0
end

% width = 1; % Fraction of the figure width
% height = 1; % Fraction of the total figure height.
% set(gca, 'Position', [0, 0, width, height]);

figure(1)
plot(Deformacao,Tensao)
title('Tensão \times Deformação')
ylabel('\sigma N/{cm}^2'),xlabel('\epsilon','FontSize',20)