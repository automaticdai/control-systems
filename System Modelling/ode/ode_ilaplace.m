
syms s

eq = ilaplace(50 / (s^2+5*s+1));

subs(eq, ['t'], [1]);
vpa(subs(eq, ['t'], [1]), 9)