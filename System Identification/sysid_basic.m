% This experiment explores system identification method
% Xiaotian Dai
% University of York
load iddata1 z1

% Esimate a parametric model.
sys1 = ssest(z1,4);

% Estimate a non-parametric model.
sys2 = impulseest(z1);

% Plot the step responses for comparision.
t = (0:0.1:10)';
[y1, ~, ~, ysd1] = step(sys1,t);
[y2, ~, ~, ysd2] = step(sys2,t);
plot(t, y1, 'b', t, y1+3*ysd1, 'b:', t, y1-3*ysd1, 'b:')
hold on
plot(t, y2, 'g', t, y2+3*ysd2, 'g:', t, y2-3*ysd2, 'g:')

legend('parametric model', 'non-parametric model')
