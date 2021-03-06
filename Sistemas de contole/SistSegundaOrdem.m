% Para o sistema cujo função de transferência representa-se abaixo, calcule o 
% sobressinal, os tempos de subida , de pico e de acomodação, bem como a
% frequência natural e a porcentagem de sobressianl.
% Escreva o problema no Matlab que atenda o solicitado.
% 
% G(s) = 361/(s^2+16s+361)
%

numg = 361;
deng = [1 16 361];

omega = sqrt(deng(3)/deng(1))                       % Frequência natural
zeta = (deng(2)/deng(1))/(2*omega)                  % Coeficiente de amortecimento
Ts = 4/(zeta*omega)                                 % Tempo de acomodação
Tp = pi/(omega*sqrt(1-zeta^2))                      % Tempo de pico (Peak time)
pos = 100*exp(-zeta*pi/sqrt(1-zeta^2))              % Porcentagem do sobressinal
Tr = (1.768*zeta^3-0.417*zeta^2+1.039*zeta+1)/omega % Tempo de subida(Rise time) 