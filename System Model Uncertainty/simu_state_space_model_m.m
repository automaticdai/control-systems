%% System Modelling 

Gs = tf([3],[1 1 4]);
Gs = ss(Gs);

% state-space model
A = Gs.A;
B = Gs.B;
C = Gs.C;
D = Gs.D;

A2 = A .* 1.05;
B2 = B;
C2 = C;
D2 = D;
