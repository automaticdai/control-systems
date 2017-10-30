% test2.m
% Xiaotian Dai
% University of York
% Segmented reference signals and find corresponding steady-state time.
% Use with `mpc_period_with_abitary_reference.m`

addpath('../../Toolbox/')

% iter 1
r_end = 0;

while true
r_start = r_end + 1
r_head = ref(r_start);
idx = (r_head == ref(r_start:end));
r_end = (r_start - 1) + find(~idx, 1) - 1;

if (isempty(r_end))
    break
end


subplot(2,1,1)
plot(r_start:r_end, y(r_start:r_end)); hold on;

subplot(2,1,2)
plot(r_start:r_end, ref(r_start:r_end)); hold on;

compute_steady_state_time(y(r_start:r_end), t(r_start:r_end), ref(r_start), 0.5)
end