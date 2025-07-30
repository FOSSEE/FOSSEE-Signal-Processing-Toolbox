// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/
// Modifieded by: Abinash Singh Under FOSSEE Internship
// Last Modified on : 3 Feb 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in
function [multp, idxp] = mpoles (p, tol, reorder)
// Identify unique poles in p and their associated multiplicity.
//
// Syntax
//   [multp, idxp] = mpoles(p)
//   [multp, idxp] = mpoles(p, tol)
//   [multp, idxp] = mpoles(p, tol, reorder)
//
// Parameters
// p: Vector of poles (single or double floating-point values).
// tol: (optional) Tolerance for identifying multiple poles. If the relative difference of two poles is less than `tol`, they are considered multiples. Default is 0.001.
// reorder: (optional) Logical or numeric scalar. If `%t` (default), poles are sorted from largest to smallest magnitude. If `%f`, poles are not sorted.
//
// Outputs
// multp: Vector specifying the multiplicity of the poles. `multp(n)` refers to the multiplicity of the Nth pole `p(idxp(n))`.
// idxp: Indices of the poles in the original vector `p`, ordered by magnitude (if `reorder` is `%t`).
//
// Description
// The `mpoles` function identifies unique poles in the input vector `p` and determines their multiplicity. Poles are considered multiples if their relative difference is less than the specified tolerance `tol`. By default, the poles are sorted in descending order of magnitude. If `reorder` is set to `%f`, the poles are not sorted.
// Notes
//
//  - If `tol` is not provided, the default value of 0.001 is used.
// - If `reorder` is not provided, the poles are sorted by default.
//
// Examples
// // Identify unique poles and their multiplicity:
//    p = [2, 3, 1, 1, 2]
//    [m, n] = mpoles(p)
//
// // Use a custom tolerance to identify multiples:
//    p = [1, 1.1, 1.3]
//    [m, n] = mpoles(p, 0.1 / 1.1)
//
//    [m, n] = mpoles(p, 0.1 / 1.1 + %eps)
//
// // Disable sorting of poles:
//    p = [2, 3, 1, 1, 2]
//    [m, n] = mpoles(p, 0.001, %f)
//
// Authors
// FOSSEE Team
// toolbox@scilab.in


  if (nargin < 1)
    error("mpoles: Invalid number of input arguments");
  end

  if ~( type(p)== 1)
    error ("mpoles: P must be a single or double floating point vector");
  end

  if (nargin < 2 || isempty (tol))
    tol = 0.001;
  elseif (~(isscalar (tol) && isreal (tol) && tol > 0))
    error ("mpoles: TOL must be a real scalar greater than 0");
  end

  if (nargin < 3 || isempty (reorder))
    reorder = %t;
  elseif (~(isscalar (reorder) && isreal (double(reorder))))
    error ("mpoles: REORDER must be a numeric or logical scalar");
  end

  Np = length (p);
  p = p(:);  // force poles to be a column vector

  if (reorder)
    //// sort with largest magnitude first
    [_, order] = gsort (abs(p));
    p = p(order);
  else
    order = (1:Np).';
  end

  //// Create vector of tolerances for use in algorithm.
  vtol = zeros (Np, 1, typeof(p));
  p_nz = (p ~= 0);     // non-zero poles
  vtol(~p_nz) = tol;  // use absolute tolerance for zero poles

  //// Find pole multiplicity by comparing relative difference of poles.
  multp = zeros (Np, 1, typeof(p));
  idxp = [];
  n = find (multp == 0, 1);
  while (n)
    dp = abs (p - p(n));
    vtol(p_nz) = tol * abs (p(n));
    k = find (dp < vtol);
    //// Poles can only be members of one multiplicity group.
    if (length (idxp))
      k = k(~ismember (k, idxp));
    end
    m = 1:length (k);
    multp(k) = m;
    // disp("k")
    // disp(k)
    // disp("idxp")
    // disp(idxp)
    idxp = [idxp; k(:)];
    n = find (multp == 0, 1);
  end
  multp = multp(idxp);
  idxp = order(idxp);
endfunction

function  y = ismember(a, b) // FIXME : do this in a more efficient .
  y = zeros(size(a,1),size(a,2));
  for i = 1:length(a)
    for j = 1:length(b)
      if a(i) == b(j)
        y(i) = 1;
        break;
      end
    end
  end
endfunction


/*

 // test
 [mp, ip] = mpoles ([0 0], 0.01);
 assert_checkequal (mp, [1; 2]);

 // test
 [mp, ip] = mpoles ([-1e4, -0.1, 0]);
 assert_checkequal (mp, [1; 1; 1]);
 assert_checkequal (ip, [1; 2; 3]);

// Test single inputs
// test
 [mp, ip] = mpoles ([-1e4, -0.1, 0]);
 assert_checkequal (mp,[1; 1; 1]);
 assert_checkequal (ip, [1; 2; 3]);

// Test relative tolerance criteria
// test
 [mp, ip] = mpoles ([1, 1.1, 1.3], .1/1.1);
 assert_checkequal (mp, [1; 1; 1]);
 [mp, ip] = mpoles ([1, 1.1, 1.3], .1/1.1 + %eps);
 assert_checkequal (mp, [1; 1; 2]);

// Test absolute tolerance criteria with a zero pole
// test
 [mp, ip] = mpoles ([0, -0.1, 0.3], .1);
 assert_checkequal (mp, [1; 1; 1]);
 [mp, ip] = mpoles ([0, -0.1, 0.3], .1 + %eps);
 assert_checkequal (mp, [1; 1; 2]);

//// Test input validation
error <Invalid call> mpoles ()
error <P must be a single or double floating point vector> mpoles (uint8 (1))
error <TOL must be a real scalar greater than 0> mpoles (1, [1, 2])
error <TOL must be a real scalar greater than 0> mpoles (1, 1i)
error <TOL must be a real scalar greater than 0> mpoles (1, 0)
error <REORDER must be a numeric or logical scalar> mpoles (1, 1, [1, 2])
error <REORDER must be a numeric or logical scalar> mpoles (1, 1, {1})

*/