% Lab 4 - Zagadnienie dualne programowania liniowego
% Zagadnienie prymalne
AIn = [-2 -3 ; 1 12]; % 2x1 + 3x2 >= 0 <-> -2x1 - 3x2 <= 0
bIn = [0 1];
AIneq = [2 1];
bIneq = [3];
lbIn = [0 -Inf];
cIn = [10 4];
[xIn, fIn, eIn, sumIn] = linprog(-cIn, AIn, bIn, AIneq, bIneq, lbIn, []);
% Zagadnienie dualne
Ad = [-2 -2 -1]; % 2y1 + 2y2 + y3 >= 10 <-> -2y1 - 2y2 - y3 <= -10
bd = [-10];
Adeq = [3 1 12];
bdeq = [4];
lbd = [-Inf -Inf 0];
ubd = [0 Inf Inf];
fd = [0 3 1];
[xD, fD, eD, sumD] = linprog(fd, Ad, bd, Adeq, bdeq, lbd, ubd);
disp("--- Prymalne ---");
disp(fIn);
disp("--- Dualne ---");
disp(fD);
