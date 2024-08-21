# ols
# Description:
Ordinary least squares estimation.
OLS applies to the multivariate model y = x*b + e with mean (e) = 0 and
cov (vec (e)) = kron (s, I). where y is a t by p matrix, x is a t by k matrix, b is a k by p matrix, and e is a t by p matrix.
Each row of y and x is an observation and each column a variable.
The return values beta, sigma, and r are defined as follows.
# Calling Sequence:
- `[beta, sigma, r] = ols (y, x)`
# Arguments:
- `beta`:
                The OLS estimator for b. beta is calculated directly via inv (x'*x) * x' * y if the matrix x'*x is of full rank. Otherwise, beta = pinv (x) * y where pinv (x) denotes the pseudoinverse of x.
- `sigma`:
                The OLS estimator for the matrix s,
                sigma = (y-x*beta)'* (y-x*beta) / (t-rank(x))
- `r` :
                The matrix of OLS residuals, r = y - x*beta.