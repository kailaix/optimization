function [ERR,X] = cluster(y,gamma)
% y-- n by 2
% w-- e by 1
% X-- n by 2
% Z -- e by 2

ITERS = 100000;
ERR = zeros(ITERS,1);
iter = 1;
n = 20;
E = n*(n-1)/2;


% index
k = 1;
ind2edge = zeros(E);
edge2ind = zeros(E,2);

for i=1:n
    for j=i+1:n
        ind2edge(i,j) = k;
        edge2ind(k,:) = [i,j];
        k=k+1;
    end
end

ind2edge = ind2edge + ind2edge';


% initialize
X = zeros(n,2);
Z = zeros(E,2);
U = zeros(E,2);
rho = 0.01;

w = zeros(E,1);
for k=1:E
    ind = edge2ind(k,:);
    w(k) = exp(-gamma*norm(y(ind(1),:)-y(ind(2),:))^2);
end
flag = 1;

% iterate
while flag
    min_step1();
    min_step2();
    U = U + D_func(X) - Z;
    stop();
end

    function min_step1()
        % X1
        A = zeros(n);
        b = zeros(n,1);
        for k=1:n
            A(k,k) = 1+rho*n;
            A(k,:) = A(k,:) - rho;
            s1=0;
            for j=1:n
                if j==k
                    continue;
                end
                s1 = s1+sfunc(k,j)*(Z(ind2edge(k,j),1)-U(ind2edge(k,j),1));
            end
            b(k) = y(k,1) + rho*s1;
           
        end
        X1 = A\b;
        
        % X2
        A = zeros(n);
        b = zeros(n,1);
        for k=1:n
            A(k,k) = 1+rho*n;
            A(k,:) = A(k,:) - rho;
            s1=0;
            for j=1:n
                if k==j
                    continue;
                end
                s1 = s1+sfunc(k,j)*(Z(ind2edge(k,j),2)-U(ind2edge(k,j),2));
            end
            b(k) = y(k,2) + rho*s1;
            
        end
        X2 = A\b;
        X = [X1,X2];
        
    end

    function min_step2()
        for e=1:E
            ind = edge2ind(e,:);
            k = ind(1);
            l = ind(2);
            t1 = rho*sfunc(k,l)*(X(k,1)-X(l,1))-rho*U(e,1);
            t2 = rho*sfunc(k,l)*(X(k,2)-X(l,2))-rho*U(e,2);
            z_norm = (-w(e)+sqrt(t1^2+t2^2))/rho;
            z1 = -t1/(w(e)/z_norm+rho);
            z2 = -t2/(w(e)/z_norm+rho);
            Z(e,:) = [z1 z2];
        end
    end

    function L = D_func(X)
        L = zeros(E,2);
        for e=1:E
            ind = edge2ind(e,:);
            i = ind(1);
            j = ind(2);
            s = sfunc(i,j);
            L(e,:) = s*(X(i,:)-X(j,:));
        end
    end
        
        

    function sgn = sfunc(i,j)
        if i>j
            sgn = 1;
        elseif i<=j
            sgn = -1;
        end
    end

    function stop()
        e1 = norm(D_func(X)-Z,'fro');
        ERR(iter) = e1;
        if iter>ITERS
            flag = 0;
            return
        end
        if e1<1e-5
            ERR = ERR(1:iter);
            flag = 0;
            return
        end
        iter = iter+1;
        fprintf('#%d : %f\n',iter,e1);
        
%         disp(e1)
%         pause
    end
    
        



        

end



