f = @(x1,x2) x1-x2+2*x1.^2 + 2*x1*x2 +x2.^2;
grad_f = @(x1,x2) [1+4*x1+2*x2;-1+2*x1+2*x2];

max_iter = 100;
tol = 1e-6;
alpha = 0.1;
x = [3;3];
fprintf('Initial x values is (%f , %f)\n',x(1),x(2));
for i=1:max_iter
    gradient = grad_f(x(1),x(2));
    if norm(gradient)<tol
        fprintf("result found after iterations %d \n",i-1);
        break;
    end
    x =x-alpha*gradient;
    fprintf(' x values is (%f , %f) iteration %d \n ',x(1),x(2),i);
end
fprintf('Final soln is at (%f ,%f) and value is %f',x(1),x(2),f(x(1),x(2)));


