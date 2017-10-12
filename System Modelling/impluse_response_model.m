% impluse_response_model.m
% Impulse Response Model
% Author: Xiaotian Dai
% University of York
% Note: Impulse response model is the model when u(t) is an impluse function
% \delta(t).

sys = tf([1 1],[1 2 1]);
[y1, t1, x1] = impulse(sys);
scatter(t1,y1);