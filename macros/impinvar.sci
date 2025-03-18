// Copyright (C) 2018 - IIT Bombay - FOSSEE
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/signal/
// Modifieded by: Abinash Singh , SOE CUSAT
// Last Modified on : Feb 2024
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in

/*
Calling Sequence
[b_out, a_out] = impinvar (b, a, fs, tol) 
[b_out, a_out] = impinvar (b, a, fs) 
[b_out, a_out] = impinvar (b, a) 
Converts analog filter with coefficients b and a to digital, conserving impulse response.

If fs is not specified, or is an empty vector, it defaults to 1Hz.

If tol is not specified, it defaults to 0.0001 (0.1%) This function does the inverse of impinvar so that the following example should restore the original values of a and b.

invimpinvar implements the reverse of this function.

[b, a] = impinvar (b, a);
[b, a] = invimpinvar (b, a);
Reference: Thomas J. Cavicchi (1996) “Impulse invariance and multiple-order poles”. IEEE transactions on signal processing, Vol 44 (9): 2344–2347
Dependencies
  residue


*/
function [b_out, a_out] = impinvar (b_in, a_in, fs , tol)
  error("impinvar: Missing functionality .This function is not implemented yet. Will available in next release");
endfunction
/*
  if (nargin <2)
    error ("impinvar: Insufficient input arguments");
  end
  if nargin < 3
    fs = 1;
  end
  if nargin < 4
    tol = 0.0001;
  end
  // to be compatible with the matlab implementation where an empty vector can
  // be used to get the default
  if (isempty(fs))
    ts = 1;
  else
    ts = 1/fs; // we should be using sampling frequencies to be compatible with Matlab
  end

  [r_in, p_in, k_in] = residue(b_in, a_in); // partial fraction expansion

  n = length(r_in); // Number of poles/residues

  if (length(k_in)>0) // Greater than zero means we cannot do impulse invariance
    error("Order numerator >= order denominator");
  end

  r_out = zeros(1,n); // Residues of H(z)
  p_out = zeros(1,n); // Poles of H(z)
  k_out = 0;          // Constant term of H(z)

  i=1;
  while (i<=n)
    m = 1;
    first_pole = p_in(i); // Pole in the s-domain
    while (i<n && abs(first_pole-p_in(i+1))<tol) // Multiple poles at p(i)
      i=i+1; // Next residue
      m=m+1; // Next multiplicity
    end
    [r, p, k]        = z_res(r_in(i-m+1:i), first_pole, ts); // Find z-domain residues
    k_out            = k_out + k;                                    // Add direct term to output
    p_out(i-m+1:i)   = p;                                    // Copy z-domain pole(s) to output
    r_out(i-m+1:i)   = r;                                    // Copy z-domain residue(s) to output

    i=i+1; // Next s-domain residue/pole
  end

  [b_out, a_out] = inv_residue(r_out, p_out, k_out, tol);
  a_out          = to_real(a_out); // Get rid of spurious imaginary part
  b_out          = to_real(b_out);

  // Shift results right to account for calculating in z instead of z^-1
  b_out($)=[];
endfunction
*/
// Convert residue vector for single and multiple poles in s-domain (located at sm) to
// residue vector in z-domain. The variable k is the direct term of the result.

function [r_out, p_out, k_out] = z_res (r_in, sm, ts)

  p_out = exp(ts * sm); // z-domain pole
  n     = length(r_in); // Multiplicity of the pole
  r_out = zeros(1,n);   // Residue vector

  // First pole (no multiplicity)
  k_out    = r_in(1) * ts;         // PFE of z/(z-p) = p/(z-p)+1; direct part
  r_out(1) = r_in(1) * ts * p_out; // pole part of PFE

  for i=(2:n) // Go through s-domain residues for multiple pole
    r_out(1:i) = r_out(1:i) + r_in(i) * polyrev(h1_z_deriv(i-1, p_out, ts)); // Add z-domain residues
  end

endfunction
function p_out = polyrev (p_in)

    p_out = p_in($:-1:1);

  
endfunction
function p_out = to_real(p_in)

    p_out = abs(p_in) .* sign(real(p_in));
  
  endfunction
/*
//test passed
[b_out,a_out]=impinvar([1],[1 1],100);
assert_checkalmostequal(b_out,0.01,%eps,1e-4)
assert_checkalmostequal(a_out,[1 -0.99],%eps,1e-4)

//test passed
[b_out,a_out]=impinvar([1],[1 2 1],100)
assert_checkalmostequal(b_out,[0 9.9005e-5],%eps,1e-4)
assert_checkalmostequal(a_out,[1 -1.9801 0.9802],%eps,1e-4)

[b_out, a_out] = impinvar([1], [1 3 3 1], 100) // test passed

[b_out, a_out] = impinvar([1 1], [1 3 3 1], 100) // test passed

[b_out, a_out] = impinvar([1 1 1], [1 3 3 1], 100) // test passed

// FIXME : builtin  filter doesn't accepts complex parameters
// These test cases will through errors
// [b_out, a_out] = impinvar([1], [1 0 1], 100) 
// [b_out, a_out] = impinvar([1 1], [1 0 1], 100) 
// [b_out, a_out] = impinvar([1], [1 0 2 0 1], 100)
// [b_out, a_out] = impinvar([1 1], [1 0 2 0 1], 100)
// [b_out, a_out] = impinvar([1 1 1], [1 0 2 0 1], 100)
// [b_out, a_out] = impinvar([1 1 1 1], [1 0 2 0 1], 100)

*/
