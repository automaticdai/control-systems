% -------------------------------------------------------------------------
% mpc_exp.m
% Explore MPC performance with period.
% Author: Xiaotian Dai
% https://uk.mathworks.com/help/mpc/examples/control-of-a-single-input-single-output-plant.html
% -------------------------------------------------------------------------

clear; close all;

%% Parameters
% system dynamic model define
a = 2.0;
plant = tf([2 3],[a 5 1]);

% period define
u_upper = 1;
u_lower = 0.01;
u_step = 0.2;
u = u_lower:u_step:u_upper;

c = 0.01;
h = c ./ u;

u_array = [];
cost_array = [];

% MPC
mpc_p = 10;
mpc_m = 3;

%% loop periods
for Ts = h

% define a MPC controller object
mpcobj = mpc(plant, Ts, mpc_p, mpc_m);


% constraints
mpcobj.MV = struct('Min',-1,'Max',1);

mdl = 'mpc_simulink';
open_system(mdl);
sim(mdl);


% output error
cost = sum((1 - y) .^ 2 * Ts);
fprintf('State cost: %f \r\n', cost)

u_array = [u_array 0.01 / Ts];
cost_array = [cost_array cost];

end

%% plot result
scatter(u_array, cost_array);

filename = sprintf('%0.1f_data.mat', a);
save(filename, 'a', 'u_array', 'cost_array');