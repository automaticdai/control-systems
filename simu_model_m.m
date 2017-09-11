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
