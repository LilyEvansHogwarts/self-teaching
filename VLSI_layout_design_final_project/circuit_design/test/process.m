function [vertex,length,bucket] = process(L,init,vertex,length,bucket,num,percent,k)
temp = vertex(k,2);
vertex(k,2) = vertex(k,3);
vertex(k,3) = temp;
from_location = vertex(k,1) + num + 1;
vertex(k,1) = vertex(k,2) - vertex(k,3);
vertex(k,4) = vertex(k,4) * (-1);
vertex(k,5) = 0;
to_location = vertex(k,1) + num + 1;
if init(k) == 1
    c_from = 2;
    c_to = 1;
else
    c_from = 1;
    c_to = 2;
end
flag = 0;
for i = 1:length(from_location,c_from)
    if bucket(from_location,i,c_from) == k && flag == 0
        flag = 1;
        bucket(from_location,i,c_from) = bucket(from_location,i+1,c_from);
    else
        if flag == 1
            bucket(from_location,i,c_from) = bucket(from_location,i+1,c_from);
        end
    end
end
length(from_location,c_from) = length(from_location,c_from) - 1;
length(to_location,c_to) = length(to_location,c_to) + 1;
bucket(to_location,length(to_location,c_to),c_to) = k;
    
A = triu(diag(diag(L)) - L);
B = zeros(num,num);
B(k,:) = A(k,:);
[i,j,s] = find(sparse(B));
j_size = size(j);
for i = 1:j_size(1,1)
	if init(k) * init(j(i)) < 0
		vertex(j(i),2) = vertex(j(i),2) + s(i);
		vertex(j(i),3) = vertex(j(i),3) - s(i);
	else
		vertex(j(i),2) = vertex(j(i),2) - s(i);
		vertex(j(i),3) = vertex(j(i),3) + s(i);
	end
	if init(j(i)) == 1
		c = 1;
	else
		c = 2;
	end
	from_location = vertex(j(i),1) + num + 1;
	flag = 0;
	for m = 1:length(from_location,c)
		if bucket(from_location,m,c) == k && flag == 0
			flag = 1;
			bucket(from_location,m,c) = bucket(from_location,m + 1,c);
		else 
			if flag == 1
				bucket(from_location,m,c) = bucket(from_location,m + 1,c);
			end
		end
	end
	length(from_location,c) = length(from_location,c) - 1;
	vertex(j(i),1) = vertex(j(i),2) - vertex(j(i),3);
	to_location = vertex(j(i),1) + num + 1;
	length(to_location,c) = length(to_location,c) + 1;
	bucket(to_location,length(to_location,c),c) = j(i);
end

