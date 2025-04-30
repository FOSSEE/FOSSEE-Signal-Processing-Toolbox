// Copyright (C) 2018 - IIT Bombay - FOSSEE
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Author:Sonu Sharma, RGIT Mumbai
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in

function [z, p, g] = buttap(n)
// Generate an analog prototype Butterworth filter.
//
// Syntax
//   [z, p, g] = buttap(n)
//
// Parameters
// n: Positive integer. Order of the Butterworth filter.
// z: Zeros of the filter.
// p: Poles of the filter.
// g: Gain of the filter.
//
// Description
// This function produces a lowpass analog prototype Butterworth filter of order `n`.
//
// Examples
// [z, p, g] = buttap(5)
// Output:
// g =
//    1.
// p =
//  -0.3090170 - 0.9510565i
//  -0.8090170 - 0.5877853i
//  -1. - 1.225D-16i
//  -0.8090170 + 0.5877853i
//  -0.3090170 + 0.9510565i
// z =
//     []

    funcprot(0);
    lhs = argn(1)
    rhs = argn(2)
    if (rhs < 1 | rhs > 1)
        error("buttap: Wrong number of input arguments.")
    end

    [Hs, p, z, g] = analpf(n, "butt", [],1 );
    p = p' ;
    z = z' ;

endfunction
