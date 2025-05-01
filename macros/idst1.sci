function y = idst1 (x, n)
// Computes the inverse type I discrete sine transform of X
//
// Syntax
//   y = idst1(x)
//   y = idst1(x,n)
//
// Parameters
// x: Input signal.
// n: If N is given, then X is padded or trimmed to length N before computing the transform.
// y: Inverse discrete sine transform of the input signal.
//
// Description
// This function computes the inverse type I discrete sine transform of X If N is given,
// then X is padded or trimmed to length N before computing the transform.
// If X is a matrix, compute the transform along the columns of the the matrix.
//

// Examples
// y = idst1([1, 2, 3, 4])
//
// See also
//  dst1
//


        nargin=argn(2)
  if (nargin < 1 || nargin > 2)
    error("invalid input arguments")
  end
  if nargin == 1,
    n = size(x,1);
    if n==1, n = size(x,2); end
  end
  y = dst1(x, n) * 2/(n+1);
endfunction

