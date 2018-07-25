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

// This is a supporting function

function y = postpad(x, n, varargin)

    //Calling Sequences
    // Y = postpad (X, L)
    // Y = postpad (X, L, C)

    // Description :
    // Append the scalar value C to the vector X until it is of length L.
    // If C is not given, a value of 0 is used.
    //
    // If 'length (X) > L', elements from the end of X are removed until a
    // vector of length L is obtained.

    //Example :
    //x = [1 2 3];
    //L = 6;
    //y = postpad(x, L)
    //Output :
    // y  =
    //
    //    1.    2.    3.    0.    0.    0.

    funcprot(0);
    if argn(2) > 3 | argn(2) < 2  then
        error("postpad : wrong number of input argument ")
    elseif argn(2) == 2
        c = 0 ;
    else
        c = varargin(1);
    end

    y = x;
    for i = 1:(n-length(x))
        y = [y c];
    end
endfunction
