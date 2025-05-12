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

function [z, p, g] = cheb1ap(n, Rp)
// Design a lowpass analog Chebyshev type I filter.
//
// Syntax
//   [z, p, g] = cheb1ap(n, Rp)
//
// Parameters
// n: Positive integer. Order of the filter.
// Rp: Positive real number. Peak-to-peak passband ripple (in dB).
// z: Zeros of the filter.
// p: Poles of the filter.
// g: Gain of the filter.
//
// Description
// This function designs a lowpass analog Chebyshev type I filter of order `n` with a peak-to-peak passband ripple of `Rp`.
//
// Examples
// [z, p, g] = cheb1ap(10, 3)
// 

    funcprot(0);
    lhs = argn(1)
    rhs = argn(2)
    if (rhs < 2 | rhs > 2)
        error("cheb1ap: Wrong number of input arguments.")
    end

    Rpf = 10 ^ (-Rp/20);    //passband pick to pick ripple in fraction
    rp = 1 - Rpf ;          //analpf function compitable passband ripple (delta-p)
    [hs,p,z,g]=analpf(n,"cheb1",[rp 0],1); //cutoff frequency of 1 rad/sec for prototype filter
    p = p' ;
    z = z' ;
    g = abs(g);

endfunction
