%% 本程序可以用来证明当cut每个元素符号与特征值较小的特征向量一致时，对应的cut会是比较小的值

function a = my_approach(num,percent,L)
[V,D] = eig(L);
v = V(:,2);
u = sign(v);
if abs(sum(u)) < percent * num
    a = u' * L * u / 4;
else
    if sum(u) > 0
        size = (sum(u) - percent * num) / 2;
        [k,p] = sort(relu(v));
        start = num - sum(v > 0);
        for i = 1:size
            u(p(start + i)) = u(p(start + i)) * (-1);
        end
        a = u' * L * u / 4;
    else
        size = (- sum(u) - percent * num) / 2;
        [k,p] = sort(relu(-v));
        start = num - sum(v < 0);
        for i = 1:size
            u(p(start + i)) = u(p(start + i)) * (-1);
        end
        a = u' * L * u / 4;
    end
end
        





