// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/
// Modifieded by: Abinash Singh Under FOSSEE Internship
// Last Modified on : 19 March 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
function savg = spencer (x)
//Returns Spencer's 15 point moving average of each column of x.
//Calling Sequence:
//spencer(x)
//Parameters:
//X: Real vector or matrix
//Description:
//Returns Spencer's 15 point moving average of each column of x.

  funcprot(0);
  if (nargin() ~= 1)
    error("Wrong number of input arguments.");
  end
  [xr, xc] = size (x);

  n = xr;
  c = xc;

  if (isvector (x))
   n = length (x);
   c = 1;
   x = matrix(x, n, 1);
  end
  w = [-3, -6, -5, 3, 21, 46, 67, 74, 67, 46, 21, 3, -5, -6, -3] / 320;
  savg = filter (w, 1, x);
  savg = [zeros(7,c); savg(15:n,:); zeros(7,c);];
  savg = matrix(savg, xr, xc);

endfunction

//tests:
//assert_checkerror("spencer()", "Wrong number of input arguments.");
//assert_checkerror("spencer(1, 2)", "Wrong number of input arguments.");
//assert_checkequal(spencer(linspace(1, 14, 14)'), zeros(14, 1));
//assert_checkequal(spencer(linspace(-1, -10, 14)), zeros(1, 14)); 
