function p = prox(y,l,t)
% y -- 10*n

n = length(y);
p = zeros(n,1);
for i=1:n
    if y(i) > l*t
        p(i) = y(i) - l*t;
    elseif y(i) < -l*t
        p(i) = y(i) + l*t;
    else
        p(i) = 0;
    end
end
