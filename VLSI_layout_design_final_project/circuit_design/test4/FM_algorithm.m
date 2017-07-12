function best_gain = FM_algorithm(L,num,percent,num_pass,num_cut)
[cell,net] = initialize_cell_net(L,num);
best_gain_list = zeros(num_cut,1);
for i = 1:num_cut
	cut = initialize_cut(num,percent);
	for j = 1:num_pass
	    [cell_gain,p,length,bucket,lock] = initialize_bucket(cut,cell,net,L,num);
		[gain_list,cut_list] = pass(cell_gain,cut,p,length,bucket,lock,num,percent,cell,net,L)
		[best_gain,b] = min(gain_list);
		cut = cut_list(:,b);
	end
	best_gain_list(i,1) = best_gain;
end
best_gain = min(best_gain_list);
