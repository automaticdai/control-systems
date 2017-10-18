% -------------------------------------------------------------------------
% mpc_exp.m
% Explore MPC performance v.s. period.
% Author: Xiaotian Dai
% https://uk.mathworks.com/help/mpc/examples/control-of-a-single-input-single-output-plant.html
% -------------------------------------------------------------------------

clear; close all;

addpath('../../Toolbox/')


%% Parameters
% system dynamic model define
a = 2.0;
plant = tf([3],[a 1]);

simu.samlping_time = 0.01;

% task period define
task_param.hi_array = 0.01:0.01:1.00;
task_param.ci = 0.01;

h_array = [];
state_cost_array = [];
control_cost_array = [];

% MPC
mpc_param.p = 10;
mpc_param.m = 3;


%% loop periods
for Ts = task_param.hi_array

% define a MPC controller object
mpcobj = mpc(plant, Ts, mpc_param.p, mpc_param.m);

% constraints
mpcobj.MV = struct('Min', -10, 'Max', 10);

mdl = 'mpc_simulink';
open_system(mdl);
sim(mdl);


% output error
state_cost = compute_quadratic_control_cost(1 - y.data, 0, simu.samlping_time, 1, 0, 0);
control_cost = compute_quadratic_control_cost(0, u.data, simu.samlping_time, 0, 0, 1);
fprintf('State cost: %f \r\n', state_cost);

h_array = [h_array Ts];
state_cost_array = [state_cost_array state_cost];
control_cost_array = [control_cost_array control_cost];

filename = sprintf('Ts_%0.2f_data.mat', Ts);
save(filename, 'Ts', 'y', 'u');

end


%% plot result
subplot(2, 1, 1)
scatter(h_array, state_cost_array);

subplot(2, 1, 2)
scatter(h_array, control_cost_array);

filename = sprintf('a_%0.1f_data.mat', a);
save(filename, 'plant', 'mpcobj', 'h_array', 'state_cost_array', 'control_cost_array');

rmpath('../../Toolbox/')