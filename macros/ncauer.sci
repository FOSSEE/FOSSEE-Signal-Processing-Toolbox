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

function [Zz, Zp, Zg] = ncauer(Rp, Rs, n)
//Analog prototype for Cauer filter (Cauer filter and elliptic filters are same).

//Calling Sequence
//[Zz, Zp, Zg] = ncauer(Rp, Rs, n)

//Parameters
//n: Filter Order
//Rp: Peak-to-peak passband ripple in dB
//Rs: Stopband attenuation in dB

//Description
//It gives an analog prototype for Cauer filter of nth order, with a Peak-to-peak passband ripple of Rp dB and a stopband attenuation of Rs dB.


//Examples
//n = 5;
//Rp = 5;
//Rs = 5;
//[Zz, Zp, Zg] = ncauer(Rp, Rs, n)

//Zz =
//
//   0.0000 + 2.5546i   0.0000 + 1.6835i  -0.0000 - 2.5546i  -0.0000 - 1.6835i
//
//Zp =
//
//  -0.10199 + 0.64039i  -0.03168 + 0.96777i  -0.10199 - 0.64039i  -0.03168 - 0.96777i  -0.14368 + 0.00000i
//
//Zg =  0.0030628


funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 3 | rhs > 3)
error("ncauer : Wrong number of input arguments.")
end

[Zz, Zp, Zg] = ellipap(n, Rp, Rs) ;

endfunction
