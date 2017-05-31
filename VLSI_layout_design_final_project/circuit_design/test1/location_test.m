num = 200;
time = 20;

d = zeros(1,time);
for i = 1:20
    d(1,i) = location(num);
end
x = 1:time;
plot(x,d/num);
