% Algorytm Sympleks - Uproszczona Implementacja Uproszczona
% Funkcja przyjmuje na wejściu zagadnienie programowania liniowego w
% postaci standardowej
% max c^T * x  s.t. Ax = b, x >= 0
% IN:
%   A - macierz współczynników (m wierszy, n kolumn) z macierzą jednostkową
%   "na końcu"
%   b - macierz wyrazów wolnych (m wierszy, 1 kolumna) [zakladamy, ze b>=0]
%   c - wektor współczynników funkcji celu (1 wiersz, n kolumn)
% OUT:
%   xOpt - rozwiazanie optymalne
%   fOpt - optymalna wartość funkcji celu
%   exitflag - flaga wyjścia ("Optimal", "Unbounded")
%   iters - liczba iteracji algorytmu sympleks

function [xOpt, fOpt, exitflag, iters] = simplex(A, b, c)
    tab = [A , b];
    lastRow = [-c , 0];
    tab = [tab ; lastRow];
    run = true;
    base = (size(A,2) + 1 - size(A, 1)):1:(size(A,2));
    iters = 0;
    
    while run
        disp("----------------");
        iters = iters + 1;
        disp(["Table - Iter ", num2str(iters)]);
        disp(tab);
        disp("Zmienne bazowe");
        disp(base);

        % Optimality
        lastRow = tab(end, 1:end-1);
        if all(lastRow >= -1e-10)
            exitflag = "Optimal";
            break;
        end

        % Lowest z_j - c_j
        [lowestDiff, lowestZjCjIndex] = min(lastRow);
        disp("Najnizsza wartosc ujemna w ostatnim rzedzie jest dla zmiennej, ktora wprowadzimy do bazy:");
        disp(lowestZjCjIndex);

        % Bound
        if all(tab(1:end-1, lowestZjCjIndex) <= 1e-8)
            exitflag = "Unbounded";
            break;
        end

        % Min b_j/a_ij
        minRatio = Inf;
        minIndex = Inf;
        for i = 1:(size(A, 1))
            if tab(i, lowestZjCjIndex) > 1e-10
                tmpRatio = tab(i, end) / tab(i, lowestZjCjIndex);
                if tmpRatio < minRatio
                    minRatio = tmpRatio;
                    minIndex = i;
                end
            end
        end
        disp("Najmniejszy dodatni stosunek ostatniaKolumna/kolumnaWprowadzana jest dla ograniczenia");
        disp(minIndex);

        if minRatio == Inf
            exitflag = "Unbounded";
            break;
        end
        pvt = tab(minIndex, lowestZjCjIndex);
        tab(minIndex, :) = tab(minIndex, :) / pvt;
        for i = 1:(size(A, 1)+1)
            if i ~= minIndex
                tab(i, :) = tab(i, :) - tab(i, lowestZjCjIndex) * tab(minIndex, :);
            end
        end
        % Final including to base
        base(minIndex) = lowestZjCjIndex;
    end

    if exitflag == "Optimal"
        x = zeros(size(A, 2),1);
        for i = 1:(size(A, 1))
            if base(i) <= size(A, 2)
                x(base(i)) = tab(i, end);
            end
        end
        xOpt = x(1:(size(A, 2) - size(A, 1)));
        fOpt = c(1:(size(A, 2) - size(A, 1))) * xOpt;
    end
    if exitflag == "Unbounded"
        xOpt = [];
        fOpt = [];
    end
end

% Lab 3 - Postać standardowa, algorytm sympleks

% Zagadnienie wejściowe
AIn = [3 1 1 ; 1 -1 2 ; 1 1 -1];
bIn = [60 10 20];
lbIn = [0 0 0];
cIn = [-2 -1 -1];

% Zagadnienie w postaci standardowej
ASt = [3 1 1 1 0 0 ; 1 -1 2 0 1 0 ; 1 1 -1 0 0 1];
bSt = bIn;
lbSt = [0 0 0 0 0 0];
cSt = [2 1 1 0 0 0];

% Uruchomienie obu zagadnień, użycie algorytmu punktu wewnętrznego
options = optimoptions('linprog', 'Algorithm','interior-point');
[xI, fI, eI, sumI] = linprog(cIn, AIn, bIn, [], [], lbIn, [], options);
[xS, fS, eS, sumS] = linprog(-cSt, [], [], ASt, bSt, lbSt, [], options);
disp("Rozwiazanie wejsciowego:");
disp(xI);
disp(fI);
disp("Rozwiazanie standardowego:");
disp(xS);
disp(fS);

% Rozwiazanie z algorytmu sympleks
[xSimplex, fSimplex, exit, iters] = simplex(ASt, bSt', cSt);
disp("Rozwiazanie z sympleksu");
disp(xSimplex);
disp(fSimplex);
