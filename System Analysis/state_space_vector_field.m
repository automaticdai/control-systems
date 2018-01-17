% system model
plant = zpk(-10, [-10 + 20i, -10 - 20i], 1);
plant = tf(plant);

% convert to state space model
[A, B, C, D] =  tf2ss(plant.num{1},plant.den{1});
plant_ss = ss(A, B, C, D);

% calculate vector field
[x1, x2] = meshgrid(-20:1:20, -10:1:10);

x1dot = - 2 * x1 - 5 * x2;
x2dot = x1;

figure
quiver(x1, x2, x1dot, x2dot)


% [x1, x2] = meshgrid(-.5:0.05:0.5, -.5:.05:.5);
% x1dot = - x1; 
% x2dot = 2*x2;
% quiver(x1,x2,x1dot,x2dot)
% hold on
% starty = -0.5:0.05:0.5;
% startx = ones(size(starty))*-0.5; %specify the starting x values- LHS
% streamline(x1,x2,x1dot,x2dot, startx,starty)
% startx_2 = ones(size(starty))*0.5; %specify the starting x values -RHS
% streamline(x1,x2,x1dot,x2dot, startx_2,starty);