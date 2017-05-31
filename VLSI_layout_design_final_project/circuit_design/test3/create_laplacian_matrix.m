function L = create_laplacian_matrix(num)
A = rand(num) > 0.5;
A = A - triu(A);
B = A + A';
L = diag(sum(B)) - B;