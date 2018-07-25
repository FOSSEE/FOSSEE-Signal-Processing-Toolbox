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

function [num, den] = zp2tf (z, p, k)
    //Converts zeros / poles to a transfer function.

    //Calling Sequence
    //[num, den] = zp2tf (z, p, k)
    //num = zp2tf (z, p, k)

    //Parameters
    //z: Zeros
    //p: Poles
    //k: Leading coefficient (Gain)
    //Num: Numerator coefficients of the transfer function
    //den: Denomenator coefficients of the transfer function

    //Description
    //It converts zeros / poles representation to  transfer function representation.

    //Examples
    //z = [1 2 3]
    //p = [4 5 6]
    //k = 5
    //[num, den] = zp2tf (z, p, k)
    //Output :
    // den  =
    //
    //    1.  - 15.    74.  - 120.
    // num  =
    //
    //    5.  - 30.    55.  - 30.

    funcprot(0);
    lhs = argn(1)
    rhs = argn(2)
    if (rhs < 3 | rhs > 3)
        error("zp2tf : Wrong number of input arguments.")
    end

    n = k*real(poly(z,"x"));
    d = real(poly(p, "x"));
    num = coeff(n);
    num = flipdim(num,2);
    den = coeff(d);
    den = flipdim(den,2);

endfunction
