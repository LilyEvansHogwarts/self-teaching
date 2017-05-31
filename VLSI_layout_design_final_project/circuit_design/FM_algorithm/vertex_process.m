function [vertex,length,bucket] = vertex_process(L,vertex,length,bucket,num,percent)
[a,b] = max(vertex);
init = vertex(:,4);
init(b(1,1)) = init(b(1,1)) * (-1);
if abs(sum(init)) < percent * num && vertex(b(1,1),5) == 1
	[vertex,length,bucket] = process(L,init,vertex,length,bucket,num,percent,b(1,1));
else
	%from_location = vertex(b(1,1),1) + num + 1;
	vertex(b(1,1),1) = -num;
	[vertex,length,bucket] = vertex_process(L,vertex,length,bucket,num,percent);
	vertex(b(1,1),1) = vertex(b(1,1),2) - vertex(b(1,1),3);
end
