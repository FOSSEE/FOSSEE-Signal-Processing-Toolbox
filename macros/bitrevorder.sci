// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/signal/
// Modifieded by: Abinash Singh Under FOSSEE Internship
// Date of Modification: 3 Feb 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
function [y, i] = bitrevorder (x)

    // Returns input data in bit-reversed order
    //
    // Calling Sequence
    //[y,i] = bitrevorder(x)
    //y = bitrevorder(x)

    // Parameters
    //x: Vector of real or complex values
    //y: input vector in bit reverse order
    //i: indices

    // Description
    //This function returns the input data after reversing the bits of the indices and reordering the elements of the input array.

    // Examples
    //x = [%i,1,3,6*%i] ;
    //[y i]=bitrevorder(x)
    //Output :
    // i  =
    //
    //    1.    3.    2.    4.
    // y  =
    //
    //    i      3.    1.    6.i
    // Dependencies
    // digitrevorder
    funcprot(0);
    [nargout, nargin] = argn() ;

  if (nargin ~= 1)
    error("bitrevorder: Usage :  [ y , i ] = bitrevorder(x) ");
  elseif ( ~isvector(x) & ~isscalar(x) )
    error ("bitrevorder: X must be a vector");
  elseif (fix (log2 (length (x))) ~= log2 (length (x)))
    error ("bitrevorder: X must have length equal to an integer power of 2");
  end

  [y, i] = digitrevorder (x, 2);

endfunction
/*
tests
assert_checkequal (bitrevorder (0), 0); //passed
assert_checkequal (bitrevorder (0:1), 0:1); //passed
assert_checkequal (bitrevorder ([0:1]'), [0:1]'); //passed
assert_checkequal (bitrevorder (0:7), [0 4 2 6 1 5 3 7]); //passed
assert_checkequal (bitrevorder ([0:7]'), [0 4 2 6 1 5 3 7]'); // passed
assert_checkequal (bitrevorder ([0:7]*%i), [0 4 2 6 1 5 3 7]*%i); // passed
assert_checkequal (bitrevorder ([0:7]'*%i), [0 4 2 6 1 5 3 7]'*%i); // passed
assert_checkequal (bitrevorder (0:15), [0 8 4 12 2 10 6 14 1 9 5 13 3 11 7 15]); //passed

 Test input validation
 //  error testing
assert_checkerror (bitrevorder ());
assert_checkerror bitrevorder (1, 2);
assert_checkerror bitrevorder ([]);
assert_checkerror bitrevorder (0:2);

*/