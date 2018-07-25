// Copyright (C) 2018 - IIT Bombay - FOSSEE
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Author:Sonu Sharma, RGIT Mumbai
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in

function y = wconv (typ, x, f, shape)
    //Performs 1D or 2D convolution.

    //Calling Sequence
    //y = wconv (type, x, f)
    // y = wconv (type, x, f, shape)

    //Parameters
    //type: convolution type.
    //           1 or "1" for 1D
    //           2 or "2" for 2D
    //x: Signal vector or matrix.
    //f: FIR filter coefficients.
    //shape: Shape.
    //           "full", computes the full one/two-dimensional convolution. It is the default value.
    //          "same",  computes the central part of the convolution of the same size as x.
    //          "valid",  computes the convolution parts without the zero-padding of x.

    //Description
    //It performs 1D or 2D convolution between the signal x and the filter coefficients f.

    //Examples
    //a = [1 2 3 4 5]
    //b = [7 8 9 10]
    //wconv(1,a,b)
    //ans =
    //     7    22    46    80   114   106    85    50

    funcprot(0);
    rhs = argn(2)
    if(rhs<3 | rhs>4)
        error("wconv: wrong number of inputs.")
    end

    if (or(~ type(x) == [1 5 8]) & ~ or(type(f) == [1 5 8])) then
        error("wconv:Arg #2 and #3 must be real or complex matrices/vectors")
    end

    if argn(2) == 3 then
        shape = "full"
    end

    select (typ)
    case 1
        if (isvector(x) & isvector(f))
            y = conv2 (x, f, shape);
            if ( ~ isrow (x))
                y = y.';
            end
        else
            error("wconv: Arg #2 and #3 must be vector for 1D convolution")
        end

    case "1"
        if (isvector(x) & isvector(f))
            y = conv2 (x, f, shape);
            if ( ~ isrow (x))
                y = y.';
            end
        else
            error("wconv: Arg #2 and #3 must be vector for 1D convolution")
        end
    case 2
        y = conv2 (x, f, shape);
    case "2"
        y = conv2 (x, f, shape);
    else
        error('wconv: type must be 1  for 1D convolution and 2 for 2D convolution')
    end

endfunction
