% -------------------------------------------------------------------------
% mpc_exp.m
% Explore MPC performance with period.
% Author: Xiaotian Dai
% https://uk.mathworks.com/help/mpc/examples/control-of-a-single-input-single-output-plant.html
% -------------------------------------------------------------------------

%% 
clear; close all;

%% system dynamic model define
a = 2.0;
plant = tf([2 3],[a 5 1]);

Ts = 0.01;
ref_input.time = [0:10];
ref_input.signals.values = [0:10];


t = [0:0.1:10]';
x = mod(0:100, 2)';
ref_input.time = t;
ref_input.signals.values = [x];
ref_input.signals.dimensions = 1;

%% MPC controller
p = 10;
m = 3;
mpcobj = mpc(plant, Ts, p, m);


%% constraints
mpcobj.MV = struct('Min',-1,'Max',1);

mdl = 'mpc_simulink_with_reference';
open_system(mdl);
sim(mdl);


%% output error
cost = sum((1 - y) .^ 2 * Ts);
fprintf('State cost: %f \r\n', cost)


