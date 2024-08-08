/*Description
        This function computes the inverse type I discrete sine transform of X If N is given,
        then X is padded or trimmed to length N before computing the transform.
        If X is a matrix, compute the transform along the columns of the the matrix.
Calling Sequence
        Y = idst1(X)
        Y = idst1(X, N)
Parameters
        X: Matrix or integer
        N: If N is given, then X is padded or trimmed to length N before computing the transform.
Examples
        idst1([1,3,6])
    ans = 
         3.97487  -2.50000   0.97487 */
function x = idst1 (y, n)
  nargin=argn(2)
  if (nargin < 1 || nargin > 2)
    error("invalid input arguments")
  end
  if nargin == 1,
    n = size(y,1);
    if n==1, n = size(y,2); end
  end
  x = dst1(y, n) * 2/(n+1);
endfunction

