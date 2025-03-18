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

// Impulse invariant conversion from s to z domain
/*
    [b_out, a_out] = invimpinvar (b, a, fs, tol) 
    [b_out, a_out] = invimpinvar (b, a, fs) 
    [b_out, a_out] = invimpinvar (b, a) 

    Converts digital filter with coefficients b and a to analog, conserving impulse response.

    This function does the inverse of impinvar so that the following example should restore the original values of a and b.

    [b, a] = impinvar (b, a);
    [b, a] = invimpinvar (b, a);

    If fs is not specified, or is an empty vector, it defaults to 1Hz.

    If tol is not specified, it defaults to 0.0001 (0.1%) 
  Dependencies
    residue
    inv_residue
    */
function [b_out, a_out] = invimpinvar (b_in, a_in, fs, tol)

    error("invimpinvar: Missing functionality not implemented in this release .Will be  Available soon ");
endfunction
// FIXME : fix filter function first . till then drop this fun
/*
  if (nargin <2)
    error("invimpinvar: Insufficient input arguments");
  end

  if nargin < 3 then fs = 1; end
  if nargin < 4 then tol = 0.0001; end
  // to be compatible with the matlab implementation where an empty vector can
  // be used to get the default
  if (isempty(fs))
    ts = 1;
  else
    ts = 1/fs; // we should be using sampling frequencies to be compatible with Matlab
  end

  b_in = [b_in 0]; // so we can calculate in z instead of z^-1

  [r_in, p_in, k_in] = residue(b_in, a_in); // partial fraction expansion
  
  // clean r_in for zero values
  n = length(r_in); // Number of poles/residues

  if (length(k_in) > 1) // Greater than one means we cannot do impulse invariance
    error("Order numerator > order denominator");
  end

  r_out  = zeros(1,n); // Residues of H(s)
  sm_out = zeros(1,n); // Poles of H(s)

  i=1;
  while (i<=n)
    m=1;
    first_pole = p_in(i); // Pole in the z-domain
    while (i<n && abs(first_pole-p_in(i+1))<tol) // Multiple poles at p(i)
      i=i+1; // Next residue
      m=m+1; // Next multiplicity
    end
    [r, sm, k]= inv_z_res(r_in(i-m+1:i), first_pole, ts); // Find s-domain residues
    k_in            = k_in - k;                                        // Just to check, should end up zero for physical system
    sm_out(i-m+1:i) = sm;                                       // Copy s-domain pole(s) to output
    r_out(i-m+1:i)  = r;                                        // Copy s-domain residue(s) to output

    i=i+1; // Next z-domain residue/pole
  end
  [b_out, a_out] = inv_residue(r_out, sm_out , 0, tol);
  a_out          = to_real(a_out);      // Get rid of spurious imaginary part
  b_out          = to_real(b_out);

  b_out          = polyreduce(b_out);

endfunction
*/
// Inverse function of z_res (see impinvar source)

function [r_out, sm_out, k_out] = inv_z_res (r_in,p_in,ts)

  n    = length(r_in); // multiplicity of the pole
  r_in = r_in.';       // From column vector to row vector

  j=n;
  while (j>1) // Go through residues starting from highest order down
    r_out(j)   = r_in(j) / ((ts * p_in)^j);                   // Back to binomial coefficient for highest order (always 1)
    r_in(1:j) = r_in(1:j) - r_out(j) * polyrev(h1_z_deriv(j-1,p_in,ts)); // Subtract highest order result, leaving r_in(j) zero
    j=j-1;
  end

  // Single pole (no multiplicity)
  r_out(1) = r_in(1) / ((ts * p_in));
  k_out    = r_in(1) / p_in;
  sm_out   = log(p_in) / ts;
endfunction

/*
// tests passed
[b_out,a_out]=invimpinvar([1],[1 -0.5],0.01) 
[b_out,a_out]=invimpinvar([1],[1 -1 0.25],0.01)
[b_out,a_out]=invimpinvar([1 1],[1 -1 0.25],0.01)
[b_out,a_out]=invimpinvar([1],[1 -1.5 0.75 -0.125],0.01)
[b_out,a_out]=invimpinvar([1 1],[1 -1.5 0.75 -0.125],0.01)



// FIXME : built in filter doesn't support complex parameters
// Because of this thsese test cases are failing
//[b_out,a_out]=invimpinvar([1],[1 0 0.25],0.01)
// [b_out,a_out]=invimpinvar([1 1],[1 0 0.25],0.01)
// [b_out,a_out]=invimpinvar([1],[1 0 0.5 0 0.0625],0.01)
// [b_out,a_out]=invimpinvar([1 1],[1 0 0.5 0 0.0625],0.01)
// [b_out,a_out]=invimpinvar([1 1 1],[1 0 0.5 0 0.0625],0.01
// [b_out,a_out]=invimpinvar([1 1 1 1],[1 0 0.5 0 0.0625],0.01)

*/
