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

function [d]=dftmtx(n)
    // Computes n-by-n Discrete Fourier transformation matrix

    //Calling Sequence
    //d=dftmtx(n)

    //Parameters
    //n: Real positive scalar number

    // Description
    //This fuction gives a complex matrix of values whose product with a vector produces the discrete Fourier transform. This can also be achieved by directly using the fft function i.e. y=fft(x) is same as y=A*x where A=dftmtx(n).

    // Examples
    //d = dftmtx(4)
    //Output:
    // d  =
    //
    //    1.    1.     1.    1.
    //    1.  - i    - 1.    i
    //    1.  - 1.     1.  - 1.
    //    1.    i    - 1.  - i

    funcprot(0);
    [nargout nargin] = argn();
    if (nargin ~= 1)
        error("dftmtx: invalid number of inputs")
    elseif (~isscalar(n))
        error ("dftmtx: argument must be scalar");
    end

    c = eye(n, n);
    d = [];
    for i = 1:n
        d = [d fft(c(:, i))]
    end

endfunction
