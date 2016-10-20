function err = PGM(X,y,l,t,max_iter,fstar)
% B -- 10*n --> n by 10
% X -- m * n
% y -- m, take values 1,2,3,..., 10
% l -- lambda parameter
% t -- t in proximal mapping
% max_iter -- max iterations
% fstar -- exact function

[~,N] = size(X);
B = rand(10*N,1);

err = zeros(max_iter,1);

for n = 1:max_iter
    gd = B - t*g_grad(B,X,y);
    B = prox(gd,l,t);
    err(n) = norm(g_func(B,X,y)+l*norm(B,1) - fstar); % only for lambda=1
    fprintf('#%d\n error=%f\n',n,err(n))
end

