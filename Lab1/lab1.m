% Lab 1 - Przypomnienie MATLAB
% -----------------------------
% Komentarze: CTRL + R

vec = [1 222 3 4]; % Wektor wierszowy
disp(vec(2)); % Indeksacja od 1.

clc; % Czyszczenie Konsoli
clear; % Czyszczenie Workspace'u

mat = [1 2 3 ; 4 5 6 ; 56 7 -9];
disp(mat);
disp(mat(2,3)); % Konkretny element
disp(mat(1, :)); % Pelen wiersz
disp(mat(2:3, 1:2)); % Podmacierz

% Klasyczne macierze
idMat = eye(4); % Macierz jednostkowa 4x4
onesMat = ones(3); % Macierz samych jedynek 3x3
zerosMat = zeros(2, 3); % Macierz zer 2x3
disp(zerosMat);

withStep = 0:1:2; % Definicja wektora z krokiem
disp(withStep)
zerosMat(1, :) = withStep; % Zmiana wiersza macierzy
disp(zerosMat);

vec2 = [1 5 7];
vec2(end + 1) = 18; % end - wskaznik na koniec.
disp(vec2);

% Funkcje na macierzach i macierze losowe
rng(42); % Seed
rndMat = randi([-10, 10], 3, 3); 

clc;
disp(rndMat);
detRndMat = det(rndMat); % Wyznacznik
disp(detRndMat);

trRndMat = rndMat'; % Transpozycja, mozliwe takze: transpose(rndMat);
disp(trRndMat);
disp(size(rndMat, 2)); % size bez arg: dwa wymiary, 1 - wierszowy, 2 - kolumnowy

% Funkcje, pętle, ify
% Funkcja tylko dla pokazania skladni
function [z0, z1] = tmpFun(a, b, c)
    s = 0;
    for i = 1:10
        s = s + a + b + c;
        if s > 50
            s = 0;
        else
            s = s + i;
        end
    end
    z0 = s + 1;
    z1 = s * s;
end

[z0, z1] = tmpFun(1, 2, 3);
disp([z0, z1]);

% Wykresy
% Losujemy 100 razy wektor liczb calkowitych dlugosci 3 
% z zakresu [0, 10], bierzemy z niego 
% maksimum. Na koniec, rysujemy histogram tych maximow.
numIter = 100;
maxes = zeros(numIter, 1);
for i=1:numIter
    vec = randi([0, 10], 3, 1);
    maxes(i) = max(vec);
end
histogram(maxes);




