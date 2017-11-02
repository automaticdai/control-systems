%% quiver
[x,y] = meshgrid(-2:0.2:2,-2:0.2:2);
u = -1.*x;
v = -1.*y;

figure
quiver(x,y,u,v)


%% vectorline
syms x y 
F = [-y, x]; 
vectline(F,[x,y],[-1,1,-1,1])


%% streamslice
load wind

figure
streamslice(x,y,z,u,v,w,[],[],[5])
axis tight