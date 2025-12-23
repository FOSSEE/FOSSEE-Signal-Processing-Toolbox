function b = convmtx(a, n)
// Generate a convolution matrix.
//
// Syntax
//   b = convmtx(a, n)
//
// Parameters
// a: Vector. Input vector to generate the convolution matrix.
// n: Integer. Length of the vector to convolve with.
// b: Matrix. Convolution matrix.
//
// Description
// This function generates the convolution matrix `b` for the input vector `a`. If `a` is a column vector, the operation `convmtx(a, n) * x` yields the convolution of `a` with another column vector `x` of length `n`. Similarly, if `a` is a row vector, the operation `x * convmtx(a, n)` yields the convolution of `a` with another row vector `x` of length `n`.
//
// Examples
// a = [1; 2; 3]
// n = 4
// b = convmtx(a, n)


[nargout,nargin]=argn();
  if (nargin ~= 2)
    error("wrong number of input arguments");
  end

  [r, c] = size(a);

  if ((r ~= 1) & (c ~= 1)) | (r*c == 0)
    error("convmtx: expecting vector argument");
  end

  b = toeplitz([a(:); zeros(n-1,1)],[a(1); zeros(n-1,1)]);
  if (c > r)
    b = b.';
  end

endfunction
