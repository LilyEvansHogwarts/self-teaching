function [cut_documentary, gain] = pass(L,vertex,length,bucket,num,percent)
cut_documentary = zeros(num,num);
gain = zeros(1,num);
for i = 1:num
	[vertex,length,bucket] = vertex_process(L,vertex,length,bucket,num,percent);
    cut_documentary(:,i) = vertex(:,4);
	gain(1,i) = vertex(:,4)' * L * vertex(:,4) / 4;
end
