function vertex = initialize_vertex(L,cut,num)
[i,j,s] = find(sparse(diag(diag(L)) - L));
shape = size(i);
num = size(L);

%%vertex = (external-internal, external, internal, region, flag)
vertex = zeros(num(1,1), 5);

for k = 1:shape(1,1)
    if cut(i(k)) * cut(j(k)) < 0
        vertex(i(k),2) = vertex(i(k),2) + s(k);
        vertex(j(k),2) = vertex(j(k),2) + s(k);
    else
        vertex(i(k),3) = vertex(i(k),3) + s(k);
        vertex(j(k),3) = vertex(j(k),3) + s(k);
    end
end

for j = 1:num(1,1)
    vertex(j,1) = vertex(j,2) - vertex(j,3);
end  

vertex(:,4) = cut;
vertex(:,5) = ones(num(1,1),1);