% -------------------------------------------------------------------------
% mpc_exp.m
% Author: Xiaotian Dai
% https://uk.mathworks.com/help/mpc/examples/control-of-a-single-input-single-output-plant.html
% -------------------------------------------------------------------------

%% system dynamic model define
plant = tf(1,[3 1 1]);


%% MPC controller
Ts = 0.1;
p = 10;
m = 3;
mpcobj = mpc(plant, Ts, p, m);


%% constraints
mpcobj.MV = struct('Min',-1,'Max',1);

mdl = 'mpc_simulink';
open_system(mdl);
sim(mdl);
