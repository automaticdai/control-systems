% File:    discrete_system_stability.m
% Author:  Xiaotian Dai, University of York
% Version: 2017/10/03
% Note:    Stability of a digital control system

% define sampling period
h = 0.1;

% open loop transfer function
Gs = tf([1],[1 2 1]);
Gs_ss = tf2ss(Gs.num{1}, Gs.den{1});
Gsz = c2d(Gs, h, 'tustin');

Gc = tf([1], [1 1]);
Gcz = c2d(Gc, h, 'tustin');

% closed loop transfer function
Cs = (Cs * Gs) / (1 + Cs * Gs);

pole(Hs)




step(Hs)

