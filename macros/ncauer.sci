// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/
// Modifieded by: Abinash Singh Under FOSSEE Internship
// Last Modified on : 3 Feb 2024
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
    // Dependencies
    // ellipap
    
    funcprot(0);
    lhs = argn(1)
    rhs = argn(2)
    if (rhs < 3 | rhs > 3)
    error("ncauer : Wrong number of input arguments.")
    end
    
    [Zz, Zp, Zg] = ellipap(n, Rp, Rs) ;
    // temp fix to permanently fix this change ellipap
    Zz = Zz';
    Zp = Zp';

    endfunction

/* 

// Test Case 1 (ncauer 0.1, 60, 7)
[z, p, g] = ncauer(0.1, 60, 7);
assert_checkalmostequal(z, [2.5574 1.5522 1.3295 -2.5574 -1.5522 -1.3295]*%i, 1e-2);
assert_checkalmostequal(p, [-0.3664+0.5837*%i -0.1802+0.9088*%i -0.0499+1.0285*%i -0.3664-0.5837*%i -0.1802-0.9088*%i -0.0499-1.0285*%i -0.4796], 1e-2);
assert_checkalmostequal(g, 7.4425e-03, 1e-2);

// Test Case 2 (ncauer 1.0, 30, 3)
[z, p, g] = ncauer(1.0, 30, 3);
assert_checkalmostequal(z, [1.9536 -1.9536]*%i, 1e-2);
assert_checkalmostequal(p, [-0.2053+0.9870*%i -0.2053-0.9870*%i -0.5597], 1e-2);
assert_checkalmostequal(g, 0.1490, 1e-2);

// Test Case 3 (ncauer 0.25, 50, 6)
[z, p, g] = ncauer(0.25, 50, 6);
assert_checkalmostequal(z, [4.0596 1.6414 1.3142 -4.0596 -1.6414 -1.3142]*%i, 1e-2);
assert_checkalmostequal(p, [-0.4210+0.3665*%i -0.2117+0.8503*%i -0.0550+1.0198*%i -0.4210-0.3665*%i -0.2117-0.8503*%i -0.0550-1.0198*%i], 1e-2);
assert_checkalmostequal(g, 3.1618e-03, 1e-2);

// Test Case 4 (ncauer 0.8, 45, 4)
[z, p, g] = ncauer(0.8, 45, 4);
assert_checkalmostequal(z, [4.1768 1.8543 -4.1768 -1.8543]*%i, 1e-2);
assert_checkalmostequal(p, [-0.3861+0.4640*%i -0.1234+1.0000*%i -0.3861-0.4640*%i -0.1234-1.0000*%i], 1e-2);
assert_checkalmostequal(g, 5.6237e-03, 1e-2);

*/