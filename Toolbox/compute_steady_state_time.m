function [ Ts ] = compute_steady_state_time(y, t, ref, tolerance_prec)
% Input: @system response, @time sequence, @reference, 
%        @percentage of tolerance in the steady-state
% Output:@steady-state time
ref_lower = ref - ref * tolerance_prec
ref_upper = ref + ref * tolerance_prec

idx = ((y > ref_lower) & (y < ref_upper))
t(idx)

end
