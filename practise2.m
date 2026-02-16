clc
clear

c = [3 5 0 0];
A = [1 1 0 0;
     1 0 0 0];
B = [4;2];

z = @(x) c * x;

n = size(A,2);
m = size(A,1);

pairs = nchoosek(1:n,m);
ncm = nchoosek(n,m);

basic_sol = [];
basic_f_sol = [];

for i = 1:ncm
    basic_index = pairs(i,:);
    y = zeros(n,1);
    x = A(:,basic_index) \ B;
    y(basic_index) = x;   
    basic_sol = [basic_sol y];
    if all(x >= 0)       
        basic_f_sol = [basic_f_sol y];
    end
end

cost = z(basic_f_sol);

[Zmax, idx] = max(cost);
optimal_point = basic_f_sol(:,idx);
disp("Optimal Solution:")
disp(optimal_point)
fprintf("Maximum Value = %.2f\n", Zmax);
