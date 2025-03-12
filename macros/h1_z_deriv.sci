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
function b = h1_z_deriv(n, p, ts)

  // Build the vector d that holds coefficients for all the derivatives of H1(z)
  // The results reads d(n)*z^(1)*(d/dz)^(1)*H1(z) + d(n-1)*z^(2)*(d/dz)^(2)*H1(z) +...+ d(1)*z^(n)*(d/dz)^(n)*H1(z)
  d = (-1)^n; // Vector with the derivatives of H1(z)
  for i= (1:n-1)
    d  = [d 0];                           // Shift result right (multiply by -z)
    d = d + prepad(polyder(d), i+1, 0, 2); // Add the derivative
  end

  // Build output vector
  b = zeros (1, n + 1);
  for i = (1:n)
    b = b + d(i) * prepad(h1_deriv(n-i+1), n+1, 0, 2);
  end
  b  = b * ts^(n+1)/factorial(n);
  // Multiply coefficients with p^i, where i is the index of the coeff.
  b = b.*p.^(n+1:-1:1);
endfunction

// Find (z^n)*(d/dz)^n*H1(z), where H1(z)=ts*z/(z-p), ts=sampling period,
// p=exp(sm*ts) and sm is the s-domain pole with multiplicity n+1.
// The result is (ts^(n+1))*(b(1)*p/(z-p)^1 + b(2)*p^2/(z-p)^2 + b(n+1)*p^(n+1)/(z-p)^(n+1)),
// where b(i) is the binomial coefficient bincoeff(n,i) times n!. Works for n>0.

function b = h1_deriv(n)
  b  = factorial(n)*nchoosek(n,0:n); // Binomial coefficients: [1], [1 1], [1 2 1], [1 3 3 1], etc.
  b = b*(-1)^n;
endfunction

function y = polyder(a)
    y = poly(flipdim(a,2),'a','coeff')
    y = derivat(y)
    y = coeff(y)
endfunction

