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
function [y, i] = digitrevorder (x, r)
  // Returns input data in digit-reversed order
  // Calling Sequence
  //[y,i] = digitrevorder(x,r)
  //y = digitrevorder(x,r)
  // Parameters
  //x: Vector of real or complex values
  //r: radix / base
  //y: input vector in digit reverse order
  //i: indices
  // Description
  //This function returns the input data after reversing the digits of the indices and reordering the elements of the input array.
  // Examples
  //x = [%i,1,3,6*%i] ;
  //r = 2 ;
  //[y i]=digitrevorder(x, r)
  //Output :
  // i  =
  //
  //    1.    3.    2.    4.
  // y  =
  //
  //    i      3.    1.    6.i
  funcprot(0);
  [nargout, nargin] = argn() ;

  if (nargin > 2 | nargin <= 1)
    error("digitrevorder : invalid number of inputs")
  elseif ( ~isvector(x) & ~isscalar(x))
    error ("digitrevorder : X must be a vector");
  elseif (~ (isscalar (r) & r == fix (r) & r >= 2 & r <= 36))
    error ("digitrevorder : R must be an integer between 2 and 36");
  else
    tmp = log (length(x)) / log (r);
    if (fix (tmp) ~= tmp)
      error ("digitrevorder: X must have length equal to an integer power of radix");
    end
  end

  old_ind = 0:max(size(x)) - 1;
  new_ind = base2dec (strrev(dec2base (old_ind, r)), r);
  i = new_ind + 1;
  y(old_ind + 1) = x(i);
  if (size(x,2)== 1)
    y = y(:);
  else
    i = i.';
  end
endfunction

/*
// tests base 0 2 OK
assert_checkequal (digitrevorder (0, 2), 0); // passed
assert_checkequal (digitrevorder (0, 36), 0); //passed
assert_checkequal (digitrevorder (0:3, 4), 0:3); //passed
assert_checkequal (digitrevorder ([0:3]', 4), [0:3]');//passed
assert_checkequal (digitrevorder (0:7, 2), [0 4 2 6 1 5 3 7]);//passed
assert_checkequal (digitrevorder ([0:7]', 2), [0 4 2 6 1 5 3 7]');//passed
assert_checkequal (digitrevorder ([0:7]*%i, 2), [0 4 2 6 1 5 3 7]*%i); //passed
assert_checkequal (digitrevorder ([0:7]'*%i, 2), [0 4 2 6 1 5 3 7]'*%i);//passed
assert_checkequal (digitrevorder (0:15, 2), [0 8 4 12 2 10 6 14 1 9 5 13 3 11 7 15]); // passed

//FIXME : debug the failed test
assert_checkequal (digitrevorder (0:15, 4), [0 4 8 12 1 5 9 13 2 6 10 14 3 7 11 15]); // failed 

//Test input validation - passed
error digitrevorder ();
error digitrevorder (1);
error digitrevorder (1, 2, 3);
error digitrevorder ([], 1);
error digitrevorder ([], 37);
error digitrevorder (0:3, 8);
*/