function y = connected_cells(k,cell,net)
[i,j,s] = find(sparse(cell(k,:)));
x = net(s,:)';
y = sum(x .* (x ~= k));
