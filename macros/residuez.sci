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

  function [r, p, f, m] = residuez(B, A, tol)
// Compute the partial fraction expansion (PFE) of a digital filter.
//
// Syntax
//   [r, p, f, m] = residuez(B, A)
//   [r, p, f, m] = residuez(B, A, tol)
//
// Parameters
// B: Numerator coefficients of the digital filter (vector).
// A: Denominator coefficients of the digital filter (vector).
// tol: (optional) Tolerance for pole-zero matching. Ignored in this implementation.
//
// Outputs
// r: Column vector containing the residues of the filter poles.
// p: Column vector containing the poles of the filter.
// f: Row vector containing the FIR part of the filter, if any. Empty if no FIR part exists.
// m: Column vector containing the multiplicities of the poles.
//
// Description
// The `residuez` function computes the partial fraction expansion of a digital filter represented by the transfer function:
//   H(z) = B(z) / A(z)
// where `B` and `A` are the numerator and denominator coefficients, respectively.
//
// The function separates the filter into two parts:
// 1. The FIR part `f`, which represents the feedforward portion of the filter.
// 2. The IIR part, represented by the residues `r` and poles `p`.
//
// If the numerator degree is less than the denominator degree (`nb < na`), the FIR part `f` is empty, and the filter is represented as:
//   H(z) = r(1) / [1 - p(1)/z]^m(1) + ... + r(N) / [1 - p(N)/z]^m(N)
// where `N` is the number of poles.
//
// If the numerator degree is greater than or equal to the denominator degree (`nb >= na`), the FIR part `f` is non-empty, and the filter is represented as:
//   H(z) = f(1) + f(2)/z + f(3)/z^2 + ... + f(M+1)/z^M + R(z)
// where `R(z)` is the parallel one-pole filter bank.
//
// Notes
// - The polynomials `B` and `A` must have real coefficients.
// - The function uses MATLAB's `residue` function internally to compute the residues and poles.
//
// Examples
// // Compute the partial fraction expansion of a filter:
//    B = [1, 1, 1];
//    A = [1, -2, 1];
//    [r, p, f, m] = residuez(B, A);
//    // Output:
//    // r = [0; 3]
//    // p = [1; 1]
//    // f = 1
//    // m = [1; 2]
//


  // RESIDUEZ - return residues, poles, and FIR part of B(z)/A(z)
  //
  // Let nb = length(b), na = length(a), and N=na-1 = no. of poles.
  // If nb<na, then f will be empty, and the returned filter is
  //
  //             r(1)                      r(N)
  // H(z) = ----------------  + ... + ----------------- = R(z)
  //        [ 1-p(1)/z ]^m(1)         [ 1-p(N)/z ]^m(N)
  //
  // If, on the other hand, nb >= na, the FIR part f will not be empty.
  // Let M = nb-na+1 = order of f = length(f)-1). Then the returned filter is
  //
  // H(z) = f(1) + f(2)/z + f(3)/z^2 + ... + f(M+1)/z^M + R(z)
  //
  // where R(z) is the parallel one-pole filter bank defined above.
  // Note, in particular, that the impulse-response of the one-pole
  // filter bank is in parallel with that of the the FIR part.  This can
  // be wasteful when matching the initial impulse response is important,
  // since F(z) can already match the first N terms of the impulse
  // response. To obtain a decomposition in which the impulse response of
  // the IIR part R(z) starts after that of the FIR part F(z), use RESIDUED.
  //
  //NOTE that the polynomials 'b' and 'a' should have real coefficients(because of the function 'filter' used in polyval)
  //Testcase
  //B=[1 1 1]; A=[1 -2 1];
  //[r,p,f,m] = residuez(B,A)
  //OUTPUT:
  //r=[0;3]
  //p=[1;1]
  //f=1
  //e=[1;2]



 [nargout,nargin]=argn();
 if nargin==3
     warning("tolerance ignored");
 end
 NUM = B(:)';
 DEN = A(:)';
 // Matlab's residue does not return m (since it is implied by p):
 [r,p,f,m]=residue(conj(mtlb_fliplr(NUM)),conj(mtlb_fliplr(DEN)));
 p = 1 ./ p;
 r = r .* ((-p) .^m);
 if f
     f = conj(mtlb_fliplr(f));
 end

endfunction
