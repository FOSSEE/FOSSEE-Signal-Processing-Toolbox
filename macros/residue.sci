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


function [r, p, k, e] = residue (b, a, varargin)


//  [r, p, k, e] = residue (b, a)
//  [b, a] = residue (r, p, k)
// [b, a] = residue (r, p, k, e)
// The first calling form computes the partial fraction expansion for the
// quotient of the polynomials, b and a.
//
// The quotient is defined as

// B(s)    M       r(m)        N
// ---- = SUM ------------- + SUM k(i)*s^(N-i)
// A(s)   m=1 (s-p(m))^e(m)   i=1

// where M is the number of poles (the length of the r, p,
// and e), the k vector is a polynomial of order N-1
// representing the direct contribution, and the e vector specifies the
// multiplicity of the m-th residue's pole.
//
//NOTE that the polynomials 'b' and 'a' should have real coefficients(because of the function 'filter' used in polyval)
//
//Test case
//1.
// b = [1, 1, 1];
// a = [1, -5, 8, -4];
// [r, p, k, e] = residue (b, a)
//    result r = [-2; 7; 3]
//    result p = [2; 2; 1]
//    result k = [](0x0)
//    result e = [1; 2; 1]
//

//2.
//[r,p,k,e]=residue([1 2 1],[1 -5 8 -4])
//OUTPUT
//r =
//  -3.0000
//   9.0000
//   4.0000
//
//p =
//   2.0000
//   2.0000
//   1.0000
//
//f = [](0x0)
//e =
//   1
//   2
//   1
//


 [nargout,nargin]=argn();

  if (nargin < 2 | nargin > 4)
    error ("wrong umber of input arguments");
  end

  toler = .001;

  if (nargin >= 3)
    if (nargin >= 4)
      e = varargin(2);
    else
      e = [];
    end
    // The inputs are the residue, pole, and direct part. Solve for the
    // corresponding numerator and denominator polynomials
    [r, p] = rresidue (b, a, varargin(1), toler, e);
    return;
  end

  // Make sure both polynomials are in reduced form.

  a = polyreduce (a);
  b = polyreduce (b);

  b = b / a(1);
  a = a / a(1);

  la = length (a);
  lb = length (b);

  // Handle special cases here.

  if (la == 0 | lb == 0)
    k =[];
    r = [];
    p = [];
    e = [];
    return;
  elseif (la == 1)
    k = b / a;
    r = [];
    p = [];
    e = [];
    return;
  end

  // Find the poles.

  p = roots (a);
  lp = length (p);

  // Sort poles so that multiplicity loop will work.

  [e, indx] = mpoles (p, toler, 0);
  p = p(indx);

  // For each group of pole multiplicity, set the value of each
  // pole to the average of the group. This reduces the error in
  // the resulting poles.

  p_group = cumsum (e == 1);
  for ng = 1:p_group($)
    m = find (p_group == ng);
    p(m) = mean (p(m));
  end

  // Find the direct term if there is one.

  if (lb >= la)
    // Also return the reduced numerator.
    [k, b] = deconv (b, a);
    lb = length (b);
  else
    k = [];
  end

  // Determine if the poles are (effectively) zero.

  small = max (abs (p));
  if (type(a)==1 | type(b)==1)
    small = max ([small, 1]) * 1.1921e-07 * 1e4 * (1 + length (p))^2;
  else
    small = max ([small, 1]) * %eps * 1e4 * (1 + length (p))^2;
  end
  p(abs (p) < small) = 0;

  // Determine if the poles are (effectively) real, or imaginary.

  index = (abs (imag (p)) < small);
  p(index) = real (p(index));
  index = (abs (real (p)) < small);
  p(index) = 1*%i * imag (p(index));

  // The remainder determines the residues.  The case of one pole
  // is trivial.

  if (lp == 1)
    r = polyval (b, p);
    return;
  end

  // Determine the order of the denominator and remaining numerator.
  // With the direct term removed the potential order of the numerator
  // is one less than the order of the denominator.

  aorder = length (a) - 1;
  border = aorder - 1;

  // Construct a system of equations relating the individual
  // contributions from each residue to the complete numerator.

  A = zeros (border+1, border+1);
  B = prepad (matrix (b, [length(b), 1]), border+1, 0,2);
  for ip = 1:length (p)
    ri = zeros (size (p,1),size(p,2));
    ri(ip) = 1;
    A(:,ip) = prepad (rresidue (ri, p, [], toler), border+1, 0,2).';
  end

  // Solve for the residues.
if(size(A,1)~=size(B,1))
    if(size(A,1)<size(B,1))
        A=[A;zeros((size(B,1)-size(A,1)),(size(A,2)))];
    else
        B=[zeros((size(A,1)-size(B,1)),(size(B,2)));B];
    end

    end
  r = A \ B;
  r=r(:,$);

endfunction

function [pnum, pden, e] = rresidue (rm, p, k, toler, e)

  // Reconstitute the numerator and denominator polynomials from the
  // residues, poles, and direct term.
[nargout,nargin]=argn();
  if (nargin < 2 | nargin > 5)
    error ("wrong number of input arguments");
  end

  if (nargin < 5)
    e = [];
  end

  if (nargin < 4)
    toler = [];
  end

  if (nargin < 3)
    k = [];
  end

  if (length (e))
    indx = 1:length (p);
  else
    [e, indx] = mpoles (p, toler, 0);
    p = p(indx);
    rm = rm(indx);
  end

  indx = 1:length (p);

  for n = indx
    pn = [1, -p(n)];
    if (n == 1)
      pden = pn;
    else
      pden = conv (pden, pn);
    end
  end

  // D is the order of the denominator
  // K is the order of the direct polynomial
  // N is the order of the resulting numerator
  // pnum(1:(N+1)) is the numerator's polynomial
  // pden(1:(D+1)) is the denominator's polynomial
  // pm is the multible pole for the nth residue
  // pn is the numerator contribution for the nth residue

  D = length (pden) - 1;
  K = length (k) - 1;
  N = K + D;
  pnum = zeros (1, N+1);
  for n = indx(abs (rm) > 0)
    p1 = [1, -p(n)];
    for m = 1:e(n)
      if (m == 1)
        pm = p1;
      else
        pm = conv (pm, p1);
      end
    end
    pn = deconv (real(pden),real(pm));
    pn = rm(n) * pn;
    pnum = pnum + prepad (real(pn), N+1, 0, 2);
  end

  // Add the direct term.

  if (length (k))
    pnum = pnum + conv (pden, k);
  end

  // Check for leading zeros and trim the polynomial coefficients.
  if (type(rm)==1 | type(p)==1 | type(k)==1)
    small = max ([max(abs(pden)), max(abs(pnum)), 1]) * 1.1921e-07;
  else
    small = max ([max(abs(pden)), max(abs(pnum)), 1]) *%eps;
  end

  pnum(abs (pnum) < small) = 0;
  pden(abs (pden) < small) = 0;

  pnum = polyreduce (pnum);
  pden = polyreduce (pden);

endfunction
