function E = rand_admm(fs,gs,A,b,method)

% fs: n by 1 cell
% gs: n by 1 cell
% A0: cell of size n
% Each matrix: N by d(n)
% b: N by 1 vector

% Initialize
MAX_ITER = 4000;
n = length(fs);
N = length(b);
d = zeros(n,1);
X = cell(n,1);

for k=1:n
    d(k) = size(A{k},2);
    X{k} = rand(d(k),1);
end

mu = zeros(N,1);
rho = 0.01;

E = zeros(MAX_ITER,2);

% iterate

if method==1
    for iter=1:MAX_ITER
       sigma = randperm(n);
       for i = sigma
           primal_min(i);
       end
       mu_update();

       L_func();
    end
end


% PD-RADMM
if method==2
    for iter=1:MAX_ITER
        while(1)
            i = randi([1,n+1]);
            if i<=n
                primal_min(i);
            elseif i==n+1
                mu_update();
                L_func();
                break
            end
        end
    end
end


% P-RADMM
if method==3
    for iter=1:MAX_ITER
        l = randi([1,n],[n,1]);
        for i=1:n
            primal_min(l(i));
        end
        mu_update();
        L_func();
    end
end

% Raw
if method==4
    for iter=1:MAX_ITER
        for i=1:n
            primal_min(i);
        end
        mu_update();
        L_func();
    end
end

% Round
if method==5
    for iter=1:MAX_ITER
        for i=1:10
            for j=1:n
                primal_min(j);
            end
        end
        mu_update();
        L_func();
    end
end
        
    



    function primal_min(i)
        fi = fs{i};
        gi = gs{i};
        qsum = zeros(N,1);
        for k=1:n
            if k~=i
                qsum = qsum + A{k}*X{k};
            end
        end
        f_t = @(xi) qsum + A{i}*xi-b;
        f = @(xi) fi(xi) - dot( mu, f_t(xi) )+rho/2*...
            (f_t(xi)'*f_t(xi));
        g = @(xi) gi(xi) - A{i}'*mu + rho*A{i}'*f_t(xi);
        F = @(x)deal(f(x),g(x));
        options = optimoptions('fminunc','GradObj','on','Display','off',...
            'Algorithm','quasi-newton');
        X{i} = fminunc(F,X{i},options);
    end

    function mu_update()
        qsum = zeros(N,1);
        for k=1:n
           qsum = qsum + A{k}*X{k};
        end
        mu = mu - rho*(qsum-b);
    end

    function L_func()
%         F = 0;
%         for k=1:n
%             F = F + fs{i}(X{i});
%         end
        qsum = zeros(N,1);
        for k=1:n
           qsum = qsum + A{k}*X{k};
        end
        err = [X{1}-(-1) X{2}-1 X{3}-1];
        F = norm(err);
        L =  - dot(mu,qsum-b) + rho/2*norm(qsum-b,2);
        E(iter,:) = [F,L];
        
        if(F<1e-6)||(F>1e5)
            E = E(1:iter,:);
            return
        end
        fprintf('#%d,%f,%f\n',iter,E(iter,1),E(iter,2));
       
    end


end



