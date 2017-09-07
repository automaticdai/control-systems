% -------------------------------------------------------------------------
% cruise_control_lq.m
% LQ control of a cruise control system
% Xiaotian Dai, 2017
% Credit: Model from 'Control Tutorial - Cruise Control: System Modeling' 
% (accessed at: http://ctms.engin.umich.edu/CTMS/index.php?example=CruiseControl&section=SystemModeling)
% -------------------------------------------------------------------------
close all;

m = 1000;
b = 50;

s = tf('s');
cruise_tf = 1/(m*s+b);


A = -b/m;
B = 1/m;
C = 1;
D = 0;

cruise_ss = ss(A,B,C,D);

cruise_cl = feedback(cruise_ss, 1);

% generate step response
figure()
step(cruise_ss)

figure()
step(cruise_cl)


