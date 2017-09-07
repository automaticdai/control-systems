% -------------------------------------------------------------------------
% parameter_uncertainty.m
% Exploring the consequence of uncertainties in the system model. 
% Xiaotian Dai, 2017
% -------------------------------------------------------------------------

close all;

%% Define Transfer Functions
% G(s)
% 3 / (s^2 + s + 4)
Gs = tf([3],[1 1 4]);

% H(s)
% 3.2 / (s^2 + s + 3.8)
Hs = tf([3.2],[1 1 3.8]);


%% Simulate the system
SAMPLING_TIME = 0.1;
t = 0:SAMPLING_TIME:10;
t = t';
u = ones(numel(t),1);

[y1, t1, x1] = lsim(Gs,u,t);
[y2, t2, x2] = lsim(Hs,u,t);


%% Analyze
f = figure();

plot(t1, y1);
hold on;
plot(t2, y2);

legend('Model','Actual');


%% FFT
n = 512;
y = fft(y1, n);
m = abs(y);
p = unwrap(angle(y));
f = (0:length(y)-1)*100/length(y);

subplot(2,1,1)
plot(f,m)
title('Magnitude')
ax = gca;
ax.XTick = [15 40 60 85];

subplot(2,1,2)
plot(f,p*180/pi)
title('Phase')
ax = gca;
ax.XTick = [15 40 60 85];
