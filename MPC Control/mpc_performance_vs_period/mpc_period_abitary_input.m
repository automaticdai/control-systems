% -------------------------------------------------------------------------
% mpc_exp.m
% Explore MPC performance with period.
% Author: Xiaotian Dai
% https://uk.mathworks.com/help/mpc/examples/control-of-a-single-input-single-output-plant.html
% -------------------------------------------------------------------------

%% 
clear; close all;

simu.start_time = 0;
simu.end_time = 10;


%% system dynamic model define
a = 2.0;
plant = tf([2 3],[a 5 1]);

Ts = 0.1;

% inputs
Ts_r = 0.001;
t = [0:Ts_r:10]';

ref = zeros(numel(t),1);
ref_input.time = t;
ref_input.signals.values = [ref];
ref_input.signals.dimensions = 1;

noise = randn(numel(t), 1);
noise_input.time = t;
noise_input.signals.values = [0.01 .* noise];
noise_input.signals.dimensions = 1;

sim('disturbance_generator');
d_input.time = t;
d_input.signals.values = [d.data];
d_input.signals.dimensions = 1;


%% MPC controller
p = 10;
m = 3;
mpcobj = mpc(plant, Ts, p, m);


%% constraints
mpcobj.MV = struct('Min',-1,'Max',1);

mdl = 'mpc_simulink_with_r_and_d';
open_system(mdl);
sim(mdl);


%% output error
cost = sum((0 - y) .^ 2 * Ts);
fprintf('State cost: %f \r\n', cost)


