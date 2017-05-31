%% 本程序可以用来证明当cut每个元素符号与特征值较小的特征向量一致时，对应的cut会是比较小的值

num = 50;
percent = 0.2;
num_pass = 5;
num_initial_cut = 5;
gain_list = zeros(1,num_initial_cut);
cut_list = zeros(num,num_initial_cut);
L = create_laplacian_matrix(num);
cut = initialize_cut(num,percent);
for i = 1:num_initial_cut
    cut = initialize_cut(num, percent);
    [gain_list(1,i),cut_list(:,i)] = one_initial_cut(L,cut,num,percent,num_pass);
end
[a,b] = min(gain_list);
disp(a);
%%disp(cut_list(:,b));
    
			
		
    

