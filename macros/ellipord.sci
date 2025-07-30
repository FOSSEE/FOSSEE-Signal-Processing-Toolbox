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

function [n, Wp] = ellipord(Wp, Ws, Rp, Rs)
// Compute the minimum filter order of a digital elliptic or Cauer filter with the desired response characteristics.
//
// Syntax
//   [n] = ellipord(Wp, Ws, Rp, Rs)
//   [n, Wp] = ellipord(Wp, Ws, Rp, Rs)
//
// Parameters
// Wp: Scalar or vector of length 2. Specifies the passband edge(s). All elements must be in the range [0, 1].
// Ws: Scalar or vector of length 2. Specifies the stopband edge(s). All elements must be in the range [0, 1].
// Rp: Non-negative scalar. The passband ripple in decibels (dB).
// Rs: Non-negative scalar. The stopband attenuation in decibels (dB).
// n: Positive integer. The minimum order of the filter satisfying the given specifications.
//
// Description
// This function computes the minimum filter order of an elliptic filter with the desired response characteristics.
// - Stopband frequency `Ws` and passband frequency `Wp` specify the filter frequency band edges.
// - Frequencies are normalized to the Nyquist frequency in the range [0, 1].
// - `Rp` is measured in decibels and represents the allowable passband ripple.
// - `Rs` is measured in decibels and represents the minimum attenuation in the stopband.
// - If `Ws > Wp`, the filter is a lowpass filter. If `Wp > Ws`, the filter is a highpass filter.
// - If `Wp` and `Ws` are vectors of length 2, the passband interval is defined by `Wp` and the stopband interval is defined by `Ws`.
// - If `Wp` is contained within the lower and upper limits of `Ws`, the filter is a bandpass filter.
// - If `Ws` is contained within the lower and upper limits of `Wp`, the filter is a bandstop or band-reject filter.
//
// Examples
// // Bandpass filter:
//    Wp = [60 200]/500
//    Ws = [50 250]/500
//    Rp = 3
//    Rs = 40
//    [n, Wp] = ellipord(Wp, Ws, Rp, Rs)
//



    funcprot(0);
    [nargout nargin] = argn();

    if (nargin ~= 4)
        error("ellipord: invalid number of inputs");
    else
        validate_filter_bands ("ellipord", Wp, Ws);
    end

    // sampling frequency of 2 Hz
    T = 2;

    Wpw = tan(%pi.*Wp./T); // prewarp
    Wsw = tan(%pi.*Ws./T); // prewarp

    // pass/stop band to low pass filter transform:
    if (length(Wpw)==2 & length(Wsw)==2)
        wp=1;
        w02 = Wpw(1) * Wpw(2);      // Central frequency of stop/pass band (square)
        w3 = w02/Wsw(2);
        w4 = w02/Wsw(1);
        if (w3 > Wsw(1))
            ws = (Wsw(2)-w3)/(Wpw(2)-Wpw(1));
        elseif (w4 < Wsw(2))
            ws = (w4-Wsw(1))/(Wpw(2)-Wpw(1));
        else
            ws = (Wsw(2)-Wsw(1))/(Wpw(2)-Wpw(1));
        end
    elseif (Wpw > Wsw)
        wp = Wsw;
        ws = Wpw;
    else
        wp = Wpw;
        ws = Wsw;
    end

    k=wp/ws;
    k1=sqrt(1-k^2);
    q0=(1/2)*((1-sqrt(k1))/(1+sqrt(k1)));
    q= q0 + 2*q0^5 + 15*q0^9 + 150*q0^13; //(....)
    D=(10^(0.1*Rs)-1)/(10^(0.1*Rp)-1);

    n=ceil(log10(16*D)/log10(1/q));

endfunction
