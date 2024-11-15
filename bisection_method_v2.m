function [root, intervals] = bisection_method_v2(f, a, b, tol)
  
intervals = [];
max_iterations = 1000;
iter = 0;
    
while (b - a) / 2 > tol && iter < max_iterations
        m = (a + b) / 2;
        intervals = [intervals; a, m, b];        
        if f(m) == 0
            root = m;
            return;
        elseif f(a) * f(m) < 0
            b = m;
        else
            a = m;
        end   
        iter = iter + 1;
end

    root = (a + b) / 2;
    intervals = [intervals; a, root, b];
end