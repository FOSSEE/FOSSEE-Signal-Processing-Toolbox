// Copyright (C) 2018 - IIT Bombay - FOSSEE
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Author:[insert name]
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in


function [multp, indx] = mpoles (p, tol, reorder)

//Calling sequence:
// [multp, idxp] = mpoles (p)
// [multp, idxp] = mpoles (p, tol)
//  [multp, idxp] = mpoles (p, tol, reorder)
// Identify unique poles in p and their associated multiplicity.
//
// The output is ordered from largest pole to smallest pole.
//
// If the relative difference of two poles is less than tol then they are
// considered to be multiples.  The default value for tol is 0.001.
//
// If the optional parameter reorder is zero, poles are not sorted.
//
// The output multp is a vector specifying the multiplicity of the poles.
// multp(n) refers to the multiplicity of the Nth pole
// p(idxp(n)).
//
//
//

// test case:

// p = [2 3 1 1 2];
// [m, n] = mpoles (p)
// n  =
//    2.
//    5.
//    1.
//    4.
//    3.
// m  =
//    1.
//    1.
//    2.
//    1.
//    2.
//


[nargout,nargin]=argn();

  if (nargin < 1 | nargin > 3)
    error("wrong number of input arguments");
  end

   if (nargin < 2 | isempty (tol))
     tol = 0.001;
   end

   if (nargin < 3 | isempty (reorder))
     reorder = %t;
   end

  Np = length (p);

  // Force the poles to be a column vector.

  p = p(:);

  // Sort the poles according to their magnitidues, largest first.

  if (reorder)
    // Sort with smallest magnitude first.
    [p, ordr] = gsort (p,"r","i");
    // Reverse order, largest maginitude first.
    n = Np:-1:1;
    p = p(n);
    ordr = ordr(n);
  else
    ordr = 1:Np;
  end

  // Find pole multiplicty by comparing the relative differnce in the
  // poles.

  multp = zeros (Np, 1);
  indx = [];
  n = find (multp == 0, 1);






  while (n)
    dp = abs (p-p(n));
    if (p(n) == 0.0)
      if (or (abs (p) > 0 & (abs(p)<%inf)))
        p0 = mean (abs (p(abs (p) > 0 &  abs(p)<%inf)));
      else
        p0 = 1;
      end
    else
      p0 = abs (p(n));
    end
    k = find (dp < tol * p0)';
    // Poles can only be members of one multiplicity group.
//    if (length(indx))
//        mk=members(k,indx);
//      k = (~ bool2s(mk~=0));
//    end
    m = 1:length (k);
    multp(k) = m';
    indx = [indx; k];
    n = find (multp == 0, 1);
  end
  multp = multp(indx);
  indx = ordr(indx);

endfunction
