function x = autoreg_matrix(y, k)
// Generate a regressor matrix for autoregressions from a time series.
//
// Syntax
//   x = autoreg_matrix(y, k)
//
// Parameters
// y: Vector. Input time series.
// k: Scalar. Number of lagged values to include.
//
// Description
// Given a time series (vector) `y`, this function returns a matrix with ones in the first column and the first `k` lagged values of `y` in the other columns.
// For T > k, `[1, y(T-1), ..., y(T-k)]` is the t-th row of the result. The resulting matrix can be used as a regressor matrix in autoregressions.
//
// Examples
// autoreg_matrix([1, 2, 3], 2)
// 

  funcprot(0);

  if (argn(2) ~= 2)
    error("autoreg_matrix: wrong number of input arguments") ;
  end

  if (~ (isvector (y)))
    error ("autoreg_matrix: y must be a vector");
  end

  T = length (y);
  y = matrix(y, T, 1);
  x = ones (T, k+1);
  for j = 1 : k
    x(:, j+1) = [(zeros(j, 1)); y(1:T-j)];
  end

endfunction

//input validation:
//assert_checkerror("autoreg_matrix(1)", "autoreg_matrix: wrong number of input arguments");
//assert_checkerror("autoreg_matrix(1, 2, 3)", "Wrong number of input arguments.");
//assert_checkerror("autoreg_matrix(1, 2)", "autoreg_matrix: y must be a vector");
//assert_checkerror("autoreg_matrix([1, 2; 3, 4], 2)", "autoreg_matrix: y must be a vector");

//tests:
//assert_checkequal(autoreg_matrix([1, 2], -1), []);
//assert_checkequal(autoreg_matrix([1, 2, 3], 2), [1, 0, 0; 1, 1, 0; 1, 2, 1]);
//assert_checkequal(autoreg_matrix([1, 2, 3], 2), autoreg_matrix([1; 2; 3], 2));
//assert_checkequal(autoreg_matrix([1, 2, 3, 4, 5], 0), [1; 1; 1; 1; 1]);
//assert_checkequal(autoreg_matrix([-1; -3; -5; -7; -9], 5), [1 0 0 0 0 0;1 -1 0 0 0 0;1 -3 -1 0 0 0;1 -5 -3 -1 0 0;1 -7 -5 -3 -1 0])
//assert_checkequal(autoreg_matrix([1+2*%i, 5+4*%i, -4*%i, -1-6*%i], 1), [1, 0; 1, 1 + 2*%i; 1, 5 + 4*%i; 1, -4*%i]);
//assert_checkequal(autoreg_matrix([1+2*%i, 5+4*%i, -4*%i, -1-6*%i], 3), autoreg_matrix([1+2*%i; 5+4*%i; -4*%i; -1-6*%i], 3));
//assert_checkequal(autoreg_matrix([-%i; -3-%i; 5+6*%i; 7+9*%i;], 3), [1 0 0 0;1 -%i 0 0;1 -3-%i -%i 0;1 5+6*%i -3-%i -%i]);
//assert_checkequal(autoreg_matrix([-%i; -3-%i; 5+6*%i; 7+9*%i;], 0), [1; 1; 1; 1]);
