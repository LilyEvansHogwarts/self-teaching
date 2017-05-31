function L = create_laplacian_matrix(num)
A = relu(rand(num) - 0.5);
A = A - triu(A);
B = A + A';
L = diag(sum(B)) - B;