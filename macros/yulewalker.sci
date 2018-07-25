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

function [A,V]= yulewalker(c)
// Fit an AR (p)-model with Yule-Walker estimates given a vector C of autocovariances '[gamma_0, ..., gamma_p]'.
//Calling Sequence
//A    = yulewalker(C)
//[A,V]= yulewalker(C)
//Parameters
//C: Autocovariances
//Description
//Fit an AR (p)-model with Yule-Walker estimates given a vector C of autocovariances '[gamma_0, ..., gamma_p]'.
//Returns the AR coefficients, A, and the variance of white noise, V.

//Test cases
//[A,V]=yulewalker([1 2 3])
// V  = - 2.6666667
// A  =1.3333333
//     0.3333333


funcprot(0);
lhs=argn(1);
rhs= argn(2);

 if (rhs ~= 1)
    error ("wrong number of input arguments");
  end

  p = length (c) - 1;

  if (size (c,"c") > 1)
    c = c';
  end

  cp = c(2 : p+1);
  CP = zeros (p, p);

  for i = 1:p
    for j = 1:p
      CP (i, j) = c (abs (i-j) + 1);
    end
  end

  A = inv (CP) * cp;
  V = c(1) -A' * cp;

endfunction
