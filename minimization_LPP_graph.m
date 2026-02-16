clc
clear all

%% Phase 1: Input parameters
c = [3 -5];
a = [ 1  1;
     -2  1;
      1  2];
b = [6; -9; 6];

z  = @(x1,x2) 3*x1 - 5*x2;
c1 = @(x1,x2) x1 + x2 - 6;
c2 = @(x1,x2) -2*x1 + x2 + 9;

c3 = @(x1,x2) x1 + 2*x2 - 6;

%% Phase 2: Plot constraints
figure
hold on
x1 = linspace(0,10,400);
%(a,1) here 1 means selecting the row => 3
%(check if the denominator is non-zero) 


for i=1:size(a,1)
    if a(i,2) ~= 0
        x2 = (b(i)-a(i,1)*x1)/a(i,2);
        plot(x1, x2, 'LineWidth', 1.5);
    else
        x_val = b(i)/a(i,1);
        xline(x_val, 'LineWidth', 1.5);
    end
end

yline(0, 'k', 'LineWidth', 1.5) %shows x2=0 to show region clearly

xlabel('x1')
ylabel('x2')
title('Feasible Region')
grid on

%% Phase 3: Find intersection points
A = [a; eye(2)]; %eye is used to create a identify matrix
B = [b; 0; 0];   
m = size(A,1); % number of row in A = 5

pt = [];
for i = 1:m
    for j = i+1:m
        AA = [A(i,:); A(j,:)];
        BB = [B(i); B(j)];
        if det(AA) ~= 0
            x = AA \ BB;
            pt = [pt x];
        end
    end
end

%% Phase 4: Feasible points check
pt = unique(pt',"rows")'; %2x8 size matrix each column is a new pt.
FP = [];
Z  = [];

for i = 1:size(pt,2)  %number of column in pt => 8
    x1 = pt(1,i);
    x2 = pt(2,i);

    if c1(x1,x2) <= 0 && ...
       c2(x1,x2) <= 0 && ...
       c3(x1,x2) <= 0 && ...
       x1 >= 0 && x2 >= 0
        FP = [FP pt(:,i)];
        Z  = [Z z(x1,x2)];
        plot(x1,x2,'*r','MarkerSize',10)
    end
end

disp('Feasible Points:')
disp(FP)

disp('Objective Function Values:')
disp(Z)

%% Phase 5: Optimal solution
[optimal_value, index] = min(Z);
optimal_solution = FP(:,index);

fprintf('\nOptimal Solution:\n');
fprintf('x1 = %.2f, x2 = %.2f\n', optimal_solution(1), optimal_solution(2));
fprintf('Minimum Z = %.2f\n', optimal_value);