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

function [a, b, c, d] = ellip (n, rp, rs, w, varargin)
    //Elliptic or Cauer filter design with rp dB of passband ripple and rs dB of stopband attenuation.

    //Calling Sequence
    //[b, a] = ellip (n, rp, rs, wp)
    //[b, a] = ellip (n, rp, rs, wp, "high")
    //[b, a] = ellip (n, rp, rs, [wl, wh])
    //[b, a] = ellip (n, rp, rs, [wl, wh], "stop")
    //[z, p, g] = ellip (…)
    //[…] = ellip (…, "s")

    //Parameters
    //n: positive integer value (order of filter)
    //rp: non negative scalar value (passband ripple)
    //rs: non negative scalar value (stopband attenuation)
    //wp: positive real value,
    //    1).Normalised digital passband edge(s) for digital filter, in the range [0, 1] {dimensionless}
    //    2).Analog passband edge(s) for analog filter, in the range [0, Inf] {rad/sec}

    //Description
    //This function generates an elliptic or Cauer filter with rp dB of passband ripple and rs dB of stopband attenuation.
    //[b, a] = ellip(n, Rp, Rs, Wp) indicates low pass filter with order n, Rp decibels of ripple in the passband and a stopband Rs decibels down and cutoff of pi*Wp radians. If the fifth argument is high, then the filter is a high pass filter.
    //[b, a] = ellip(n, Rp, Rs, [Wl, Wh]) indictaes band pass filter with band pass edges pi*Wl and pi*Wh. If the fifth argument is stop, the filter is a band reject filter.
    //[z, p, g] = ellip(...) returns filter as zero-pole-gain.
    //[...] = ellip(...,’s’) returns a Laplace space filter, wp can be larger than 1.

    //Examples
    //[b, a]=ellip(2, 3, 40, [0.3,0.4])
    //Output :
    // a  =
    //
    //
    //         column 1 to 4
    //
    //    1.  - 1.7258519    2.5097172  - 1.5592802
    //
    //         column 5
    //
    //    0.8188057
    // b  =
    //
    //
    //         column 1 to 4
    //
    //    0.0202774  - 0.0164257    0.0027304  - 0.0164257
    //
    //         column 5
    //
    //    0.0202774

    funcprot(0);
    [nargout nargin] = argn();

    if (nargin > 6 | nargin < 4 | nargout > 4 | nargout < 2)
        error("ellip: invalid number of inputs");
    end

    // interpret the input parameters
    if (~ (isscalar (n) & (n == fix (n)) & (n > 0)))
        error ("ellip: filter order N must be a positive integer");
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
            error ("ellip: expected [high|stop] or [s|z]");
        end
    end

    [rows_w colums_w] = size(w);

    if (~ ((length (w) <= 2) & (rows_w == 1 | columns_w == 1)))
        error ("ellip: frequency must be given as WP or [WL, WH]");
    elseif ((length (w) == 2) & (w(2) <= w(1)))
        error ("ellip: W(1) must be less than W(2)");
    end

    if (digital & ~ and ((w >= 0) & (w <= 1)))
        error ("ellip: all elements of W must be in the range [0,1]");
    elseif (~ digital & ~ and (w >= 0))
        error ("ellip: all elements of W must be in the range [0,inf]");
    end

    if (~ (isscalar (rp) & or(type(rp) == [1 5 8]) & (rp >= 0)))
        error ("ellip: passband ripple RP must be a non-negative scalar");
    end

    if (~ (isscalar (rs) & or(type(rs) == [1 5 8]) & (rs >= 0)))
        error ("ellip: stopband attenuation RS must be a non-negative scalar");
    end


    // Prewarp the digital frequencies
    if (digital)
        T = 2;       // sampling frequency of 2 Hz
        w = 2 / T * tan (%pi * w / T);
    end

    // Generate s-plane poles, zeros and gain
    [zero, pole, gain] = ellipap (n, rp, rs);
    zero = zero';
    pole = pole';

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
        error("ellip: yet not implemented in state-space form OR invalid number of o/p arguments")
    end
endfunction
