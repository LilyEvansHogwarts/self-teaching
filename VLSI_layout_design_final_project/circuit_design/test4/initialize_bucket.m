function [cell_gain,p,length,bucket,lock] = initialize_bucket(cut,cell,net,L,num)
cell_gain = zeros(num,3); %%%gain, external, internal
length = zeros(2 * num + 1,2);
p = zeros(1,2);
bucket = zeros(num * 2 + 1, num,2);
lock = zeros(num,1);
for k = 1:num
	s = connected_cells(k,cell,net);
	x = cut(s,1) * cut(k,1);
	cell_gain(k,2) = sum(x < 0); %%%external
	cell_gain(k,3) = sum(x > 0); %%%internal
	cell_gain(k,1) = cell_gain(k,2) - cell_gain(k,3); %%%gain
	if cut(k,1) > 0
		c = 1;
	else
		c = 2;
	end
	start = num + 1; %%%由于matlab自身的标号限制，进行坐标平移
	location = cell_gain(k,1) + start;
	length(location,c) = length(location,c) + 1;
	bucket(location, length(location,c), c) = k;
	if location > p(1,c)
		p(1,c) = location;
	end
end
