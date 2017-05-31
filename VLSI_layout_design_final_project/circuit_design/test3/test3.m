clear;
num = 200;
L = create_laplacian_matrix(num);
percent = 0.2;
num_pass = 5;
num_initial_cut = 5;

tic;
a = FM_algorithm(num,percent,L,num_pass,num_initial_cut);
disp('FM_algorithm');
disp(a);
toc

tic;
a = my_approach(num,percent,L);
disp('my approach');
disp(a);
toc