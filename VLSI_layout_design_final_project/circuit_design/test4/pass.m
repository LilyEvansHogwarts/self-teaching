function [gain_list,cut_list] = pass(cell_gain,cut,p,length,bucket,lock,num,percent,cell,net,L)
gain_list = zeros(num,1);
cut_list = zeros(num,num); 
for i = 1:num
	[cell_gain,cut,p,length,bucket,lock] = process(cell_gain,cut,p,length,bucket,lock,num,percent,cell,net);
	cut_list(:,i) = cut;
	gain_list(i,1) = cut' * L * cut / 4;
end
