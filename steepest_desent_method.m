% CODE FOR STEEPEST DESCENT METHOD
% QUESTION IS - PERFORM 4 ITERATIONS OF STEEPEST DESCENT ALGORITHM TO MINIMIZE
% f(x1,x2)=x1-x2+2x1^2+2x1x2+x2^2

% Starting from the point X1=[1,1]

format short
clear all
clc

%% Phase 1 - Define objective function
syms x1 x2
f = x1 - x2 + 2*x1^2 + 2*x1*x2 + x2^2;

fx = inline(f);                % convert f1 into a function of x1 and x2
fobj = @(x) fx(x(1), x(2));    % convert the function in one variable

%% Phase 2 - Compute gradient
grad = gradient(f);
G = inline(grad);              % convert grad into a function of x1 and x2
gradx = @(x) G(x(1), x(2));    % convert the function in one variable

%% Phase 3 - Compute Hessian Matrix
H1 = hessian(f);
Hx = inline(H1);               % convert H1 into a function

%% Phase 4 - Iterations
x0 = [1 1];        % given initial value of x1 x2
maxiter = 4;       % maximum number of iteration
tol = 10^(-3);     % maximum tolerance or error
iter = 0;          % iteration counter

x = [1; 1];        % initial vector array

while norm(gradx(x0)) > tol && iter < maxiter
    % X = [x; x0];           % save all vectors
    S = -gradx(x0);        % compute gradient at X
    H = Hx(x0);            % compute Hessian at X
    
    lambda = S' * S / (S' * H * S);   % compute lambda
    
    xnew = x0 + lambda .* S';         % update X
    x0 = xnew;                        % save new X
    
    iter = iter + 1;                  % update iteration number
end

%% Phase 5 - Print the solution
fprintf('Optimal Solution X = [%f, %f]\n', x0(1), x0(2))
fprintf('Optimal Value f(x) = %f\n', fobj(x0))