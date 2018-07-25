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

function [y] = chirp(t,f0,t1,f1,form,phase)
    //This function evaluates a chirp signal at time t.

    //Calling Sequence
    //y = chirp(t)
    //y = chirp(t, f0)
    //y = chirp(t, f0, t1)
    //y = chirp(t, f0, t1, f1)
    //y = chirp(t, f0, t1, f1, frm)
    //y = chirp(t, f0, t1, f1, frm, phse)

    //Parameters
    //t:  a vector of times to evaluate the chirp signal
    //f0: the frequency at t=0 [default value = 0 Hz]
    //t1: some intermediate time [default value = 1 sec]
    //f1: frequency at t1. [default value = 100 Hz]
    //frm: string value, takes in "linear", "quadratic", "logarithmic" [default value = "linear"]
    //phse: phase shift at t=0. [default value = 0]
    //y: chirp signal value corresponding to t.

    //Description
    //This function evaluates a chirp signal at time t. A chirp signal is a frequency swept cosine wave.
    //The first argument is a vector of times to evaluate the chirp signal, second argument is the frequency at t=0, third argument is time t1 and fourth argument is frequency at t1.
    //The fifth argument is the form which takes in values "linear", "quadratic" and "logarithmic", the sixth argument gives the phase shift at t=0.

    //Examples
    //t = [4,3,2,1];
    //f0 = 4;
    //t1 = 5;
    //f1 = 0.9;
    //form = "quadratic";
    //y = chirp(t, f0, t1, f1, form)
    //Output :
    // y  =
    //
    //  - 0.6112508    0.7459411  - 0.4854201    0.9664658

    funcprot(0);
    [nargout,nargin]=argn(0);

    if nargin < 1 | nargin > 6
        error("chirp: invalid number of inputs");
    end
    if nargin < 2, f0 = []; end
    if nargin < 3, t1 = []; end
    if nargin < 4, f1 = []; end
    if nargin < 5, form = []; end
    if nargin < 6, phase = []; end

    if isempty(f0), f0 = 0; end
    if isempty(t1), t1 = 1; end
    if isempty(f1), f1 = 100; end
    if isempty(form), form = "linear"; end
    if isempty(phase), phase = 0; end

    phase = 2*%pi*phase/360;

    if (form== "linear")
        a = %pi*(f1 - f0)/t1;
        b = 2*%pi*f0;
        y = cos(a*t.^2 + b*t + phase);
    elseif (form== "quadratic")
        a = (2/3*%pi*(f1-f0)/t1/t1);
        b = 2*%pi*f0;
        y = cos(a*t.^3 + b*t + phase);
    elseif (form== "logarithmic")
        a = 2*%pi*t1/log(f1-f0);
        b = 2*%pi*f0;
        x = (f1-f0)^(1/t1);
        y = cos(a*x.^t + b*t + phase);
    else
        error(sprintf("chirp: chirp doesnt understand ''%s''",form));
    end
endfunction
