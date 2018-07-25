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

function xt = sampled2continuous( xn , T, t )


    //This function calculates the output reconstructed from the samples n supplied as input, at a rate of 1/s samples per unit time.
//Calling Sequence
//x = sampled2continuous (xn, T, t)
//Parameters
//xn:sampled signal
//T:sampling rate
//t:all the instants of time when you need x(t) from x[n]
//Description
//This is an Octave function.
//This function calculates the output reconstructed from the samples n supplied as input, at a rate of 1/s samples per unit time.
//The third parameter t is all the instants where output x is needed from intput n and this time is relative to x(0).
//Examples
//sampled2continuous([1,2,3],5,6)
//ans  =
//    2.4166806

  if ( argn(2) < 3 )
    error('wrong number of input parameters')
  end

  N = length( xn );//finding the length of input sequence
  xn = matrix( xn, N, 1 );//stacking the matrix xn in columnwise manner
  [TT,tt]= meshgrid(T*(0:N-1)',t);
  S = sinc(%pi.*(tt -TT)./T);
  xt = S*xn;//recontructing the samples
  return

endfunction
