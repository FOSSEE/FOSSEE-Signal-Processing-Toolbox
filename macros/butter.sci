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

function [a, b, c, d] = butter (n, w, varargin)
    //Butterworth filter design.

    //Calling Sequence
    //[b, a] = butter (n, wc)
    //[b, a] = butter (n, wc, "high")
    //[b, a] = butter (n, [wl, wh])
    //[b, a] = butter (n, [wl, wh], "stop")
    //[z, p, g] = butter (…)
    //[…] = butter (…, "s")

    //Parameters
    //n: positive integer value (order of filter)
    //wc: positive real value,
    //    1).Normalised digital 3dB cutoff frequency/frequencies for digital filter, in the range [0, 1] {dimensionless}
    //    2).Analog 3dB cutoff frequency/frequencies for analog filter, in the range [0, Inf] {rad/sec}

    //Description
    //This function generates a Butterworth filter. Default is a discrete space (z) or digital filter using Bilinear transformation from s to z plane.
    //If second argument is scalar the third parameter takes in low or high, default value is low. The cutoff is pi*wc radians.
    //[b,a] = butter(n, [wl, wh]) indicates a band pass filter with cutoffs pi*Wl and pi*wh radians.
    //[b,a] = butter(n, [wl, wh], ’stop’) indicates a band reject filter with cutoffs pi*wl and pi*wh radians.
    //[z,p,g] = butter(...) returns filter as zero-pole-gain rather than coefficients of the numerator and denominator polynomials.
    //[...] = butter(...,’s’) returns a Laplace space filter,here cutoff(s) wc can be larger than 1 (rad/sec).

    //Examples
    //[b a] = butter(4,0.3,"high")
    //Output
    // a  =
    //
    //
    //         column 1 to 4
    //
    //    1.  - 1.5703989    1.2756133  - 0.4844034
    //
    //         column 5
    //
    //    0.0761971
    // b  =
    //
    //
    //         column 1 to 4
    //
    //    0.2754133  - 1.1016532    1.6524797  - 1.1016532
    //
    //         column 5
    //
    //    0.2754133


    funcprot();
    [nargout  nargin] = argn();
    if (nargin > 4 | nargin < 2 | nargout > 4 | nargout < 2)
        error("butter: Invalid number of input argument")
    end

    // interpret the input parameters
    if (~ (isscalar (n) & (n == fix (n)) & (n > 0)))
        error ("butter: filter order N must be a positive integer");
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
            error ("butter: expected [high|stop] or [s|z]");
        end
    end

    [rows_w columns_w] = size(w);

    if (~ ((length (w) <= 2) & (rows_w == 1 | columns_w == 1)))
        error ("butter: frequency must be given as WC or [WL, WH]");
    elseif ((length (w) == 2) & (w(2) <= w(1)))
        error ("butter: W(1) must be less than W(2)");
    end

    if (digital & ~ and ((w >= 0) & (w <= 1)))
        error ("butter: all elements of W must be in the range [0,1] for digital filter");
    elseif (~ digital & ~ and (w >= 0))
        error ("butter: all elements of W must be in the range [0,inf] for analog filter");
    end

    // Prewarp to the band edges to s plane
    if (digital)
        T = 2;       // sampling frequency of 2 Hz
        w = 2 / T * tan (%pi * w / T);
    end

    // Generate splane poles for the prototype Butterworth filter
    // source: Kuc
    C = 1;  // default cutoff frequency
    pole = C * exp (1*%i * %pi * (2 * [1:n] + n - 1) / (2 * n));
    if (pmodulo (n, 2) == 1)
        pole((n + 1) / 2) = -1;  // pure real value at exp(%i*%pi)
    end
    zero = [];
    gain = C^n;

    // splane frequency transform
    [zero, pole, gain] = sftrans (zero, pole, gain, w, stop);

    // Use bilinear transform to convert poles to the z plane
    if (digital)
        [zero, pole, gain] = bilinear (zero, pole, gain, T);
    end

    // convert to the correct output form
    if (nargout == 2)
        // a = real (gain * poly (zero));
        // b = real (poly (pole));
        [a b] = zp2tf(zero, pole, gain);
    elseif (nargout == 3)
        a = zero;
        b = pole;
        c = gain;
    else
        // output ss results
        //[a, b, c, d] = zp2ss (zero, pole, gain);
        error("butter: yet not implemented in state-space form OR invalid number of o/p arguments")
    end
endfunction
