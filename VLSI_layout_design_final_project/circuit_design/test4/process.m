function [cell_gain,cut,p,length,bucket,lock] = process(cell_gain,cut,p,length,bucket,lock,num,percent,cell,net)
if p(1,1) > p(1,2)
	i = 1;
	while(lock(bucket(p(1,1),i,1)) == 1 && i <= length(p(1,1),1))
		i = i + 1;
	end
	change_vertex = bucket(p(1,1),i,1);
	new_cut = cut;
	new_cut(change_vertex,1) = new_cut(change_vertex,1) * (-1);
	if abs(sum(new_cut)) <= percent * num
		cut = new_cut;
		%%%将change_vertex从原有的bucket中删除
		location = cell_gain(change_vertex,1) + num + 1;
		[bucket,length] = delete_bucket(change_vertex,p(1,1),1,bucket,length);
		%%%将chang_vertex添加进新的bucket，length，cell_gain
		temp = cell_gain(change_vertex,2); 
		cell_gain(change_vertex,2) = cell_gain(change_vertex,3);
		cell_gain(change_vertex,3) = temp;
		cell_gain(change_vertex,1) = cell_gain(change_vertex,2) - cell_gain(change_vertex,3);
		location = cell_gain(change_vertex,1) + num + 1;
		length(location,2) = length(location,2) + 1;
		bucket(location,length(location,2),2) = change_vertex;
        %%%更新cell_connected对应的bucket、length、cell_gain
		cell_connected = connected_cells(change_vertex,cell,net);
		shape = size(cell_connected);
		for i = 1:shape(1,2)
			if cut(cell_connected(i),1) * cut(change_vertex,1) > 0 %%%说明change_vertex与i顶点原本不在同一区
				%%%根据原有cell_gain，将其从原来的bucket里删除
				location = cell_gain(cell_connected(i),1) + num + 1;
				[bucket,length] = delete_bucket(cell_connected(i),location,2,bucket,length);
				%%%更新cell_gain，并将其移动至新的bucket里
				cell_gain(cell_connected(i),2) = cell_gain(cell_connected(i),2) - 1;
				cell_gain(cell_connected(i),3) = cell_gain(cell_connected(i),3) + 1;
				cell_gain(cell_connected(i),1) = cell_gain(cell_connected(i),2) - cell_gain(cell_connected(i),3);
				location = cell_gain(cell_connected(i),1) + num + 1;
				length(location,2) = length(location,2) + 1;
				bucket(location,length(location,2),2) = cell_connected(i);
			else
				location = cell_gain(cell_connected(i),1) + num + 1;
				[bucket,length] = delete_bucket(cell_connected(i),location,1,bucket,length);
				cell_gain(cell_connected(i),2) = cell_gain(cell_connected(i),2) + 1;
				cell_gain(cell_connected(i),3) = cell_gain(cell_connected(i),3) - 1;
				cell_gain(cell_connected(i),1) = cell_gain(cell_connected(i),2) - cell_gain(cell_connected(i),3);
				location = cell_gain(cell_connected(i),1) + num + 1;
				length(location,1) = length(location,1) + 1;
				bucket(location,length(location,1),1) = cell_connected(i);
			end
		end
	else
		i = 1;
		while(lock(bucket(p(1,2),i,2)) == 1 && i <= length(p(1,2),2))
			i = i + 1;
		end
		change_vertex = bucket(p(1,2),i,2);
		cut(change_vertex,1) = cut(change_vertex,1) * (-1);
		%%%将change_vertex从原有的bucket中删除
		location = cell_gain(change_vertex,1) + num + 1;
		[bucket,length] = delete_bucket(change_vertex,p(1,2),2,bucket,length);
		%%%将change_vertex添加进入新的bucket、length、cell_gain
		temp = cell_gain(change_vertex,2);
		cell_gain(change_vertex,2) = cell_gain(change_vertex,3);
		cell_gain(change_vertex,3) = temp;
		cell_gain(change_vertex,1) = cell_gain(change_vertex,2) - cell_gain(change_vertex,3);
		location = cell_gain(change_vertex,1) + num + 1;
		length(location,1) = length(location,1) + 1;
		bucket(location,length(location,1),1) = change_vertex;
        %%%更新cell_connected对应的bucket、length、cell_gain
		cell_connected = connected_cells(change_vertex,cell,net);
		shape = size(cell_connected);
		for i = 1:shape(1,2)
			if cut(cell_connected(i),1) * cut(change_vertex,1) > 0 %%%说明change_vertex与i顶点原本不在同一区
				%%%根据原有cell_gain，将其从原来的bucket里删除
				location = cell_gain(cell_connected(i),1) + num + 1;
				[bucket,length] = delete_bucket(cell_connected(i),location,1,bucket,length);
				%%%更新cell_gain，并将其移动至新的bucket里
				cell_gain(cell_connected(i),2) = cell_gain(cell_connected(i),2) - 1;
				cell_gain(cell_connected(i),3) = cell_gain(cell_connected(i),3) + 1;
				cell_gain(cell_connected(i),1) = cell_gain(cell_connected(i),2) - cell_gain(cell_connected(i),3);
				location = cell_gain(cell_connected(i),1) + num + 1;
				length(location,1) = length(location,1) + 1;
				bucket(location,length(location,1),1) = cell_connected(i);
			else
				location = cell_gain(cell_connected(i),1) + num + 1;
				[bucket,length] = delete_bucket(cell_connected(i),location,2,bucket,length);
				cell_gain(cell_connected(i),2) = cell_gain(cell_connected(i),2) + 1;
				cell_gain(cell_connected(i),3) = cell_gain(cell_connected(i),3) - 1;
				cell_gain(cell_connected(i),1) = cell_gain(cell_connected(i),2) - cell_gain(cell_connected(i),3);
				location = cell_gain(cell_connected(i),1) + num + 1;
				length(location,2) = length(location,2) + 1;
				bucket(location,length(location,2),2) = cell_connected(i);
			end
		end
	end
else
	i = 1;
	while(lock(bucket(p(1,2),i,2)) == 1 && i <= length(p(1,2),2))
		i = i + 1;
	end
	change_vertex = bucket(p(1,2),i,2);
	new_cut = cut;
	new_cut(change_vertex,1) = new_cut(change_vertex,1) * (-1);
	if abs(sum(new_cut)) <= percent * num
		cut = new_cut;
		%%%将change_vertex从原有的bucket中删除
		location = cell_gain(change_vertex,1) + num + 1;
		[bucket,length] = delete_bucket(change_vertex,p(1,2),2,bucket,length);
		%%%将chang_vertex添加进新的bucket，length，cell_gain
		temp = cell_gain(change_vertex,2); 
		cell_gain(change_vertex,2) = cell_gain(change_vertex,3);
		cell_gain(change_vertex,3) = temp;
		cell_gain(change_vertex,1) = cell_gain(change_vertex,2) - cell_gain(change_vertex,3);
		location = cell_gain(change_vertex,1) + num + 1;
		length(location,1) = length(location,1) + 1;
		bucket(location,length(location,1),1) = change_vertex;
        %%%更新cell_connected对应的bucket、length、cell_gain
		cell_connected = connected_cells(change_vertex,cell,net);
		shape = size(cell_connected);
		for i = 1:shape(1,2)
			if cut(cell_connected(i),1) * cut(change_vertex,1) > 0 %%%说明change_vertex与i顶点原本不在同一区
				%%%根据原有cell_gain，将其从原来的bucket里删除
				location = cell_gain(cell_connected(i),1) + num + 1;
				[bucket,length] = delete_bucket(cell_connected(i),location,1,bucket,length);
				%%%更新cell_gain，并将其移动至新的bucket里
				cell_gain(cell_connected(i),2) = cell_gain(cell_connected(i),2) - 1;
				cell_gain(cell_connected(i),3) = cell_gain(cell_connected(i),3) + 1;
				cell_gain(cell_connected(i),1) = cell_gain(cell_connected(i),2) - cell_gain(cell_connected(i),3);
				location = cell_gain(cell_connected(i),1) + num + 1;
				length(location,1) = length(location,1) + 1;
				bucket(location,length(location,1),1) = cell_connected(i);
			else
				location = cell_gain(cell_connected(i),1) + num + 1;
				[bucket,length] = delete_bucket(cell_connected(i),location,2,bucket,length);
				cell_gain(cell_connected(i),2) = cell_gain(cell_connected(i),2) + 1;
				cell_gain(cell_connected(i),3) = cell_gain(cell_connected(i),3) - 1;
				cell_gain(cell_connected(i),1) = cell_gain(cell_connected(i),2) - cell_gain(cell_connected(i),3);
				location = cell_gain(cell_connected(i),1) + num + 1;
				length(location,2) = length(location,2) + 1;
				bucket(location,length(location,2),2) = cell_connected(i);
			end
		end
	else
		i = 1;
		while(lock(bucket(p(1,1),i,1)) == 1 && i <= length(p(1,1),1))
			i = i + 1;
		end
		change_vertex = bucket(p(1,1),i,1);
		cut(change_vertex,1) = cut(change_vertex,1) * (-1);
		%%%将change_vertex从原有的bucket中删除
		location = cell_gain(change_vertex,1) + num + 1;
		[bucket,length] = delete_bucket(change_vertex,p(1,1),1,bucket,length);
		%%%将change_vertex添加进入新的bucket、length、cell_gain
		temp = cell_gain(change_vertex,2);
		cell_gain(change_vertex,2) = cell_gain(change_vertex,3);
		cell_gain(change_vertex,3) = temp;
		cell_gain(change_vertex,1) = cell_gain(change_vertex,2) - cell_gain(change_vertex,3);
		location = cell_gain(change_vertex,1) + num + 1;
		length(location,2) = length(location,2) + 1;
		bucket(location,length(location,2),2) = change_vertex;
        %%%更新cell_connected对应的bucket、length、cell_gain
		cell_connected = connected_cells(change_vertex,cell,net);
		shape = size(cell_connected);
		for i = 1:shape(1,2)
			if cut(cell_connected(i),1) * cut(change_vertex,1) > 0 %%%说明change_vertex与i顶点原本不在同一区
				%%%根据原有cell_gain，将其从原来的bucket里删除
				location = cell_gain(cell_connected(i),1) + num + 1;
				[bucket,length] = delete_bucket(cell_connected(i),location,2,bucket,length);
				%%%更新cell_gain，并将其移动至新的bucket里
				cell_gain(cell_connected(i),2) = cell_gain(cell_connected(i),2) - 1;
				cell_gain(cell_connected(i),3) = cell_gain(cell_connected(i),3) + 1;
				cell_gain(cell_connected(i),1) = cell_gain(cell_connected(i),2) - cell_gain(cell_connected(i),3);
				location = cell_gain(cell_connected(i),1) + num + 1;
				length(location,2) = length(location,2) + 1;
				bucket(location,length(location,2),2) = cell_connected(i);
			else
				location = cell_gain(cell_connected(i),1) + num + 1;
				[bucket,length] = delete_bucket(cell_connected(i),location,1,bucket,length);
				cell_gain(cell_connected(i),2) = cell_gain(cell_connected(i),2) + 1;
				cell_gain(cell_connected(i),3) = cell_gain(cell_connected(i),3) - 1;
				cell_gain(cell_connected(i),1) = cell_gain(cell_connected(i),2) - cell_gain(cell_connected(i),3);
				location = cell_gain(cell_connected(i),1) + num + 1;
				length(location,1) = length(location,1) + 1;
				bucket(location,length(location,1),1) = cell_connected(i);
			end
		end
	end
end

%%%更新lock、p，注意这里的p为了代码简化取了没有被lock的顶点对应的最大location
lock(change_vertex,1) = 1;
for c = 1:2
    [i,j,s] = find(sparse(bucket(:,:,c)'));
    shape = size(s);
    k = shape(1,1);
	while(k >= 1 && lock(s(k,1),1) == 1)
        k = k - 1;
    end
	if k == 0
		p(1,c) = 1;
end


