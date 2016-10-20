function N = find_change_point(beta1)

n = length(beta1);
N = 0;
for i=1:n-1
    if abs(beta1(i)-beta1(i+1))>1e-8
        N = N+1;
    end
end

