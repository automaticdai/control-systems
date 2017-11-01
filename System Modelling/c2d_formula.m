Ts = 0.1;

%% test of tustin method
Kp = 5;
Ki = 7;
Kd = 8;

Gc = tf(pid(Kp, Ki, Kd));
Gc_d = c2d(Gc, Ts, 'tustin')
 
%formula of c2d (tustin):
num = [Kp+(Ki*Ts/2)+((2*Kd)/Ts)
(Ki*Ts)-(4*(Kd/Ts))
-Kp+(Ki*Ts/2)+((2*Kd)/Ts)]';
den = [1 0 -1];
C = tf(num, den, Ts)


%% test of discretize method
% first discretize or last discretize?
% Conclusion: different tf, similar characteristics!
Gs = tf([1],[1 1]);
Gcs = tf([1 3],[1]);
Hs = feedback(Gs * Gcs, 1);
Hs2z = c2d(Hs, Ts, 'tustin');

Gz = c2d(Gs, Ts, 'tustin');
Gcz = c2d(Gcs, Ts, 'tustin');
Hz = feedback(Gz * Gcz, 1);
