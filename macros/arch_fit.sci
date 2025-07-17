function [a, b] = arch_fit(y, x, p, iter, gamma, a0, b0)
// Fit an ARCH regression model to the time series y using the scoring algorithm in Engle’s original ARCH paper.
//
// Syntax
//   [a, b] = arch_fit(y, x, p)
//   [a, b] = arch_fit(y, x, p, iter, gamma, a0, b0)
//
// Parameters
// y: A time-series data vector up to time t-1.
// x: A matrix of (ordinary) regressors x up to t.
// p: The order of the regression of the residual variance.
// iter: Number of iterations (optional).
// gamma: Updating factor (optional).
// a0: Initial values for the scoring algorithm (optional).
// b0: Initial values for the scoring algorithm (optional).
//
// Description
// Function arch_fit() fits an ARCH regression model to the time series `y` using the scoring algorithm in Engle’s original ARCH paper. 
// The model is:
//   y(t) = b(1) * x(t,1) + … + b(k) * x(t,k) + e(t),
//   h(t) = a(1) + a(2) * e(t-1)^2 + … + a(p+1) * e(t-p)^2
// where `e(t)` is N(0, h(t)). The function allows specifying the number of iterations, updating factor, and initial values for the scoring algorithm.
//
// Examples
// // Fit an ARCH regression model to a time series
// 
// // Define the time series data (y) and regressors (x)
// y = [1.2, 2.3, 1.8, 2.5, 3.1, 2.9, 3.5, 3.8, 4.2, 4.5] // Time-series data
// x = [1, 2; 2, 3; 3, 4; 4, 5; 5, 6; 6, 7; 7, 8; 8, 9; 9, 10; 10, 11] // Regressors
// 
// // Define the order of the regression of the residual variance
// p = 2
// 
// // Fit the ARCH model
// [a, b] = arch_fit(y, x, p)
// 
// See also
//  autoreg_matrix

nargin = argn(2);
if (nargin < 3 || nargin == 6) then
    error("invalid inputs");
end
if (~isvector(y)) then
    error("arch_fit: Y must be a vector");
end
T = max(size(y));
y = matrix(y, T, 1);
[rx, cx] = size(x);
if ((rx == 1) && (cx == 1)) then
    x = autoreg_matrix(y, x);
elseif (~(rx == T)) then
    error("arch_fit: either rows (X) == length (Y), or X is a scalar");
end
[T, k] = size(x);
if (nargin == 7) then
    a = a0;
    b = b0;
    e = y - x * b;
else
    [b, v_b, e] = ols(y, x);
    zer = zeros(1, p);
    a = [v_b zer]';
    if (nargin < 5) then
        gamma = 0.1;
        if (nargin < 4) then
            iter = 50;
        end
    end
end
esq = e.^2;
Z = autoreg_matrix(esq, p);
for i = 1:iter
    h = Z * a;
    tmp = esq ./ h.^2 - 1 ./ h;
    s = 1 ./ h(1:T-p);
    for j = 1:p
        s = s - a(j+1) * tmp(j+1:T-p+j);
    end
    r = 1 ./ h(1:T-p);
    for j = 1:p
        r = r + 2 * h(j+1:T-p+j).^2 .* esq(1:T-p);
    end
    r = sqrt(r);
    X_tilde = x(1:T-p, :) .* (r * ones(1, k));
    e_tilde = e(1:T-p) .* s ./ r;
    delta_b = inv(X_tilde' * X_tilde) * X_tilde' * e_tilde;
    b = b + gamma * delta_b;
    e = y - x * b;
    esq = e .^ 2;
    if isempty(esq) then
        esq = zeros(size(y));
    end
    Z = autoreg_matrix(esq, p);
    h = Z * a;
    f = esq ./ h - ones(T, 1);
    Z_tilde = Z ./ (h * ones(1, p+1));
    delta_a = inv(Z_tilde' * Z_tilde) * Z_tilde' * f;
    a = a + gamma * delta_a;
end
endfunction
