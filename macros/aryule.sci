function [a, v, k] = aryule(x, p)
// Fit an AR (p)-model with Yule-Walker estimates.
//
// Syntax
//   a = aryule(x, p)
//   [a, v] = aryule(x, p)
//   [a, v, k] = aryule(x, p)
//
// Parameters
// x: Vector of real or complex numbers, length > 2.
// p: Positive integer value < length(x) - 1.
// a: AR coefficients.
// v: Variance of the white noise.
// k: Reflection coefficients to be used in the lattice filter.
//
// Description
// This function fits an AR (p)-model with Yule-Walker estimates. The first argument is the data vector to be estimated.
//
// Examples
// aryule([1, 2, 3, 4, 5], 2)
// 


  [nargout,nargin] = argn() ;

  if ( nargin~=2 )
    error('aryule : invalid number of inputs');
  elseif ( ~isvector(x) | length(x)<3 )
    error( 'aryule: arg 1 (x) must be vector of length >2' );
  elseif ( ~isscalar(p) | fix(p)~=p | p > length(x)-2 )
    error( 'aryule: arg 2 (p) must be an integer >0 and <length(x)-1' );
  end

  c = xcorr(x, p+1, 'biased');
  c(1:p+1) = [];     // remove negative autocorrelation lags
  c(1) = real(c(1)); // levinson/toeplitz requires exactly c(1)==conj(c(1))
  if nargout <= 1
    a = levinson(c, p);
  elseif nargout == 2
    [a, v] = levinson(c, p);
  else
    [a, v, k] = levinson(c, p);
  end

endfunction
