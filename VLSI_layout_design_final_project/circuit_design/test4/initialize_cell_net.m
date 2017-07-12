function [cell,net] = initialize_cell_net(L,num)
[i,j] = find(sparse(tril(L) - L));
net = [i,j];
shape = size(net);
s = 1:shape(1,1); %%%s为边对应的标号
P = full(sparse(i,j,s',num,num));
P = P + P';
cell = zeros(num,max(diag(L)));
for k = 1:num
	[i,j,s] = find(sparse(P(k,:)));
	shape = size(s);
	cell(k,1:shape(1,2)) = s;
end

