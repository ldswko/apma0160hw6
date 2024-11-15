f = @(x) x .* sin(x) - 1;
df = @(x) sin(x) + x .* cos(x);

tol = 1e-9;
x0 = 0.5;

% Newton's Method
x_vals = x0;
newton_iters = 0;
while true
    x_new = x_vals(end) - f(x_vals(end)) / df(x_vals(end));
    x_vals = [x_vals, x_new];
    newton_iters = newton_iters + 1;
    if abs(x_vals(end) - x_vals(end - 1)) < tol
        break;
    end
end

xtrue = fzero(f, 0.5);  
err_newton = abs(xtrue - x_vals);

% Bisection Method
a = -1/2;
b = 3/2;
midpoints = (a + b) / 2;
bisection_iters = 0;
while abs(midpoints(end) - xtrue) >= tol
    c = (a + b) / 2;
    midpoints = [midpoints, c];
    bisection_iters = bisection_iters + 1;
    if f(a) * f(c) < 0
        b = c;
    else
        a = c;
    end
end

err_bisection = abs(xtrue - midpoints);