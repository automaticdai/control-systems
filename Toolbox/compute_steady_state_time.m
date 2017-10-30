function [ Ts ] = compute_steady_state_time(y, t, ref, tolerance_prec)
% Inputs: y: system response
%         t: time sequence
%         ref: reference, 
%         tolerance_prec: percentage of tolerance in the steady-state
% Outputs:Ts: steady-state time

ref_lower = ref - ref * tolerance_prec;
ref_upper = ref + ref * tolerance_prec;

idx = ((y > ref_lower) & (y < ref_upper));
Ts_idx = find(~idx, 1, 'last') + 1;

if (isempty(Ts_idx))
    Ts = 0;
else if (Ts_idx > numel(y))
    Ts = -1;
else
    Ts = t(Ts_idx) - t(1);
end

end
