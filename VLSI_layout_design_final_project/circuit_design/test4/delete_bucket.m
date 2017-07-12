function [bucket,length] = delete_bucket(value,line,bucket_num,bucket,length)
flag = 0;
for i = 1:length(line,bucket_num)
	if bucket(line,i,bucket_num) == value
		flag = 1;
		bucket(line,i,bucket_num) = bucket(line,i+1,bucket_num);
	else
		if flag == 1
			bucket(line,i,bucket_num) = bucket(line,i+1,bucket_num);
		end
	end
end
length(line,bucket_num) = length(line,bucket_num) - 1;


