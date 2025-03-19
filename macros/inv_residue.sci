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
// Inverse of residue function
function [b_out, a_out] = inv_residue(r_in, p_in, k_in, tol)

  n = length(r_in); // Number of poles/residues

  k = 0; // Capture constant term
  if (length(k_in)==1)    // A single direct term (order N = order D)
    k = k_in(1);          // Capture constant term
  elseif (length(k_in)>1) // Greater than one means non-physical system
    error("Order numerator > order denominator");
  end

  a_out = octave_poly(p_in);

  b_out  = zeros(1,n+1);
  b_out = b_out +  k*a_out; // Constant term: add k times denominator to numerator
  i=1;
  while (i<=n)
    term   = [1 -p_in(i)];               // Term to be factored out
    p      = r_in(i)*deconv(a_out,term); // Residue times resulting polynomial
    p      = prepad(p, n+1, 0, 2);       // Pad for proper length
    b_out = b_out + p;

    m          = 1;
    mterm      = term;
    first_pole = p_in(i);
    while (i<n && abs(first_pole-p_in(i+1))<tol) // Multiple poles at p(i)
      i=i+1; // Next residue
      m=m+1;
      mterm  = conv(mterm, term);              // Next multiplicity to be factored out
      p      = r_in(i) * deconv(a_out, mterm); // Resulting polynomial
      p      = prepad(p, n+1, 0, 2);           // Pad for proper length
      b_out = b_out + p;
    end
  i=i+1;
  end

endfunction
function ocpoly = octave_poly(A)
    p = poly(A, 'x');
    c = coeff(p);
    ocpoly = c($:-1:1);
endfunction