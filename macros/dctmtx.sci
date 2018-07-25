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

function T = dctmtx(n)
    // Return the DCT transformation matrix of size N-by-N.

    //Calling Sequence
    //T = dctmtx(n)

    //Parameters
    //n: Real scalar integer greater than or equal to 1

    //Description
    //dctmtx(n) returns a Discrete cosine transform matrix (D) of order n-by-n. It is useful for jpeg image compression. D*A is the DCT of the columns of A and D'*A is the inverse DCT of the columns of A (when A is n-by-n).

    // Examples
    //n= 3;
    //T = dctmtx(n)
    //Output:
    // T  =
    //
    //    0.5773503    0.5773503    0.5773503
    //    0.7071068    5.000D-17  - 0.7071068
    //    0.4082483  - 0.8164966    0.4082483


    funcprot();
    [nargout nargin] = argn();
    if nargin ~= 1
        error("dctmtx: invalid number of inputs")
    end

    if n > 1
        T = [ sqrt(1/n)*ones(1,n) ; ...
        sqrt(2/n)*cos((%pi/2/n)*([1:n-1]'*[1:2:2*n])) ];
    elseif n == 1
        T = 1;
    else
        error ("dctmtx: n must be at least 1");
    end
endfunction
