% -------------------------------------------------------------------------
% mpc_exp.m
% Description: A basoc MPC controller using the Simulink MPC control toolbox.
% Author: Xiaotian Dai (C) 2017, University of York, UK
% https://uk.mathworks.com/help/mpc/examples/control-of-a-single-input-single-output-plant.html
% -------------------------------------------------------------------------

close all; clc; clear;

%% system dynamic model define
plant = tf([2 3],[3 5 1]);
simu.run_time = 5;
simu.sampling_time = 0.01;


%% MPC controller
% Ts: sampling time
% p: Prediction horizon
% m: Control horizon
Ts = 0.11;
p = 10;
m = 3;
mpcobj = mpc(plant, Ts, p, m);

% convert into a linear model when constraints are not active
sys = tf(mpcobj);


%% constraints
mpcobj.MV = struct('Min', -10, 'Max', 10, ...
                   'RateMin', -Inf, 'RateMax', Inf);
% mpcobj.Weights = ;

mdl = 'mpc_simulink';
open_system(mdl);
sim(mdl);

% plot results
subplot(2,1,1)
stairs(y.time, y.data)
title('Time - Output')

subplot(2,1,2)
stairs(u.time, u.data)
title('Time - Input')
