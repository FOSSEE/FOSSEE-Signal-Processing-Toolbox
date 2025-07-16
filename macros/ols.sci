
function [bt, sigma, r] = ols (y, x)
// Ordinary least squares estimation.
//
// Description
//             OLS applies to the multivariate model y = x*b + e with mean (e) = 0 and
//             cov (vec (e)) = kron (s, I). where y is a t by p matrix, x is a t by k matrix, b is a k by p matrix, and e is a t by p matrix.
//             Each row of y and x is an observation and each column a variable.
//             The return values beta, sigma, and r are defined as follows.
// 
// Syntax
//             [beta, sigma, r] = ols (y, x)
//
//  Parameters
//             beta : The OLS estimator for b. beta is calculated directly via inv (x'*x) * x' * y if the matrix x'*x is of full rank. Otherwise, beta = pinv (x) * y where pinv (x) denotes the pseudoinverse of x.
//             sigma : The OLS estimator for the matrix s, sigma = (y-x*beta)'* (y-x*beta) / (t-rank(x))
//             r : The matrix of OLS residuals, r = y - x*beta.
// 
//  Examples
// // Simulated data
// t = 100;                       // Number of observations
// x = [ones(t, 1), rand(t, 1)];  // Design matrix: intercept + one regressor
// b_true = [2; 3]               // True coefficients: intercept = 2, slope = 3
// // Generate response variable with noise
// y = x * b_true + rand(t, 1,'normal');  // y = 2 + 3*x + noise
// // Perform OLS estimation
// [beta, sigma, r] = ols(y, x)


    function [u , p] = formatted_chol(z)
      //p flags whether the matrix A was positive definite and chol does not fail. A zero value of p indicates that matrix A is positive definite and R gives the factorization. Otherwise, p will have a positive value.
      ierr  = execstr (" u = chol (z);",'errcatch' )
      if ( ierr == 29 )
        p = %T ;
        warning("chol: Matrix is not positive definite.")
        u = %nan
      else
        p = %F ;
      end
    endfunction
    nargin = argn ( 2 )
    if (nargin ~= 2)
      error ("null");
    end
    if (~ (or (type(x) == [ 1 5 8] ) && or (type(y) == [1 5 8])))
      error ("ols: X and Y must be numeric matrices or vectors");
    end
    if (ndims (x) ~= 2 || ndims (y) ~= 2)
      error ("ols: X and Y must be 2-D matrices or vectors");
    end
    [nr, nc] = size (x);
    [ry, cy] = size (y);
    if (nr ~= ry)
      error ("ols: number of rows of X and Y must be equal");
    end
    if (type(x) == 8)
      x = double (x);
    end
    if ( type(y) == 8 )
      y = double (y);
    end
    // Start of algorithm
    z = x' * x;
    [u, p] = formatted_chol (z);
    if (p)
      bt = pinv (x) * y;
    else
      bt = u \ (u' \ (x' * y));
    end
    if (nargout > 1)
      r = y - x * bt;
      // z is of full rank, avoid the SVD in rnk
      if (p == 0)
        rnk = size (z,2);
      else
        rnk = rank (z);
      end
      sigma = r' * r / (nr - rnk);
    end
endfunction
