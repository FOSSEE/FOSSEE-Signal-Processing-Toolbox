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

function [z, p, g] = cheb2ap(n, Rs)
// Design a lowpass analog Chebyshev type II filter.
//
// Syntax
//   [z, p, g] = cheb2ap(n, Rs)
//
// Parameters
// n: Positive integer. Order of the filter.
// Rs: Positive real number. Stopband attenuation (in dB).
// z: Zeros of the filter.
// p: Poles of the filter.
// g: Gain of the filter.
//
// Description
// This function designs a lowpass analog Chebyshev type II filter of order `n` with a stopband attenuation of `Rs`.
//
// Examples
// [z, p, g] = cheb2ap(4, 10)
// 

    funcprot(0);
    lhs = argn(1)
    rhs = argn(2)
    if (rhs < 2 | rhs > 2)
        error("cheb2ap: Wrong number of input arguments.")
    end

    Rsf = 10 ^ (-Rs/20);    //stop band pick to pick ripple in fraction
    rs = Rsf ;             //analpf function compitable stop band ripple (delta-s)
    [hs,p,z,g]=analpf(n,"cheb2",[0 rs],1); //cutoff frequency of 1 rad/sec for prototype filter
    p = p' ;
    z = z' ;
    g = abs(g);
endfunction
