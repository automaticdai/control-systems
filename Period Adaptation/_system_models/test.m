m = 1000;
b = 50;

A = -b/m;
B = 1/m;
C = 1;
D = 0;


Ts = 0.001;

cruise_ss = ss(A,B,C,D,Ts);

% controller
Kp = 80;
Ki = 20;
Kd = 0;
C = pid(Kp,Ki,0,0,Ts);

T = feedback(C*cruise_ss,1);

[y, t] = step(T, 100);
plot(t,y)





