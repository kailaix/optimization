lambdas = logspace(1, -2, 100);
m = length(lambdas);
MSE = zeros(m,1);
chg_pts = zeros(m,1);

y = urlread('http://www.stat.cmu.edu/~ryantibs/convexopt-F15/homework/y.txt');
y = textscan(y,'%f');
y = y{1};
n = length(y);

beta0 = urlread('http://www.stat.cmu.edu/~ryantibs/convexopt-F15/homework/beta0.txt');
beta0 = textscan(beta0,'%f');
beta0 = beta0{1};

for i=1:m
    fprintf('%d out of %d\n',i,m)
    l = lambdas(i);
    
    cvx_begin quiet
        variable beta1(n)
        expression d_beta(n-1)
        for j=1:n-1
            d_beta(j) = beta1(j) - beta1(j+1);
        end
        minimize( 1/2 * sum( (y-beta1).^2 ) + l*norm(d_beta, 1 ))
    cvx_end
    
    chg_pts(i) = find_change_point(beta1);
    MSE(i) = norm(beta1 - beta0);
    
    fprintf('lambda = %f, chang_points = %d, MSE = %f\n', l, chg_pts(i), MSE(i))
    
end

save('data.mat','lambdas','MSE','chg_pts','beta1');

% load data.mat
% semilogx(lambdas,MSE)
% title('MSE')
% 
% figure(2)
% semilogx(lambdas,chg_pts)
% title('change points')
