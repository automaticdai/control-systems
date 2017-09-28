% -------------------------------------------------------------------------
% cruise_control_lq.m
% LQR control of a cruise control system
% Xiaotian Dai, 2017
% Credit: Model from 'Control Tutorial - Cruise Control: System Modeling' 
% (accessed at: http://ctms.engin.umich.edu/CTMS/index.php?example=CruiseControl&section=SystemModeling)
% -------------------------------------------------------------------------

close all;

%% System Modelling 

m = 1000;
b = 50;
u = 500;

% transfer function
s = tf('s');
cruise_tf = 1/(m*s+b);

% state-space model
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
Q = 10;
R = 0.1;
N = 0;

[K,S,e] = lqr(A, B, Q, R, N);

% control loop
cruise_cl = ss(A - B*K, B, C, D);

% generate step response
x0 = [0];

subplot(2, 1, 1)
step(cruise_ss)

subplot(2, 1, 2)
step(cruise_cl)
