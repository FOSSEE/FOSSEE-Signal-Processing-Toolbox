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
    //Produces a lowpass analog prototype elliptic filter.

    //Calling Sequence
    //[z, p, g] = ellipap (n, Rp, Rs)

    //Parameters
    //n: Filter Order
    //Rp: Peak-to-peak passband ripple (in dB)
    //Rs: Stopband attenuation (in dB)

    //Description
    //It gives a lowpass analog elliptic prototype filter of nth order, with a Peak-to-peak passband ripple of Rp dB and a stopband attenuation of Rs dB.

    //Examples
    //[z, p, g] = ellipap (4, 3,10)
    //Output :
    // g  =
    //
    //    0.3162
    // p  =
    //
    //  - 0.2071 - 0.8587i
    //  - 0.0042 - 0.9990i
    //  - 0.2071 + 0.8587i
    //  - 0.0042 + 0.9990i
    // z  =
    //
    //  - 1.3121i
    //  - 1.0063i
    //    1.3121i
    //    1.0063i

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
