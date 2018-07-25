// Copyright (C) 2018 - IIT Bombay - FOSSEE
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Author:[insert name]
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in


function y = prepad (x, l, c, dim)
// Calling sequence:
// y= prepad (x, l)
// y= prepad (x, l, c)
// y= prepad (x, l, c, dim)
// Prepend the scalar value c to the vector x until it is of length
// l.  If c is not given, a value of 0 is used.
//
// If length (x) > l, elements from the beginning of x
// are removed until a vector of length l is obtained.
//
// If x is a matrix, elements are prepended or removed from each row.
//
// If the optional argument dim is given, operate along this dimension.
//
// If dim is larger than the dimensions of x, the result will have
// dim dimensions.

//Test cases:
//prepad ([1,2], 4,0,2)
//Output: [0,0,1,2]


[nargout,nargin]=argn();
  if (nargin < 2 | nargin > 4)
    error("wrong number of input arguments");
  end

  if (nargin < 3 | isempty (c))
    c = 0;
  else
    if (~ isscalar (c))
      error ("prepad: pad value C must be empty or a scalar");
    end
  end
//dim=1;
  nd = ndims (x);
  sz = size (x);
  if (argn(2) < 4)
    // Find the first non-singleton dimension.
    (dim == find (sz > 1, 1)) | (dim == 1);
  else
    if (~(isscalar (dim) & dim == fix (dim) & dim >= 1))
      error ("prepad: DIM must be an integer and a valid dimension");
    end
  end

  if (~ isscalar (l) | l < 0)
    error ("prepad: length L must be a positive scalar");
  end

  if (dim > nd)
    sz(nd+1:dim) = 1;
  end

  d = sz(dim);

  if (d >= l)
//    idx = repmat ({':'}, nd, 1);
//    idx(dim) = (d-l+1) : d;
//    y = x(idx(:));
      y=x;
  else
    sz(dim) = l - d;
    y = cat (dim, c(ones (sz(1),sz(2))), x);
  end

endfunction
