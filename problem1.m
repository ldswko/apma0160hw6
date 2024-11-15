p = 9.55e5; 
N = 2; 
T = 300; 
R = 8.314462; 
c1 = 3.69e-1;
c2 = 4.27e-5; 

V_true = 5.00665254961085e-3; 

f = @(V) (p + c1 * N^2 / V^2) * (V - N * c2) - N * R * T;

a = 0.001; 
b = 0.006; 
tol = 1e-9; 

while (b - a) / 2 > tol
    root_estimate = (a + b) / 2;
    if f(root_estimate) == 0
        break; 
    elseif f(a) * f(root_estimate) < 0
        b = root_estimate;
    else
        a = root_estimate; 
    end
end

root_estimate = (a + b) / 2;

error = abs(root_estimate - V_true); 
rel_error = error / abs(V_true); 
residual = abs(f(root_estimate)); 

a = 0.001;
b = 0.006;

g = @(V) (1 / (N * R * T)) * ((p + c1 * N^2 / V^2) * (V - N * c2)) - 1;

while (b - a) / 2 > tol
    root_estimate_2 = (a + b) / 2;
    if g(root_estimate_2) == 0
        break; 
    elseif g(a) * g(root_estimate_2) < 0
        b = root_estimate_2; 
    else
        a = root_estimate_2; 
    end
end

root_estimate_2 = (a + b) / 2;

error_2 = abs(root_estimate_2 - V_true);
rel_error_2 = error_2 / abs(V_true); 
residual_2 = abs(g(root_estimate_2)); 

% g(V) rescales f(V) and therefore the root estimates should be close,
% resulting in a very similar absolute and relative error between
% Part 1 and Part 2. The residuals may be different as they are impacted
% by the magnitude of g(V) and f(V); in our example, they are different.

% The residual tells us how close V is to a root, while it does not
% indicate anything about the accuracy of that root estimate. Tol is a much
% better way of telling us how accurate the root estimate is because it
% limits it to an interval.

p = 9.55e3; 
R = 8.314462e4; 
c1 = 3.69e9; 
c2 = 42.7; 

V_true_cm = 5.00665254961085e3;

h = @(V) (p + c1 * N^2 / V^2) * (V - N * c2) - N * R * T;

a = 1e3; 
b = 6e3; 

predicted_iters = ceil(log2((b - a) / tol));

while (b - a) / 2 > tol
    root_estimate_3 = (a + b) / 2; 
    if h(root_estimate_3) == 0
        break; 
    elseif h(a) * h(root_estimate_3) < 0
        b = root_estimate_3; 
    else
        a = root_estimate_3; 
    end
end

root_estimate_3 = (a + b) / 2;

error_3 = abs(root_estimate_3 - V_true_cm); 
rel_error_3 = error_3 / abs(V_true_cm); 

root_estimate_3_m = root_estimate_3 * 1e-6; 
error_m_in_meters = abs(root_estimate_3_m - V_true); 

% error_3 and rel_error_3 have a value very similar to the absolute and
% relative error of Part 1; however, they are different because the units
% have changed in Part 3. The same Van der Waals equation is used to
% compute in meters in Part 1 whereas Part 3 computes it in centimeters.

% Relative error is most likely more reliable. If the true root is small,
% the absolute error may look small accordingly but may be large compared
% to the true root. Relative error is able to show the true discrepenacy.