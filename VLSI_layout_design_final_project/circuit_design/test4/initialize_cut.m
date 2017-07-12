function cut = initialize_cut(num, percent)
cut = sign(rand(num,1) - 0.5);
if abs(sum(cut)) >= percent * num;
    cut = initialize_cut(num, percent);
end