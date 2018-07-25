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



function p = polyreduce (c)
//Calling sequence
//p= polyreduce (c)
// Reduce a polynomial coefficient vector to a minimum number of terms by
// stripping off any leading zeros.

//Test cases:
//polyreduce ([0, 0, 1, 2, 3])
//Output: [1, 2, 3]



[nargout,nargin]=argn();

  if (nargin ~= 1)
    error("wrong number of input arguments");

  elseif (~isvector (c) | isempty (c))
    error ("polyreduce: C must be a non-empty vector");
  end

  idx = find (c ~= 0, 1);

  if (isempty (idx))
    p = 0;
  else
    p = c(idx:$);
  end

endfunction
