% Objective: minimize h while make the system stable.
% Xiaotian Dai
close all

syms s
s = tf('s');

% reference model (simple first-order system)
% time constant: 4s, steady-state: 12s
% for first-order system
% response vs tau: 1 tau-63.2, 2 tau-86.5, 3 tau-95.0
Gs_actual = 3 / (4*s + 1);

% actual system model
% time constant: 6s, steady-state time: 6*3 = 18s
Gs = 3 / (6*s + 1);
%Kp = 2.8;
Kp = 10;
Ti = 1.1; 
Cs = Kp * (Ti*s + 1) / (Ti*s);
Hsc = feedback(Gs * Cs, 1);

f1 = figure;
f2 = figure;

for i = 0:20
    
h = 0.12 + 0.012 * i;

% evaluate stability
Gsd = c2d(Gs, h);
Csd = c2d(Cs, h);
Hscd = (Gsd*Csd)/(1 + Gsd*Csd);


% run simlink
sim('discreate_control_by_period')
u = input.data;
y = output.data;
t = output.time;

% performance index
ss_region_logic = ~(y > 0.95 & y < 1.05);
ss_region_idx = find(ss_region_logic, 1, 'last');

pi_ss_time = t(ss_region_idx);
pi_state_cost = sum((1-y).^2 * h);
pi_control_cost = sum(u .^ 2 * h);
pi_quad_cost = pi_state_cost + pi_control_cost;
%%pi_stability = ;


%% plot PIs
figure(f1)
subplot(4,1,1)
scatter(h, pi_ss_time, 'b');
hold on;

subplot(4,1,2)
scatter(h, pi_state_cost, 'r');
hold on;

subplot(4,1,3)
scatter(h, pi_control_cost, 'g');
hold on;

subplot(4,1,4)
scatter(h, pi_quad_cost, 'y');
hold on;

%% plot respones
figure(f2)
subplot(2, 1, 1)
plot(t, y)
hold on;

subplot(2, 1, 2)
plot(t, u)
hold on;


end




%% estimate the transfer function
% tfdata = iddata(y, u, h);
% N = 1;                  % Number of poles
% sys = tfest(tfdata,N);
% 
% Esimate a parametric model.
% sys1 = ssest(z1,4);
% 
% Estimate a non-parametric model.
% sys2 = impulseest(z1);
% 
% [y1, ~, ~, ysd1] = step(sys, t);
% plot(t, y1, 'b', t, y1+3*ysd1, 'b:', t, y1-3*ysd1, 'b:')
% hold on;
% 
% 
% [y2, ~] = step(Gs, t);
% plot(t, y2, 'r')



