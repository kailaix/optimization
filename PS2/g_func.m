function gval = g_func(B,X,y)
% B -- 10*n --> n by 10
% X -- m * n
% y -- m, take values 1,2,3,..., 10

[m,n] = size(X);
B = reshape(B,n,10);
gval = 0;

for i=1:m
    s = 0;
    for k=1:10
        s = s + exp( X(i,:)*B(:,k) );
    end
    gval = gval + log(s);
    gval = gval - X(i,:)*B(:,y(i));
end

