% -------------------------------------------------------------------------
% mpc_period_with_abitary_reference.m
% Explore MPC performance with period.
% Author: Xiaotian Dai
% https://uk.mathworks.com/help/mpc/examples/control-of-a-single-input-single-output-plant.html
% -------------------------------------------------------------------------
 
clear; close all;

addpath('../../Toolbox/')

%% Simulation parameters
simu.time = 10000.0;
simu.samlping_time = 0.01;


%% System dynamic model define
% period should be 5% - 10% of the rising time (settling time for 1st order systems)
% settling time = 4 * tau
tau = 2.0;
plant = tf([10],[tau 1]);

mpc_param.plant_ref = plant;
mpc_param.Ts = 0.80;

% inputs
t = [0:simu.samlping_time:simu.time]';

rng(1);ref_sequence = randi(5, 1, 50) - 1;
ref_sampling_time = 3.78;
sim('reference_generator');
%ref = (square((t * 2 * pi) / 5) + 1) ./ 2; % period = ? s

%ref(200:end) = ref(200:end) - 1;
%ref(400:end) = ref(400:end) + 1;
%ref(600:end) = ref(600:end) - 1;
%ref(800:end) = ref(800:end) + 1;
%ref = ones(numel(t), 1);

ref = ref.data;
ref_input.time = t;
ref_input.signals.values = [ref];
ref_input.signals.dimensions = 1;

noise = 0.01 .* randn(numel(t), 1);
noise_input.time = t;
noise_input.signals.values = [1.0 .* noise];
noise_input.signals.dimensions = 1;

sim('disturbance_generator');
d_input.time = t;
d_input.signals.values = [0 .* d.data];
d_input.signals.dimensions = 1;


%% MPC controller
mpc_param.p = 10;
mpc_param.m = 3;
mpcobj = mpc(mpc_param.plant_ref, mpc_param.Ts, mpc_param.p, mpc_param.m);


%% constraints
mpcobj.MV = struct('Min', -10, 'Max', 10);

mdl = 'mpc_period_with_r_and_d_simulink';
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