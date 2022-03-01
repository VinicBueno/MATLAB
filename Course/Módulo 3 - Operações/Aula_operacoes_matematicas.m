clc
clear all;
close all;
% operações matemáticas
%% Aula 9
% soma
a = 2;
b = 4;
c = a+b;
%Subtração
d = a-b;
%Multiplicação
e = a*b;
%Divisão
f = b/a;
f = b\a; % = a/b
%Raiz quadrada
g = sqrt(b);
%Potência
h = b^a;

%% Aula 10
%Exponencial
i = exp(a);
%Módulo
abs(a);
%Logaritmo
j = log10(2)%base 10
j = log2(2)%base 2
j = log(2)%base e
%Arredondamento
round(3.7);%pega o inteiro
ceil(3.7); % aproxima o valor
% máximo divisor comum
gcd(4,10)
% minimo multiplo comum
lcm(2,15)
%resto divisão
D = rem(4,3)

%% Aula 11
%seno 
sin(10)
sin(10*180/pi)
%cosseno
cos(10);
cosd(45);
%tangente
tan(2);
%cotangente
cot(2)
%secante
sec(2)
%cossecante
csc(2)
%Arco
asin(2)
acos(2)
acot(2);
%Hiperbólico
sinh(2)
cosh(2)
asinh(3)

%Criar vetor
t = 0:1:10
tt = linspace(1,100,20)
sin((10*180/pi)*t)
%Comprimento vetor
length(t);

%% Aula 12
M = [1 2 3; 3 4 5; 5 7 7]
N = [1,2,3;3,4,5];
N = [1;2;3;4;5]
size(N)             %Dimensão da matriz
size(N,1)           %Numero de linhas
length(N)           %Maior dimensão
size(N,2)           %Numero de colunas
%Matriz zeros
N = zeros(1,3)
N = zeros(size(M))
%Matriz uns
N = ones(1,3)
N = ones(size(M))
%Matriz identidade
N = eye(2)
N = eye (5)
%Substituir valores na matriz
N(1,2) = 5

%% Aula 13 
%Criando matriz
A = [1 5;1 2]
B = [1 3;1 5]
%soma
C= A+B
%Subtração
C=A-B
%Multiplicação
C = A*B
%Determinante
D = det(A)
%Inversa
C = inv(A)
%Transposta
C= A'
%Autovalores e autovetores
[avet, avalor] = eig(A);
%Diagonal
diag(A)

