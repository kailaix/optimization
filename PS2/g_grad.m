function dg = g_grad(B,X,y)
% B -- 10*n --> n by 10
% X -- m * n
% y -- m, take values 1,2,3,..., 10

[m,n] = size(X);
B = reshape(B,n,10);
dg = zeros(n,10);

for l=1:10
    for i=1:m
        Z = 0;
        for k=1:10
            Z = Z + exp(X(i,:)*B(:,k));
        end
        ind = (y(i)==l);
        dg(:,l) = dg(:,l) + exp(X(i,:)*B(:,l))*X(i,:)'/Z - X(i,:)'*ind;
    end
end

dg = reshape(dg,10*n,1);
