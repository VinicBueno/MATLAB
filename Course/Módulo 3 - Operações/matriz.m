clc;
clear all;
close all;
%%
M = [1 2 3;3 4 5;5 7 5];
N = [1; 2; 3; 3; 4; 8];

size(M);%TAMANHO Lxc
size(N,1);%QTDE linhas
size(N,2);%QTDE colunas
%Matriz de zeros
P = zeros(2,4);
P = zeros(size(M));
%Matriz de UM
Q = ones(3,6);
Q = ones(size(P));
%MATRIZ IDENTIDADE
O = eye(5);
O(3,3)=9;

%% OPERAÇÕES COM MATRIZ
A= [1 5;1 2];
B = [1 3; 1 5];
%Soma
A+B;
%SUBTRAÇÃO
A-B;
%Multiplicação
A*B;
%Determinante
det(A);
%Inversa
inv(A);
%Transposta
A;
A';
% Autovalores e autovetores
[avet,avalor] = eig(A);
%diagonal
diag(A);
A;


