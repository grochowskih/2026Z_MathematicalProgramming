% Lab 2 - Podstawowe zagadnienia programowania liniowego

% Part I
A = [2 -5 1 ; 2 -1 2 ; -1 0 0 ; 0 -1 0 ; 0 0 -1]; % Macierz nierownosciowa ograniczen
b = [-2 4 0 0 0]; % Macierz nierownosciowa wyrazow wolnych
f = [1 3 1]; % Wspolczynniki minimalizowanej funkcji celu

[xOpt, fOpt, exit1, summary1] = linprog(f, A, b);
disp("Optymalne:");
disp(xOpt);
disp("Optymalna wartosc:");
disp(fOpt);
disp("Podsumowanie:");
disp(summary1);

% disp("Weryfikacja brzegu:");
% disp(A * xOpt - b');

clc;

% Part II

A2 = A(1:2, :); % Macierz nierownosciowa ograniczen - ograniczenia na zmienne przesuniete do lb
b2 = b(1:2); % Macierz nierownosciowa wyrazow wolnych
Aeq = [1 -1 4]; % Macierz ograniczen rownosciowych
beq = [0]; % Macierz rownosciowa wyrazow wolnych 
lb = [0 0 0]; % Ograniczenia dolne na zmienne
ub = [Inf 6 Inf]; % Ograniczenia gorne na zmienne, zmienne x1 oraz x3 nieograniczone z gory

[xOpt2, fOpt2, e2, summ2] = linprog(f, A2, b2, Aeq, beq, lb, ub);
disp("Optymalne rozwiązanie dla podpunktu b:");
disp(xOpt2);
disp("Optymalna wartość:");
disp(fOpt2);


