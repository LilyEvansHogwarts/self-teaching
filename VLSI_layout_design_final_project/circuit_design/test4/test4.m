clear;
num = 20;
percent = 0.2;
num_pass = 5;
num_cut = 5;
L = create_laplacian_matrix(num);

tic;
a = FM_algorithm(L,num,percent,num_pass,num_cut);
disp('FM_algorithm');
disp(a);
toc

tic;
a = my_approach(num,percent,L);
disp('my approach');
disp(a);
toc
