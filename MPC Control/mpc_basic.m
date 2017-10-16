% -------------------------------------------------------------------------
% mpc_exp.m
% MPC control using Simulink MPC control toolbox.
% Author: Xiaotian Dai
% https://uk.mathworks.com/help/mpc/examples/control-of-a-single-input-single-output-plant.html
% -------------------------------------------------------------------------


%% system dynamic model define
plant = tf([2 3],[3 5 1]);


%% MPC controller
% Ts: sampling time
% p: Prediction horizon
% m: Control horizon
Ts = 0.015;
p = 10;
m = 3;
mpcobj = mpc(plant, Ts, p, m);


%% constraints
mpcobj.MV = struct('Min',-10,'Max',10);

mdl = 'mpc_simulink';
open_system(mdl);
sim(mdl);

