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
function [n, Wc] = cheb1ord(Wp, Ws, Rp, Rs)
    //Minimum filter order of a digital Chebyshev type I filter with the desired response characteristics.

    //Calling Sequence
    //n = cheb1ord(Wp, Ws, Rp, Rs)
    //[n, Wp] = cheb1ord(Wp, Ws, Rp, Rs)

    //Parameters
    //Wp: scalar or vector of length 2 (passband edge(s)), all elements must be in the range [0,1]
    //Ws: scalar or vector of length 2 (stopband edge(s)), all elements must be in the range [0,1]
    //Rp: passband ripple in dB.
    //Rs: stopband attenuation in dB.
    //n: Minimum filter order satisfying specs
    //Wp: passband edge(s)

    //Description
    //This function computes the minimum filter order of a Chebyshev type I filter with the desired response characteristics.
    //Stopband frequency ws and passband frequency wp specify the the filter frequency band edges.
    //Frequencies are normalized to the Nyquist frequency in the range [0,1].
    //Rp is measured in decibels and is the allowable passband ripple and Rs is also measured in decibels and is the minimum attenuation in the stop band.
    //If ws>wp then the filter is a low pass filter. If wp>ws, then the filter is a high pass filter.
    //If wp and ws are vectors of length 2, then the passband interval is defined by wp and the stopband interval is defined by ws.
    //If wp is contained within the lower and upper limits of ws, the filter is a band-pass filter. If ws is contained within the lower and upper limits of wp, the filter is a band-stop or band-reject filter.

    //Examples
    //[n, wp]=cheb1ord([0.25 0.3],[0.24 0.31],3,10)
    // wp  =
    //
    //    0.25    0.3
    // n  =
    //
    //    3.

    funcprot(0);
    [nargout nargin] = argn();

    if nargin ~= 4
        error("cheb1ord: invalid number of inputs");
    else
        validate_filter_bands ("cheb1ord", Wp, Ws);
    end

    T = 2;

    // returned frequency is the same as the input frequency
    Wc = Wp;

    // warp the target frequencies according to the bilinear transform
    Ws = (2/T)*tan(%pi*Ws./T);
    Wp = (2/T)*tan(%pi*Wp./T);

    if (Wp(1) < Ws(1))
        // low pass
        if (length(Wp) == 1)
            Wa = Ws/Wp;
        else
            // FIXME: Implement band reject filter type
            error ("cheb1ord: band reject is not yet implemented");
        end;
    else
        // if high pass, reverse the sense of the test
        if (length(Wp) == 1)
            Wa = Wp/Ws;
        else
            // band pass
            Wa=(Ws.^2 - Wp(1)*Wp(2))./(Ws*(Wp(1)-Wp(2)));
        end;
    end;
    Wa = min(abs(Wa));

    // compute minimum n which satisfies all band edge conditions
    stop_atten = 10^(abs(Rs)/10);
    pass_atten = 10^(abs(Rp)/10);
    n = ceil(acosh(sqrt((stop_atten-1)/(pass_atten-1)))/acosh(Wa));

endfunction
