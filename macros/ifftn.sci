// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/
// Modifieded by: Abinash Singh Under FOSSEE Internship
// Last Modified on : 19 March 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
/*Description
    Compute the inverse N-dimensional discrete Fourier transform of A using a Fast Fourier Transform (FFT) algorithm.
    The optional vector argument SIZE may be used specify the dimensions of the matrix to be used.
    If an element of SIZE is smaller than the corresponding dimension of A, then the dimension of A is truncated prior to performing the inverse FFT.
    Otherwise, if an element of SIZE is larger than the corresponding dimension then A is resized and padded with zeros.
Calling Sequence
     Y = ifftn(A)
     Y = ifftn(A, size)
Parameters
     A: Matrix
     SIZE : (optional) dimension of matrix to be used
Examples
     ifftn([2,3,4])
     ans =
            3.  - 0.5 - 0.2886751i  - 0.5 + 0.2886751i */
function y = ifftn(A, SIZE)
    funcprot(0);
    funcprot(0);
    rhs = argn(2)
    if(rhs<1 | rhs>2)
        error("Wrong number of input arguments.");
    end
    select(rhs)
    case 1 then
        y=fft(A,1);
    case 2 then
        // Check if A needs resizing
        if size(A) == SIZE then
            // No resizing needed
            break;
        elseif length(size(A)) ~= length(SIZE) then
            error("Output size must have at least Ndims");
        else
            // Resize A using the resize_matrix function
            A = resize_matrix(A, SIZE);
        end
        y = fft(A,1);
    end
    y = clean( y ) ;
endfunction

