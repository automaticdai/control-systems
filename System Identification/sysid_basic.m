% -------------------------------------------------------------------------
% sysid_basic.m
% This experiment explores system identification methods in MATLAB
% Author: Xiaotian Dai, University of York
% Version: v1.0, 2017/09/28
% Notes:
% - ?non-parametric can only predict few steps further?
% -------------------------------------------------------------------------

% load data
load('z1')

%% System Identification
% Esimate a parametric model.
sys1 = ssest(z1, 2);

% Estimate a non-parametric (FIR) model.
sys2 = impulseest(z1);

% Estimate TF 2nd
sys3 = tfest(z1, 2);

% Estimate TF 3rd
sys4 = tfest(z1, 3);


%% Find step response
t = (0:0.1:10)';
[y0, ~, ~] = step(Gs,t);
[y1, ~, ~, ysd1] = step(sys1,t);
[y2, ~, ~, ysd2] = step(sys2,t);
[y3, ~, ~, ysd3] = step(sys3,t);
[y4, ~, ~, ysd4] = step(sys4,t);


%% Plot the step responses for comparision.
f = figure;

% original system
f0 = plot(t, y0, 'y');
hold on

% ssest
f1 = plot(t, y1, 'b', t, y1+3*ysd1, 'b:', t, y1-3*ysd1, 'b:');
hold on

% non-parametric (impulse)
f2 = plot(t, y2, 'g', t, y2+3*ysd2, 'g:', t, y2-3*ysd2, 'g:');
hold on

% tfest
f3 = plot(t, y3, 'r', t, y3+3*ysd3, 'r:', t, y3-3*ysd3, 'r:');
hold on

f4 = plot(t, y4, 'c', t, y4+3*ysd4, 'c:', t, y4-3*ysd4, 'c:');
hold on

legend([f0;f1(1);f2(1);f3(1);f4(1)], {'origin', 'ssest', 'impulseest', 'tfest-2', 'tfest-3'})
