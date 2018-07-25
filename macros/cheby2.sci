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

function [a, b, c, d] = cheby2 (n, rs, w, varargin)
    //Chebyshev type II filter design with rs dB of stopband attenuation.

    //Calling Sequence
    //[b, a] = cheby2 (n, rs, ws)
    //[b, a] = cheby2 (n, rs, ws, "high")
    //[b, a] = cheby2 (n, rs, [wl, wh])
    //[b, a] = cheby2 (n, rs, [wl, wh], "stop")
    //[z, p, g] = cheby2 (…)
    //[…] = cheby2 (…, "s")

    //Parameters
    //n: positive integer value (order of filter)
    //rs: non negative scalar value (stopband attenuation in dB)
    //ws: positive real value,
    //    1).Normalised digital stopband edge(s) for digital filter, in the range [0, 1] {dimensionless}
    //    2).Analog stopband edge(s) for analog filter, in the range [0, Inf] {rad/sec}

    //Description
    //This function generates a Chebyshev type II filter with rs dB of stopband attenuation.
    //The fourth parameter takes in high or low, default value is low. The cutoff is pi*Wc radians.
    //[b, a] = cheby2(n, Rp, [Wl, Wh]) indicates a band pass filter with edges pi*Wl and pi*Wh radians.
    //[b, a] = cheby2(n, Rp, [Wl, Wh], ’stop’) indicates a band reject filter with edges pi*Wl and pi*Wh radians.
    //[z, p, g] = cheby2(...) returns filter as zero-pole-gain rather than coefficients of the numerator and denominator polynomials.
    //[...] = cheby2(...,’s’) returns a Laplace space filter, w can be larger than 1.

    //Examples
    //[z, p, g]=cheby2(2,5,0.7,"high")
    //Output:
    // g  =
    //
    //    0.4752770
    // p  =
    //
    //  - 0.3938806 + 0.5313815i  - 0.3938806 - 0.5313815i
    // z  =
    //
    //  - 0.3164543 - 0.9486078i  - 0.3164543 + 0.9486078i

    funcprot(0);
    [nargout nargin] = argn();

    if (nargin > 5 | nargin < 3 | nargout > 4 | nargout < 2)
        error("cheby2: invalid number of inputs");
    end

    // interpret the input parameters
    if (~ (isscalar (n) & (n == fix (n)) & (n > 0)))
        error ("cheby2: filter order N must be a positive integer");
    end

    stop = %F;
    digital = %T;
    for i = 1:length(varargin)
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
            error ("cheby2: expected [high|stop] or [s|z]");
        end
    end

    [rows_w columns_w] = size(w);

    if (~ ((length (w) <= 2) & (rows_w == 1 | columns_w == 1)))
        error ("cheby2: frequency must be given as WS or [WL, WH]");
    elseif ((length (w) == 2) & (w(2) <= w(1)))
        error ("cheby2: W(1) must be less than W(2)");
    end

    if (digital & ~ and ((w >= 0) & (w <= 1)))
        error ("cheby2: all elements of W must be in the range [0,1]");
    elseif (~ digital & ~ and (w >= 0))
        error ("cheby2: all elements of W must be in the range [0,inf]");
    end

    if (~ (isscalar (rs) & or(type(rs) == [1 5 8]) & (rs >= 0)))
        error ("cheby2: stopband attenuation RS must be a non-negative scalar");
    end

    // Prewarp to the band edges to s plane
    if (digital)
        T = 2;       // sampling frequency of 2 Hz
        w = 2 / T * tan (%pi * w / T);
    end

    // Generate splane poles and zeros for the Chebyshev type 2 filter
    // From: Stearns, SD; David, RA; (1988). Signal Processing Algorithms.
    //       New Jersey: Prentice-Hall.
    C = 1;  // default cutoff frequency
    lambda = 10^(rs / 20);
    phi = log (lambda + sqrt (lambda^2 - 1)) / n;
    theta = %pi * ([1:n] - 0.5) / n;
    alpha = -sinh (phi) * sin (theta);
    beta = cosh (phi) * cos (theta);
    if (modulo (n, 2))
        // drop theta==pi/2 since it results in a zero at infinity
        zero = 1*%i * C ./ cos (theta([1:(n - 1) / 2, (n + 3) / 2:n]));
    else
        zero = 1*%i * C ./ cos (theta);
    end
    pole = C ./ (alpha.^2 + beta.^2) .* (alpha - 1*%i * beta);

    // Compensate for amplitude at s=0
    // Because of the vagaries of floating point computations, the
    // prod(pole)/prod(zero) sometimes comes out as negative and
    // with a small imaginary component even though analytically
    // the gain will always be positive, hence the abs(real(...))
    gain = abs (real (prod (pole) / prod (zero)));

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
        //[a, b, c, d] = zp2ss (zero, pole, gain);
        error("cheby2: yet not implemented in state-space form OR invalid number of o/p arguments")
    end
endfunction
