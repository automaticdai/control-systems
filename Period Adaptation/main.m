syms s
s = tf('s');

% system model (simple first order system)
% time constant: 4
% response vs tau: 1 tau-63.2, 2 tau-86.5, 3 tau-95.0
Gs = 3 / (4*s + 1);
Cs = (0.1*s + 1) / (0.1*s);

Gsc = feedback(Gs * Cs, 1);

h = 0.01;

sim('discreate_control_by_period')

% estimate the transfer function
tfdata = iddata(input.data, output.data, h);
N = 1;                  % Number of poles
sys = tfest(tfdata,N);  







% [y,t] = step(Gsc);
% plot(t,y)
% hold on;

% for i = 1:1
%     % closed-loop discrete function
%     Gs_d = c2d(Gsc, 0.5 + 1e-2 * i);
%     step(Gs_d);
%     %plot(t,y)
%     hold on;
%     pause(0.1)
% end
