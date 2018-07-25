function b = convmtx (a, n)
//Calling sequence:
//b=convmtx(a,n);
//convmtx(a,n);

//This function returns the convolution matrix 'b'.
//If 'a' is a column vector and if we need the convolution of 'a' with another column vector 'x' of length 'n' then an operation            "convmtx(a,n)*x" yeilds the convoluted sequence much faster.

//Similarily, if 'a' is a row vector then to convolve with another row vector 'x' of length n , then convoluted sequence can be obtained by
//x*convmtx(a,n)



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
