// Copyright (C) 2018 - IIT Bombay - FOSSEE
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/signal/
// Modifieded by:Sonu Sharma, RGIT Mumbai
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in

function [a, b, c, d] = cheby1 (n, rp, w, varargin)
    //Chebyshev type I filter design with rp dB of passband ripple.

    //Calling Sequence
    //[b, a] = cheby1 (n, rp, wp)
    //[b, a] = cheby1 (n, rp, wp, "high")
    //[b, a] = cheby1 (n, rp, [wl, wh])
    //[b, a] = cheby1 (n, rp, [wl, wh], "stop")
    //[z, p, g] = cheby1 (…)
    //[…] = cheby1 (…, "s")

    //Parameters
    //n: positive integer value (order of filter)
    //rp: non negative scalar value (passband ripple)
    //wp: positive real value,
    //    1).Normalised digital passband edge(s) for digital filter, in the range [0, 1] {dimensionless}
    //    2).Analog passband edge(s) for analog filter, in the range [0, Inf] {rad/sec}

    //Description
    //This function generates a Chebyshev type I filter with rp dB of passband ripple.
    //if second parameter is scalar the fourth parameter takes in high or low, default value is low. The cutoff is pi*Wc radians.
    //[b, a] = cheby1(n, Rp, [Wl, Wh]) indicates a band pass filter with edges pi*Wl and pi*Wh radians.
    //[b, a] = cheby1(n, Rp, [Wl, Wh], ’stop’) indicates a band reject filter with edges pi*Wl and pi*Wh radians.
    //[z, p, g] = cheby1(...) returns filter as zero-pole-gain rather than coefficients of the numerator and denominator polynomials.
    //[...] = cheby1(...,’s’) returns a Laplace space filter, w can be larger than 1 rad/sec.

    //Examples
    //[z, p, k]=cheby1(2,6,0.7,"high")
    // k  =
    //
    //    0.0556491
    // p  =
    //
    //  - 0.6291539 + 0.5537247i  - 0.6291539 - 0.5537247i
    // z  =
    //
    //    1.    1.

    funcprot(0);
    [nargout nargin] = argn();

    if (nargin > 5 | nargin < 3 | nargout > 4 | nargout < 2)
        error("cheby1: invalid number of inputs");
    end

    // interpret the input parameters
    if (~ (isscalar (n) & (n == fix (n)) & (n > 0)))
        error ("cheby1: filter order N must be a positive integer");
    end

    stop = %F;
    digital = %T;
    for i = 1:length (varargin)
        select (varargin(i))
        case "s"
            digital = %F;
        case "z"
            digital = %T;
        case "high"
            stop = %T;
        case "stop"
            stop = %T;
        case "low"
            stop = %T;
        case "pass"
            stop = %F;
        else
            error ("cheby1: expected [high|stop] or [s|z]");
        end
    end

    [rows_w columns_w] = size(w);

    if (~ ((length (w) <= 2) & (rows_w == 1 | columns_w == 1)))
        error ("cheby1: frequency must be given as WP or [WL, WH]");
    elseif ((length (w) == 2) & (w(2) <= w(1)))
        error ("cheby1: W(1) must be less than W(2)");
    end

    if (digital & ~ and ((w >= 0) & (w <= 1)))
        error ("cheby1: all elements of W must be in the range [0,1]");
    elseif (~ digital & ~ and (w >= 0))
        error ("cheby1: all elements of W must be in the range [0,inf]");
    end

    if (~ (isscalar (rp) & or(type (rp) == [1 5 8]) & (rp >= 0)))
        error ("cheby1: passband ripple RP must be a non-negative scalar");
    end

    // Prewarp to the band edges to s plane
    if (digital)
        T = 2;       // sampling frequency of 2 Hz
        w = 2 / T * tan (%pi * w / T);
    end

    // Generate splane poles and zeros for the Chebyshev type 1 filter
    C = 1;  // default cutoff frequency
    epsilon = sqrt (10^(rp / 10) - 1);
    v0 = asinh (1 / epsilon) / n;
    pole = exp (1*%i * %pi * [-(n - 1):2:(n - 1)] / (2 * n));
    pole = -sinh (v0) * real (pole) + 1*%i * cosh (v0) * imag (pole);
    zero = [];



    // compensate for amplitude at s=0
    gain = prod (-pole);
    // if n is even, the ripple starts low, but if n is odd the ripple
    // starts high. We must adjust the s=0 amplitude to compensate.
    if (modulo (n, 2) == 0)
        gain = gain / 10^(rp / 20);
    end


    // splane frequency transform
    [zero, pole, gain] = sftrans (zero, pole, gain, w, stop);


    // Use bilinear transform to convert poles to the z plane
    if (digital)
        [zero, pole, gain] = bilinear (zero, pole, gain, T);
    end

    // convert to the correct output form
    if (nargout == 2)
        [a b] = zp2tf(zero, pole, gain);
    elseif (nargout == 3)
        a = zero;
        b = pole;
        c = gain;
    else
        // output ss results
        //        [a, b, c, d] = zp2ss (zero, pole, gain);
        error("cheby1: yet not implemented in state-space form OR invalid number of o/p arguments")
    end

endfunction
