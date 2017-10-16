% -------------------------------------------------------------------------
% mpc_exp.m
% Explore MPC performance with period.
% Author: Xiaotian Dai
% https://uk.mathworks.com/help/mpc/examples/control-of-a-single-input-single-output-plant.html
% -------------------------------------------------------------------------

clear; close all;

addpath('../../Toolbox/')


%% Parameters
% system dynamic model define
a = 2.0;
plant = tf([2 3],[a 5 1]);

% period define
u_upper = 1;
u_lower = 0.01;
u_step = 0.01;
u = u_lower:u_step:u_upper;

task_param.ci = 0.01;
%hi_array = task_param.ci ./ u;

%(!)
hi_array = 0.01:0.1:1.00;

h_array = [];
state_cost_array = [];
control_cost_array = [];

% MPC
mpc_param.p = 10;
mpc_param.m = 3;


%% loop periods
for Ts = hi_array

% define a MPC controller object
mpcobj = mpc(plant, Ts, mpc_param.p, mpc_param.m);


% constraints
mpcobj.MV = struct('Min', -10, 'Max', 10);

mdl = 'mpc_simulink';
open_system(mdl);
sim(mdl);


% output error
state_cost = compute_quadratic_control_cost(y, 0, Ts, 1, 0, 0);
control_cost = compute_quadratic_control_cost(0, u, Ts, 0, 0, 1);
fprintf('State cost: %f \r\n', state_cost);

h_array = [h_array Ts];
state_cost_array = [state_cost_array state_cost];
control_cost_array = [control_cost_array control_cost];
end


%% plot result
subplot(2, 1, 1)
scatter(h_array, state_cost_array);

subplot(2, 1, 2)
scatter(h_array, control_cost_array);

filename = sprintf('a_%0.1f_data.mat', a);
save(filename, 'plant', 'mpcobj', 'h_array', 'state_cost_array', 'control_cost_array');

rmpath('../../Toolbox/')