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

function [z, p, g] = ellipap (n, Rp, Rs)
    // Produces a lowpass analog prototype elliptic filter.
//
// Syntax
//   [z, p, g] = ellipap(n, Rp, Rs)
//
// Parameters
// n: Positive integer. The order of the filter.
// Rp: Non-negative scalar. The peak-to-peak passband ripple in decibels (dB).
// Rs: Non-negative scalar. The stopband attenuation in decibels (dB).
// z: Vector. The zeros of the filter.
// p: Vector. The poles of the filter.
// g: Scalar. The gain of the filter.
//
// Description
// This function produces a lowpass analog elliptic prototype filter of order `n`, with a peak-to-peak passband ripple of `Rp` dB and a stopband attenuation of `Rs` dB.
//
// Examples
// [z, p, g] = ellipap(4, 3, 10)
//
// See also
//  analpf
//

    funcprot(0);
    lhs = argn(1)
    rhs = argn(2)
    if (rhs < 3 | rhs > 3)
        error("Wrong number of input arguments.")
    end

    Rpf = 10 ^ (-Rp/20);    //passband pick to pick ripple in fraction
    rp = 1 - Rpf ;          //analpf function compitable passband ripple (delta-p)
    Rsf = 10 ^ (-Rs/20);    //stop band pick to pick ripple in fraction
    rs = Rsf ;             //analpf function compitable stop band ripple (delta-s)
    [hs,p,z,g]=analpf(n,"ellip",[rp rs],1); //cutoff frequency of 1 rad/sec for prototype filter
    p = p' ;
    z = z' ;
    g = abs(g);

endfunction
