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

function [n, Wc] = buttord(Wp, Ws, Rp, Rs)
    //Minimum filter order and 3dB cutoff frequency of a digital Butterworth filter with the desired response characteristics

    //Calling Sequence
    //n = buttord(Wp, Ws, Rp, Rs)
    //[n, Wc] = buttord(Wp, Ws, Rp, Rs)

    //Parameters
    //Wp: scalar or vector of length 2 (passband edge(s) ), elements must be in the range [0,1]
    //Ws: scalar or vector of length 2 (stopband edge(s) ), elements must be in the range [0,1]
    //Rp: passband ripple in dB.
    //Rs: stopband attenuation in dB.
    //n: Minimum filter order satisfying specs
    //Wc: 3dB cutoff frequency/frequencies

    //Description.
    //This function computes the minimum filter order of a Butterworth filter with the desired response characteristics.
    //The filter frequency band edges are specified by the passband frequency wp and stopband frequency ws.
    //Frequencies are normalized to the Nyquist frequency in the range [0,1].
    //Rp is measured in decibels and is the allowable passband ripple, and Rs is also in decibels and is the minimum attenuation in the stop band.
    //If ws>wp, the filter is a low pass filter. If wp>ws, the filter is a high pass filter.
    //If wp and ws are vectors of length 2, then the passband interval is defined by wp the stopband interval is defined by ws.
    //If wp is contained within the lower and upper limits of ws, the filter is a band-pass filter. If ws is contained within the lower and upper limits of wp the filter is a band-stop or band-reject filter.

    //Examples
    //Wp = 40/500 ;
    //Ws = 150/500 ;
    //[n, Wc] = buttord(Wp, Ws, 3, 60)
    //Output :
    // Wc  =
    //
    //    0.0800376
    // n  =
    //
    //    5.

    funcprot(0);
    [nargout nargin] = argn();

    if (nargin ~= 4)
        error("buttord: invalid number of inputs");
    else
        validate_filter_bands ("buttord", Wp, Ws);
    end

    if (length (Wp) == 2)
        warning ("buttord: seems to overdesign bandpass and bandreject filters");
    end

    T = 2;

    // if high pass, reverse the sense of the test
    stop = find(Wp > Ws);
    Wp(stop) = 1-Wp(stop); // stop will be at most length 1, so no need to
    Ws(stop) = 1-Ws(stop); // subtract from ones(1,length(stop))

    // warp the target frequencies according to the bilinear transform
    Ws = (2/T)*tan(%pi*Ws./T);
    Wp = (2/T)*tan(%pi*Wp./T);

    // compute minimum n which satisfies all band edge conditions
    // the factor 1/length(Wp) is an artificial correction for the
    // band pass/stop case, which otherwise significantly overdesigns.
    qs = log(10^(Rs/10) - 1);
    qp = log(10^(Rp/10) - 1);
    n = ceil(max(0.5*(qs - qp)./log(Ws./Wp))/length(Wp));

    // compute -3dB cutoff given Wp, Rp and n
    Wc = exp(log(Wp) - qp/2/n);

    // unwarp the returned frequency
    Wc = atan(T/2*Wc)*T/%pi;

    // if high pass, reverse the sense of the test
    Wc(stop) = 1-Wc(stop);

endfunction
