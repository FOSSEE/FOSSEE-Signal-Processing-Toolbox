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


function w = gausswin (m, a)
//This function is used to generate the gaussian window.

[nargout,nargin]=argn();
  if (nargin < 1 | nargin > 2)
    error("wrong no. of input arguments");
  elseif (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("gausswin: M must be a positive integer");
  elseif (nargin == 1)
    a = 2.5;
  end

  w = exp ( -0.5 * ( a/m * [ -(m-1) : 2 : m-1 ]' ) .^ 2 );

endfunction
