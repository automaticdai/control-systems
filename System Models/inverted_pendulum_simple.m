% Model: Inverted Pendulum (Simplified State-space Model)
g = 9.81;
l = 0.2

A = [0 1; -g/l 0];
B = [0 g/l]';
C = [1 0];
D = 0;

P = ss(A,B,C,D);

% test stability
poles = eig(P)

% simulate the unforced free response
x0 = [3.14 / 2, 0];
t = 0:0.01:3;
[y, t, x] = initial(P, x0, t);

plot(t, x)
legend('x_1','x_2')
