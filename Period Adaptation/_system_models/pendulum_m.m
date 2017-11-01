% linear and nonlinear models
M = 0.380;                  % mass of the pendulum bob (kg)
m = 0.095;                  % mass of the pendulum rod (kg)
l = 0.43;                   % length of the pendulum rod (m)
lG = (M*l+0.5*m*l)/(M+m);   % location of pendulum mass center (m)
IO = 0.079;                 % estimate of pendulum mass moment of inertia (kg-m^2)
b = 0.053;                  % estimate of viscous friction coefficient (N-m-s) 0.003
theta_ic = 0.823;           % initial pendulum angular position (rad) 
theta_dot_ic = 0;           % initial pendulum angular velocity (rad/s)
g = 9.81;                   % acceleration due to gravity (m/s^2)


% 
%  plot(time+1.9,theta_lin*180/pi,'b:');
%  hold on;
%  plot(time+1.9,theta_nl*180/pi,'r--');
%  xlabel('time (seconds)')
%  ylabel('angle (degrees)')
%  title('Pendulum Free Response')
%  legend('linear sim','nonlinear sim')
%  
%  
%  close all;

theta_ic = 0.823;           % initial pendulum angular position (rad) 0.003
theta_dot_ic = 0;           % initial pendulum angular velocity (rad/s)

sim('pendulumSIM')

f = figure();
axis([-1,1,-1,1]);

hold on;
theta_lin_dot = diff(theta_lin);

for i = 1:length(theta_lin_dot)
    scatter(theta_lin(i + 1), theta_lin_dot(i), 'bx');
    
    pause(0.1);
end
hold on;

