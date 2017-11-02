syms x(t) y(t) e

%%
ode  = diff(y,2) + 5*diff(y)+1 == 50*x;

cond1 = x(0) == 1;
cond2 = y(0) == 0;
conds = [cond1; cond2];

%solu = dsolve(ode, conds);


%% 
solu = dsolve('D2y + 5 * Dy + 1 = 50*(e), Dy(0) = 0, y(0) = 0');

t_min = 0;
t_tick = 0.001;
t_max = t_min + t_tick;
y_init = 0;
ref = 1;

for i = 1:100
    t_min = t_min + 0.001;
    t_max = t_max + 0.001;
    t = [t_min:t_tick:t_max];
    solu = subs(solu, ['e'], [ref - y_init]);

    yplot = vpa(subs(solu, ['t'], [t]), 9);
    plot(t, yplot);
    hold on

    
end
