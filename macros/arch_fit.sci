/*
Dependencies : ols, autoreg_matrix
Calling Sequence
      [a, b] = arch_fit (y, x, p)
      [a, b] = arch_fit (y, x, p, iter, gamma, a0, b0)
Parameters
      y(vector) : A time-series data vector up to time t-1 .
      x (Matrix): A matrix of (ordinary) regressors x up to t.
      p (scalar): The order of the regression of the residual variance.
      iter (scaler) : Number of iterations
      gamma (real number) : updating factor
      a0 b0 (real numbers) : Initial values for the scoring algorithm
Description:        
        Fit an ARCH regression model to the time series y using the scoring algorithm in Engle’s original ARCH paper.
        The model is
        y(t) = b(1) * x(t,1) + … + b(k) * x(t,k) + e(t),
        h(t) = a(1) + a(2) * e(t-1)^2 + … + a(p+1) * e(t-p)^2
        in which e(t) is N(0, h(t)), given a time-series vector y up to time t-1 and a matrix of (ordinary) regressors x upto t. The order of the regression of the residual variance is specified by p.
        If invoked as arch_fit (y, k, p) with a positive integer k, fit an ARCH(k, p) process, i.e., do the above with the t-th row of x given by
        [1, y(t-1), …, y(t-k)]
        Optionally, one can specify the number of iterations iter, the updating factor gamma, and initial values a0 and b0 for the scoring algorithm.
*/
function [a, b] = arch_fit (y, x, p, iter, gamma, a0, b0)
    nargin = argn(2)
    if (nargin < 3 || nargin == 6)
      error("invalid inputs");
    end
    if (~ (isvector (y)))
      error ("arch_fit: Y must be a vector");
    end
    T = max(size(y));
    y = matrix (y, T, 1);
    [rx, cx] = size (x);
    if ((rx == 1) && (cx == 1))
      x = autoreg_matrix (y, x);
    elseif (~ (rx == T))
      error ("arch_fit: either rows (X) == length (Y), or X is a scalar");
    end
    [T, k] = size (x);
    if (nargin == 7)
      a = a0;
      b = b0;
      e = y - x * b;
    else
      [b, v_b, e] = ols (y, x);
      zer = zeros(1,p);
      a = [v_b zer]';
      if (nargin < 5)
        gamma = 0.1;
        if (nargin < 4)
          iter = 50;
        end
      end
    end
    esq = e.^2;
    Z = autoreg_matrix (esq, p);
    for i = 1 : iter
      h   = Z * a;
      tmp = esq ./ h.^2 - 1 ./ h;
      s   = 1 ./ h(1:T-p);
      for j = 1 : p
        s = s - a(j+1) * tmp(j+1:T-p+j);
      end
      r = 1 ./ h(1:T-p);
      for j = 1:p
        r = r + 2 * h(j+1:T-p+j).^2 .* esq(1:T-p);
      end
      r = sqrt (r);
      X_tilde = x(1:T-p, :) .* (r * ones (1,k));
      e_tilde = e(1:T-p) .*s ./ r;
      delta_b = inv (X_tilde' * X_tilde) * X_tilde' * e_tilde;
      b  = b + gamma * delta_b;  
      e   = y - x * b;
      esq = e .^ 2;
      if isempty(esq) then
          esq = zeros(size(y))
      end
      Z   = autoreg_matrix (esq, p);
      h   = Z * a;
      f   = esq ./ h - ones (T,1);
      Z_tilde = Z ./ (h * ones (1, p+1));
      delta_a = inv (Z_tilde' * Z_tilde) * Z_tilde' * f;
      a = a + gamma * delta_a;
    end
  endfunction
