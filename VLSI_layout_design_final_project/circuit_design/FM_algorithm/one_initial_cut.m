function [best_gain,cut] = one_initial_cut(L,cut,num,percent,num_pass)
for i = 1:num_pass
	vertex = initialize_vertex(L,cut,num);
	[length,bucket] = initialize_bucket(vertex,num);
	[cut_documentary,gain] = pass(L,vertex,length,bucket,num,percent);
	[a,b] = min(gain);
	cut = cut_documentary(:,b);
	best_gain = a;
end

