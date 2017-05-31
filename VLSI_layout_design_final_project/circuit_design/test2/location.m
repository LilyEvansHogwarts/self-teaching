function d = location(num)
L = create_laplacian_matrix(num);
%cut = initialize_cut(num,percent);
%vertex = initialize_vertex(L,cut,num);
[V,D] = eig(L);
cut_cost = zeros(1,num);
for i = 1:num
    u = sign(V(:,i));
    cut_cost(1,i) = u' * L * u;
end
%x = 1:num;
[ymin,d] = min(cut_cost(1,2:num));
%ymax = max(cut_cost);
%plot(x,cut_cost);
%axis([2,num,ymin,ymax]);
