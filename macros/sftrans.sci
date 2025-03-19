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
function [Sz, Sp, Sg] = sftrans (Sz, Sp, Sg, W, stop)
    //Transform band edges of a prototype filter (cutoff at W=1) represented in s-plane zero-pole-gain form (Frequency Transformation in Analog domain).

    //Calling Sequence
    //[Sz, Sp, Sg] = sftrans (Sz, Sp, Sg, W, stop)
    //[Sz, Sp] = sftrans (Sz, Sp, Sg, W, stop)
    //[Sz] = sftrans (Sz, Sp, Sg, W, stop)

    //Parameters
    //Sz: Zeros.
    //Sp: Poles.
    //Sg: Gain.
    //W: Edge freuency of target filter.
    //stop: True(%T or 1) for high pass and band stop filters or false (%F or 0) for low pass and band pass filters.

    //Description
    //Theory: Given a low pass filter represented by poles and zeros in the splane, you can convert it to a low pass, high pass, band pass or band stop by transforming each of the poles and zeros individually. The following table summarizes the transformation:

    // Transform         Zero at x                  Pole at x
    // ----------------  -------------------------  ------------------------
    // Low Pass          zero: Fc x/C               pole: Fc x/C
    // S -> C S/Fc       gain: C/Fc                 gain: Fc/C
    // ----------------  -------------------------  ------------------------
    // High Pass         zero: Fc C/x               pole: Fc C/x
    // S -> C Fc/S       pole: 0                    zero: 0
    //                   gain: -x                   gain: -1/x
    // ----------------  -------------------------  ------------------------
    // Band Pass         zero: b +- sqrt(b^2-FhFl)  pole: b +- sqrt(b^2-FhFl)
    //        S^2+FhFl   pole: 0                    zero: 0
    // S -> C --------   gain: C/(Fh-Fl)            gain: (Fh-Fl)/C
    //        S(Fh-Fl)   b=x/C (Fh-Fl)/2            b=x/C (Fh-Fl)/2
    // ----------------  -------------------------  ------------------------
    // Band Stop         zero: b +- sqrt(b^2-FhFl)  pole: b +- sqrt(b^2-FhFl)
    //        S(Fh-Fl)   pole: +-sqrt(-FhFl)        zero: +-sqrt(-FhFl)
    // S -> C --------   gain: -x                   gain: -1/x
    //        S^2+FhFl   b=C/x (Fh-Fl)/2            b=C/x (Fh-Fl)/2
    // ----------------  -------------------------  ------------------------
    // Bilinear          zero: (2+xT)/(2-xT)        pole: (2+xT)/(2-xT)
    //      2 z-1        pole: -1                   zero: -1
    // S -> - ---        gain: (2-xT)/T             gain: (2-xT)/T
    //      T z+1
    // ----------------  -------------------------  ------------------------
    //
    //where C is the cutoff frequency of the initial lowpass filter, Fc is the edge of the target low/high pass filter and [Fl,Fh] are the edges of the target band pass/stop filter. With abundant tedious
    //algebra, you can derive the above formulae yourself by substituting the transform for S into H(S)=S-x for a zero at x or H(S)=1/(S-x) for a pole at x, and converting the result into the form:
    //
    //    H(S)=g prod(S-Xi)/prod(S-Xj)


    //Examples
      //[Sz, Sp, Sg] = sftrans([1 2 3], [4 5 6], 15, 20, %T)
    // Output
    // Sg  =
    //
    //    0.75
    // Sp  =
    //
    //    5.    4.    3.3333333
    // Sz  =
    //
    //    20.    10.    6.6666667
    // dependencies
    // 
    funcprot(0);
    [nargout nargin]= argn();

    if (nargin ~= 5)
        error("sftrans: Wrong number of input arguments.")
    end

    if stop == %T then
    elseif stop == %F
    elseif stop == 1
    elseif stop == 0
    else
        error("sftrans: stop must be true (%T or 1) or false (%F or 0)")
    end

    C = 1;
    p = length(Sp);
    z = length(Sz);
    if z > p | p == 0
        error("sftrans: must have at least as many poles as zeros in s-plane");
    end

    if length(W)==2
        Fl = W(1);
        Fh = W(2);
        if stop
            // ----------------  -------------------------  ----------------------
            // Band Stop         zero: b ± sqrt(b^2-FhFl)   pole: b ± sqrt(b^2-FhFl)
            //        S(Fh-Fl)   pole: ±sqrt(-FhFl)         zero: ±sqrt(-FhFl)
            // S -> C --------   gain: -x                   gain: -1/x
            //        S^2+FhFl   b=C/x (Fh-Fl)/2            b=C/x (Fh-Fl)/2
            // ----------------  -------------------------  ----------------------
            if (isempty(Sz))
                Sg = Sg * real (1 ./ prod(-Sp));
            elseif (isempty(Sp))
                Sg = Sg * real(prod(-Sz));
            else
                Sg = Sg * real(prod(-Sz)/prod(-Sp));
            end
            b = (C*(Fh-Fl)/2)./Sp;
            Sp = [b+sqrt(b.^2-Fh*Fl), b-sqrt(b.^2-Fh*Fl)];
            extend = [sqrt(-Fh*Fl), -sqrt(-Fh*Fl)];
            if isempty(Sz)
                Sz = [extend(1+modulo([1:2*p],2))];
            else
                b = (C*(Fh-Fl)/2)./Sz;
                Sz = [b+sqrt(b.^2-Fh*Fl), b-sqrt(b.^2-Fh*Fl)];
                if (p > z)
                    Sz = [Sz, extend(1+modulo([1:2*(p-z)],2))];
                end
            end
        else
            // ----------------  -------------------------  ----------------------
            // Band Pass         zero: b ± sqrt(b^2-FhFl)   pole: b ± sqrt(b^2-FhFl)
            //        S^2+FhFl   pole: 0                    zero: 0
            // S -> C --------   gain: C/(Fh-Fl)            gain: (Fh-Fl)/C
            //        S(Fh-Fl)   b=x/C (Fh-Fl)/2            b=x/C (Fh-Fl)/2
            // ----------------  -------------------------  ----------------------
            Sg = Sg * (C/(Fh-Fl))^(z-p);
            b = Sp*((Fh-Fl)/(2*C));
            Sp = [b+sqrt(b.^2-Fh*Fl), b-sqrt(b.^2-Fh*Fl)];
            if isempty(Sz)
                Sz = zeros(1,p);
            else
                b = Sz*((Fh-Fl)/(2*C));
                Sz = [b+sqrt(b.^2-Fh*Fl), b-sqrt(b.^2-Fh*Fl)];
                if (p>z)
                    Sz = [Sz, zeros(1, (p-z))];
                end
            end
        end
    else
        Fc = W;
        if stop
            // ----------------  -------------------------  ----------------------
            // High Pass         zero: Fc C/x               pole: Fc C/x
            // S -> C Fc/S       pole: 0                    zero: 0
            //                   gain: -x                   gain: -1/x
            // ----------------  -------------------------  ----------------------
            if (isempty(Sz))
                Sg = Sg * real (1 ./ prod(-Sp));
            elseif (isempty(Sp))
                Sg = Sg * real(prod(-Sz));
            else
                Sg = Sg * real(prod(-Sz)/prod(-Sp));
            end
            Sp = C * Fc ./ Sp;
            if isempty(Sz)
                Sz = zeros(1,p);
            else
                Sz = [C * Fc ./ Sz];
                if (p > z)
                    Sz = [Sz, zeros(1,p-z)];
                end
            end
        else
            // ----------------  -------------------------  ----------------------
            // Low Pass          zero: Fc x/C               pole: Fc x/C
            // S -> C S/Fc       gain: C/Fc                 gain: Fc/C
            // ----------------  -------------------------  ----------------------
            Sg = Sg * (C/Fc)^(z-p);
            Sp = Fc * Sp / C;
            Sz = Fc * Sz / C;
        end
    end
endfunction
/**
Note : This function is tested with Octave's outputs as a reference.

[Sz_new , Sp_new , Sg_new ] = sftrans([0.5;-0.5],[0.3 ; -0.3],2,0.5,0) // passed
[Sz_new , Sp_new , Sg_new ] = sftrans([0.5;-0.5],[0.3 ; -0.3],2,0.5,1)  // passed
[Sz_new, Sp_new, Sg_new] = sftrans([0.5], [0.3], 1, [1.0, 2.0], 0)      //passed
[Sz_new, Sp_new, Sg_new] = sftrans([0.5], [0.3], 1, [1.0, 2.0], 1) //passed
[Sz_new, Sp_new, Sg_new] = sftrans([], [], 1, 1.0, 0) //error passed
[Sz_new, Sp_new, Sg_new] = sftrans([0], [], 1, 1.0, 0)//error passed
*/