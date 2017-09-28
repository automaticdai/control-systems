% -------------------------------------------------------------------------
% sysid_system_generate_m.m
% Author: Xiaotian Dai, University of York
% Version: v1.0, 2017/09/28
% -------------------------------------------------------------------------

% define the ground truth system and sampling period
Gs = tf([3],[1 3 4]);
%Gs = tf([1],[1 3 4]);
h = 0.1;

% simulate the system
sim('sysid_system_generate')

% save simulation result to a iddata class
z1 = iddata(output.data, input.data, h);

% plot and save to file
plot(z1)
save('z1', 'z1', 'Gs');
