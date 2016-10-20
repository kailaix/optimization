clear;clc
n = 100;
m = 10;
X = randn(n,m);
y = randn(n,1);
beta = zeros(m,1);
cvx_begin quiet
    variable beta(m)
    minimize( norm( y - X*beta ) )
cvx_end

b = X \ y;

beta;
norm(beta - b)
cvx_optval
cvx_status


