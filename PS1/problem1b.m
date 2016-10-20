clear;clc;
y = urlread('http://www.stat.cmu.edu/~ryantibs/convexopt-F15/homework/y.txt');
y = textscan(y,'%f');
y = y{1};

beta0 = urlread('http://www.stat.cmu.edu/~ryantibs/convexopt-F15/homework/beta0.txt');
beta0 = textscan(beta0,'%f');
beta0 = beta0{1};

n = length(y);
cvx_begin
    variable beta1(n)
    expression d_beta(n-1)
    for i=1:n-1
        d_beta(i) = beta1(i) - beta1(i+1);
    end
    minimize( 1/2 * sum( (y-beta1).^2 ) + norm(d_beta, 1 ))
cvx_end


cvx_optval
cvx_status
