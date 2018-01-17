close all;
rng default  % For reproducibility

pd = makedist('Normal','mu',65,'sigma',10);

x = random(pd,10000,1);
figure()
histogram(x,100)

pd = makedist('Normal','mu',72,'sigma',10);
y = random(pd,5000,1);
hold on
histogram(y,100)

% generate empirical CDF
[Fi,xi] = ecdf(x);

figure()
stairs(xi,Fi,'r');
%xlim([0 5]); xlabel('x'); ylabel('F(x)');

hold on;
[Fi,xi] = ecdf(y);
stairs(xi,Fi,'r');
%xlim([0 5]); xlabel('x'); ylabel('F(x)');

% K-S test
[h,p,ks2stat] = kstest2(x,y)

% make pairwise comparison
% meshgrid(x,g);

figure()
g = pairwise_compute(y, x);
histogram(g, 100);


