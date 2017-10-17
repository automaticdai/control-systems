% -------------------------------------------------------------------------
% mpc_exp.m
% Explore MPC performance with period.
% Author: Xiaotian Dai
% https://uk.mathworks.com/help/mpc/examples/control-of-a-single-input-single-output-plant.html
% -------------------------------------------------------------------------
 
clear; close all;

%% Simulation parameters
simu.start_time = 0;
simu.end_time = 10;
simu.samlping_time = 0.01;


%% system dynamic model define
a = 2.0;
plant = tf([2 3],[a 5 1]);

Ts = 0.1;

% inputs
Ts_r = 0.01;
t = [0:Ts_r:100]';

ref = zeros(numel(t), 1);
%ref(200:end) = ref(200:end) + 1;
%ref(400:end) = ref(400:end) + 1;
%ref(600:end) = ref(600:end) + 1;
%ref(800:end) = ref(800:end) + 2;

ref_input.time = t;
ref_input.signals.values = [ref];
ref_input.signals.dimensions = 1;

noise = randn(numel(t), 1);
noise_input.time = t;
noise_input.signals.values = [0.01 .* noise];
noise_input.signals.dimensions = 1;

sim('disturbance_generator');
d_input.time = t;
d_input.signals.values = [10 .* d.data];
d_input.signals.dimensions = 1;


%% MPC controller
p = 20;
m = 5;
mpcobj = mpc(plant, Ts, p, m);


%% constraints
mpcobj.MV = struct('Min',-10,'Max',10);

mdl = 'mpc_simulink_with_r_and_d';
open_system(mdl);
sim(mdl);


%% output error
cost = sum((0 - y) .^ 2 * Ts);
fprintf('State cost: %f \r\n', cost)
