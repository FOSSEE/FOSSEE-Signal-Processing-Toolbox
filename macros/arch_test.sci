/*
Description:
            Perform a Lagrange Multiplier (LM) test for conditional heteroscedasticity.
            For a linear regression model
            y = x * b + e
            perform a Lagrange Multiplier (LM) test of the null hypothesis of no conditional heteroscedascity against the alternative of CH(p).
            I.e., the model is
            y(t) = b(1) * x(t,1) + … + b(k) * x(t,k) + e(t),
            given y up to t-1 and x up to t, e(t) is N(0, h(t)) with
            h(t) = v + a(1) * e(t-1)^2 + … + a(p) * e(t-p)^2,
            and the null is a(1) == … == a(p) == 0.
            If the second argument is a scalar integer, k, perform the same test in a linear autoregression model of order k, i.e., with
            [1, y(t-1), …, y(t-k)]
            as the t-th row of x.
            Under the null, LM approximately has a chisquare distribution with p degrees of freedom and pval is the p-value (1 minus the CDF of this distribution at LM) of the test.
            If no output argument is given, the p-value is displayed.
        Calling Sequence
            [pval, lm] = arch_test (y, x, p)
        Parameters
            y: Array-like. Dependent variable of the regression model.
            x: Array-like. Independent variables of the regression model. If x is a scalar integer k, it represents the order of autoregression.
            p : Integer. Number of lagged squared residuals to include in the heteroscedasticity model.
        Returns:
            pval: Float. p-value of the LM test.
            lm: Float. Lagrange Multiplier test statistic.*/
        Dependencies : ols, autoreg_matrix
//helper function
function cdf = chi2cdf ( X, n)
    df = resize_matrix ( n , size (X) , "" , n);
    [cdf,Q] = cdfchi ( "PQ" , X ,df);
endfunction
//main function
function [pval, lm] = arch_test (y, x, p)
  nargin = argn(2)
  if (nargin ~= 3)
    error ("arch_test: 3 input arguments required");
  end
  if (~ (isvector (y)))
    error ("arch_test: Y must be a vector");
  end
  T = max(size(y));
  y = matrix (y, T, 1);
  [rx, cx] = size (x);
  if ((rx == 1) && (cx == 1))
    x = autoreg_matrix (y, x);
  elseif (~ (rx == T))
    error ("arch_test: either rows (X) == length (Y), or X is a scalar");
  end
  if (~ (isscalar (p) && (modulo (p, 1) == 0) && (p > 0)))
    error ("arch_test: P must be a positive integer");
  end
  [b, v_b, e] = ols (y, x);
  Z    = autoreg_matrix (e.^2, p);
  f    = e.^2 / v_b - ones (T, 1);
  f    = Z' * f;
  lm   = f' * inv (Z'*Z) * f / 2;
  pval = 1 - chi2cdf (lm, p);
endfunction
