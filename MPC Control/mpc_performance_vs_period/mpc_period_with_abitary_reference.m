% -------------------------------------------------------------------------
% mpc_exp.m
% Explore MPC performance with period.
% Author: Xiaotian Dai
% https://uk.mathworks.com/help/mpc/examples/control-of-a-single-input-single-output-plant.html
% -------------------------------------------------------------------------
 
clear; close all;

addpath('../../Toolbox/')

%% Simulation parameters
simu.time = 20.0;
simu.samlping_time = 0.001;


%% system dynamic model define
tau = 2.0;
plant = tf([10],[tau 1]);
plant_ref = tf([10],[tau 1]);

mpc_param.Ts = 1.0;

% inputs
t = [0:simu.samlping_time:simu.time]';

ref = (square((t * 2 * pi) / 5) + 1) ./ 2; % period = ? s
%ref(200:end) = ref(200:end) - 1;
%ref(400:end) = ref(400:end) + 1;
%ref(600:end) = ref(600:end) - 1;
%ref(800:end) = ref(800:end) + 1;
ref = ones(numel(t), 1);
ref_input.time = t;
ref_input.signals.values = [ref];
ref_input.signals.dimensions = 1;

noise = 0.01 .* randn(numel(t), 1);
noise_input.time = t;
noise_input.signals.values = [noise];
noise_input.signals.dimensions = 1;

sim('disturbance_generator');
d_input.time = t;
d_input.signals.values = [d.data];
d_input.signals.dimensions = 1;


%% MPC controller
mpc_param.p = 10;
mpc_param.m = 3;
mpcobj = mpc(plant_ref, mpc_param.Ts, mpc_param.p, mpc_param.m);


%% constraints
mpcobj.MV = struct('Min', -10, 'Max', 10);

mdl = 'mpc_simulink_with_r_and_d';
open_system(mdl);
sim(mdl);

filename = sprintf('Ts_%0.2f.mat', mpc_param.Ts);
save(filename, 'plant', 'mpcobj', 't', 'ref', 'y', 'u');

%% output error
state_cost = compute_quadratic_control_cost(ref - y, 0, simu.samlping_time, 1, 0, 0);
control_cost = compute_quadratic_control_cost(0, u, simu.samlping_time, 0, 0, 1);
fprintf('State cost: %f \r\n', state_cost);
fprintf('Control cost: %f \r\n', control_cost);

rmpath('../../Toolbox/')