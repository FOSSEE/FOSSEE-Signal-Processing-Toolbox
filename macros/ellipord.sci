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
    //Minimum filter order of a digital elliptic or Cauer filter with the desired response characteristics.

    //Calling Sequence
    //[n] = ellipord(Wp, Ws, Rp, Rs)
    //[n, Wp] = ellipord(Wp, Ws, Rp, Rs)

    //Parameters
    //Wp: scalar or vector of length 2 (passband edge(s)), all elements must be in the range [0,1]
    //Ws: scalar or vector of length 2 (stopband edge(s)), all elements must be in the range [0,1]
    //Rp: passband ripple in dB.
    //Rs: stopband attenuation in dB.
    //n: Minimum order of filter satisfying given specs.

    //Description
    //This function computes the minimum filter order of an elliptic filter with the desired response characteristics.
    //Stopband frequency ws and passband frequency wp specify the the filter frequency band edges.
    //Frequencies are normalized to the Nyquist frequency in the range [0,1].
    //Rp is measured in decibels and is the allowable passband ripple and Rs is also measured in decibels and is the minimum attenuation in the stop band.
    //If ws>wp then the filter is a low pass filter. If wp>ws, then the filter is a high pass filter.
    //If wp and ws are vectors of length 2, then the passband interval is defined by wp and the stopband interval is defined by ws.
    //If wp is contained within the lower and upper limits of ws, the filter is a band-pass filter. If ws is contained within the lower and upper limits of wp, the filter is a band-stop or band-reject filter.
    //Examples
    //Wp = [60 200]/500;
    //Ws = [50 250]/500;
    //Rp = 3;
    //Rs = 40;
    //[n,Wp] = ellipord(Wp,Ws,Rp,Rs)
    //Output :
    // Wp  =
    //
    //    0.12    0.4
    // n  =
    //
    //    5.

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
