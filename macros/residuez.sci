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
