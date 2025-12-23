// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/signal/
// Modifieded by: Abinash Singh Under FOSSEE Internship
// Date of Modification: 3 Feb 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
function [Zz, Zp, Zg] = bilinear(Sz, Sp, Sg, T)
// Transform an s-plane filter (analog) into a z-plane filter (digital) using the bilinear transformation.
//
// Syntax
//   [Zb, Za] = bilinear(Sb, Sa, T)
//   [Zb, Zb] = bilinear(Sz, Sp, Sg, T)
//   [Zz, Zp, Zg] = bilinear(...)
//
// Parameters
// Sb: Numerator coefficient vector in the s-domain.
// Sa: Denominator coefficient vector in the s-domain.
// Sz: Zeros in the s-plane.
// Sp: Poles in the s-plane.
// Sg: Gain in the s-domain.
// T: Sampling period (double).
// Zb: Numerator coefficient vector in the z-domain.
// Za: Denominator coefficient vector in the z-domain.
// Zz: Zeros in the z-plane.
// Zp: Poles in the z-plane.
// Zg: Gain in the z-domain.
//
// Description
// This function transforms a filter design from the s-plane to the z-plane while maintaining the band edges using the bilinear transform. The mapping is non-linear, so the filter must be designed with band edges in the s-plane positioned at 2/T tan(w*T/2) to ensure correct positioning in the z-plane.
//It does following transformation from s-plane to z-plane
//                      2  z-1
//             s -> -  --------
//                      T  z+1
//
// Examples
// [b, a] = bilinear([1, 2, 3], [4, 5, 6], 1, 1)
//
// See also
// tf2zp
// postpad
// zp2tf
// prepad

    funcprot(0);
    [nargout nargin] = argn();
    ieee(2);

    if nargin==3
        T = Sg;
        //  FIXME : tf2zp is not tested yet
        [Sz, Sp, Sg] = tf2zp(Sz, Sp);
    elseif nargin~=4
        error("bilinear: invalid number of inputs")
    end

    p = length(Sp);
    z = length(Sz);
    if z > p | p==0
        error("bilinear: must have at least as many poles as zeros in s-plane");
    end

    // ----------------  -------------------------  ------------------------
    // Bilinear          zero: (2+xT)/(2-xT)        pole: (2+xT)/(2-xT)
    //      2 z-1        pole: -1                   zero: -1
    // S -> - ---        gain: (2-xT)/T             gain: (2-xT)/T
    //      T z+1
    // ----------------  -------------------------  ------------------------
    Zg = real(Sg * prod((2-Sz*T)/T) / prod((2-Sp*T)/T));

    if Zg == 0 & nargout == 3 then
        error("bilinear: invalid value of gain due to zero(s) at infinity avoid z-p-g form and use tf form ")
    end
    Zp = (2+Sp*T)./(2-Sp*T);
    SZp = size(Zp);
    if isempty(Sz)
        Zz = -ones(SZp(1), SZp(2));
    else
        Zz = [(2+Sz*T)./(2-Sz*T)];
        Zz = postpad(Zz, p, -1);
    end
    if nargout==2
        // zero at infinity
        Zz1 = [];
        for i=1:length(Zz)
            if Zz(i) ~= %inf
                Zz1 = [Zz1 Zz(i)];
            end
        end
        Zz = Zz1;

        if Zg == 0
            z = %z;
            bi = (2*(z - 1))/(T*(z + 1));
            Hs = Sg * real(poly(Sz, "s"))/real(poly(Sp, "s"));
            Hz = horner(Hs, bi);
            b = coeff(Hz.num);
            a = coeff(Hz.den);
            Zg = b($)/a($);
        end

        [Zz, Zp] = zp2tf(Zz, Zp, Zg);
        Zz = prepad(Zz, length(Zp));
    end
ieee(0);
endfunction
/*
// FIXME- not working with three argument

Note : This function is tested with Octave's outputs as a reference.

[Zb,Za] = bilinear([1 0],[1 1],1,0.5) // passed 
[Zb, Za] = bilinear([], [], 1, 1) // error PASSED
[Zb, Za] = bilinear([0], [], 1, 0.5) // error PASSED
[Zb, Za] = bilinear([], [0], 1, 0.5) // PASSED

[Zb, Za] = bilinear([2], [1], 1, 0.5) // PASSED
[Zb, Za] = bilinear([1; -1], [0.5; -0.5], 2, 1) //PASSED
[Zb, Za] = bilinear([0], [1], 1, 1) //PASSED
*/