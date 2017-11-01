close all;

Ts = 0.001;

cruise_ss_d = ss(A,B,C,D,Ts);
cruise_tf_d = tf(cruise_ss_d);

% controller
Kp = 5198;
Ki = 500 / Ts;
Kd = 100 * Ts;
Gc = tf(pid(Kp, Ki, Kd));
Gc_d = c2d(Gc, Ts, 'tustin');

T = feedback(Gc_d * cruise_tf_d, 1);

[y, t] = step(T,1);
figure
plot(t,y)

y_dot = diff(y);% / Ts;
figure


% for i = 1:length(y_dot)
%     scatter(y(i + 1), y_dot(i), 'r')
%     hold on
% end