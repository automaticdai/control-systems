% -------------------------------------------------------------------------
% cruise_control_lq.m
% LQR control of a cruise control system
% Xiaotian Dai, 2017
% Credit: Model from 'Control Tutorial - Cruise Control: System Modeling' 
% (accessed at: http://ctms.engin.umich.edu/CTMS/index.php?example=CruiseControl&section=SystemModeling)
% -------------------------------------------------------------------------

close all;

%% System Modelling 
% system parameters
m = 100;   % mass
b = 50;     % 
u = 500;    % input

% I. transfer function model
s = tf('s');
cruise_tf = 1 / (m*s+b);

% II. state-space model
A = -b/m;
B = 1/m;
C = 1;
D = 0;

% stability
% all of the poles are in the left-half plane,
poles = eig(A);

% controllability matrix
% For the system to be completely state controllable, the controllability
% matrix must have rank n. 
co = ctrb(A,B);
Controllability = rank(co);

% observability
% to be finished...

cruise_ss = ss(A,B,C,D);


%% LQR Controller Design
% LQR cost function: xQx + uRu + 2xNu
Q = 1000;
R = 0.1;
N = 0;

[K,S,e] = lqr(A, B, Q, R, N);
N_bar = (-1 * C * (A - B*K - 1)^(-1) * B) ^ (-1);
N_bar = rscale(A,B,C,D,K);

% control loop
cruise_cl = ss(A - B*K, B * N_bar, C, D);

% generate step response
x0 = [0];

subplot(2, 1, 1)
step(cruise_ss)

subplot(2, 1, 2)
step(cruise_cl)
