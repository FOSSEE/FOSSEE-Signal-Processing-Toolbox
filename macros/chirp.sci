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

function [y] = chirp(t, f0, t1, f1, form, phase)
// Generate a chirp signal.
//
// Syntax
//   y = chirp(t)
//   y = chirp(t, f0)
//   y = chirp(t, f0, t1)
//   y = chirp(t, f0, t1, f1)
//   y = chirp(t, f0, t1, f1, form)
//   y = chirp(t, f0, t1, f1, form, phase)
//
// Parameters
// t: Vector. Times to evaluate the chirp signal.
// f0: Real scalar. Frequency at t=0. Default is 0 Hz.
// t1: Real scalar. Intermediate time. Default is 1 second.
// f1: Real scalar. Frequency at t1. Default is 100 Hz.
// form: String. Form of the chirp signal. Can be "linear", "quadratic", or "logarithmic". Default is "linear".
// phase: Real scalar. Phase shift at t=0 in degrees. Default is 0.
// y: Vector. Chirp signal values corresponding to `t`.
//
// Description
// This function generates a chirp signal, which is a frequency-swept cosine wave. The signal can be linear, quadratic, or logarithmic based on the `form` parameter.
//
// Examples
// t = [4, 3, 2, 1]
// f0 = 4
// t1 = 5
// f1 = 0.9
// form = "quadratic"
// y = chirp(t, f0, t1, f1, form)
// 

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
