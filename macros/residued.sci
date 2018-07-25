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

//  Function File [r, p, f, m] = residued (b, a)
// Compute the partial fraction expansion (PFE) of filter
// H(z) = B(z)/A(z).  In the usual PFE function coderesiduez, the
// IIR part (poles p and residues r) is driven in parallel
// with the FIR part (f).  In this variant, the IIR part is driven by
// the output of the FIR part.  This structure can be more accurate in
// signal modeling applications.
//
// INPUTS:
// b and a are vectors specifying the digital filter
// H(z) = B(z)/A(z).
//NOTE that the polynomials 'b' and 'a' should have real coefficients(because of the function 'filter' used in polyval)
//
// RETURNED:
//
//  r = column vector containing the filter-pole residues
//  p = column vector containing the filter poles
//  f = row vector containing the FIR part, if any
//  m = column vector of pole multiplicities
//
//
// Test cases:
//1.
//B=[1 1 ]; A=[1 -2 1];
// [r,p,f,m] = residued(B,A);
//r =
//  -1
//   2
//p =
//   1
//   1
//
//f = [](0x0)
//e =
//   1
//   2
//2.
//B=[6,2]; A=[1 -2 1];
//[r,p,k,e]=residued(B,A)
//m  =
//    1.
//    2.
// f  =[]
// p  =
//    1.
//    1.
// r  =
//  - 2.
//    8.
//

function [r, p, f, m] = residued(b, a, toler)

  // RESIDUED - return residues, poles, and FIR part of B(z)/A(z)
  //
  // Let nb = length(b), na = length(a), and N=na-1 = no. of poles.
  // If nb<na, then f will be empty, and the returned filter is
  //
  //             r(1)                      r(N)
  // H(z) = ----------------  + ... + ----------------- = R(z)
  //        [ 1-p(1)/z ]^e(1)         [ 1-p(N)/z ]^e(N)
  //
  // This is the same result as returned by RESIDUEZ.
  // Otherwise, the FIR part f will be nonempty,
  // and the returned filter is
  //
  // H(z) = f(1) + f(2)/z + f(3)/z^2 + ... + f(nf)/z^M + R(z)/z^M
  //
  // where R(z) is the parallel one-pole filter bank defined above,
  // and M is the order of F(z) = length(f)-1 = nb-na.
  //
  // Note, in particular, that the impulse-response of the parallel
  // (complex) one-pole filter bank starts AFTER that of the the FIR part.
  // In the result returned by RESIDUEZ, R(z) is not divided by z^M,
  // so its impulse response starts at time 0 in parallel with f(n).
  //
[nargout,nargin]=argn();

  if nargin<3,
    warning("tolerance ignored");
  end
  NUM = b(:)';
  DEN = a(:)';
  nb = length(NUM);
  na = length(DEN);
  f = [];
  if na<=nb
    f = filter(NUM,DEN,[1,zeros(nb-na)]);
    NUM = NUM - conv(DEN,f);
    NUM = NUM(nb-na+2:$);
  end
  [r,p,f2,m] = residuez(NUM,DEN);
  if f2
       error('f2 not empty as expected');
       end

endfunction
