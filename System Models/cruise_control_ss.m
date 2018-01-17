% Model: Cruise Control
% Input: F
% Output: Velocity

m = 100;
b = 50;

A = -b/m;
B = 1/m;
C = 1;
D = 0;

sys_ss = ss(A,B,C,D);
sys_tf = tf(cruise_ss);
