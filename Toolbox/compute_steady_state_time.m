function [ Ts ] = compute_steady_state_time(y, t, ref, tolerance_prec)
% Input: @system response, @time sequence, @reference, 
%        @percentage of tolerance in the steady-state
% Output:@steady-state time
ref_lower = ref - ref * tolerance_prec;
ref_upper = ref + ref * tolerance_prec;

idx = ((y > ref_lower) & (y < ref_upper));
Ts_idx = find(~idx, 1, 'last') + 1;

if (Ts_idx > numel(y))
    Ts = -1;
else
    Ts = t(Ts_idx) - t(1);
end

end
