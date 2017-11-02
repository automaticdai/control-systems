syms x(t) y(t)

%% solve ode systems
ode1 = diff(x) == 4*x - 3*y;
ode2 = diff(y) == 6*x - 7*y;
odes = [ode1; ode2];


cond1 = x(0) == 0;
cond2 = y(0) == -1;
conds = [cond1; cond2];

[xSol(t), ySol(t)] = dsolve(odes,conds);



%% plot
[X,Y] = meshgrid(-8:1:8);

fplot(xSol, [0 5])
hold on
fplot(ySol, [0 5])
grid on
legend('xSol','ySol','Location','best')