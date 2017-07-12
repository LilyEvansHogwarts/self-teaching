function [length,bucket] = initialize_bucket(vertex,num)
length = zeros(2 * num + 1,2);
bucket = zeros(2 * num + 1, num,2);
for i = 1:num
    location = vertex(i,1) + num + 1;
	if vertex(i,4) == 1
		k = 1;
	else
		k = 2;
	end
	length(location,k) = length(location,k) + 1;
	bucket(location,length(location,k),k) = i;
end
