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
// Dependencies
// prepad deconv mpoles
function [r, p, k, e] = residue (b, a, varargin)

    if (nargin < 2 || nargin > 4)
      error("residue: Invalid number of arguments");
    end
  
    tol = .001;
  
    if (nargin >= 3)
      if (nargin >= 4)
        e = varargin(2);
      else
        e = [];
      end
      // The inputs are the residue2, pole, and direct part.
      // Solve for the corresponding numerator and denominator polynomials.
      [r, p] = rresidue (b, a, varargin(1), tol, e);
      return;
    end
  
    // Make sure both polynomials are in reduced form, and scaled.
    a = polyreduce (a);
    b = polyreduce (b);
  
    b = b / a(1);
    a = a/ a(1);
  
    la = length (a);
    lb = length (b);
  
    // Handle special cases here.
    if (la == 0 || lb == 0)
      k = [];
      r = [];
      p = [];
      e = [];
      return;
    elseif (la == 1)
      k = b / a;
      r = []
      p = []
      e = [];
      return;
    end
  
    // Find the poles.
    p = roots (a);
    lp = length (p);
  
    // Sort poles so that multiplicity loop will work.
    [e, idx] = mpoles (p, tol, 1);
    p = p(idx);
  
    // For each group of pole multiplicity, set the value of each
    // pole to the average of the group.  This reduces the error in
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
    if ( (type(a)==1) || (type(b)==1))
      small = max ([small, 1]) *  %eps * 1e4 * (1 + length (p))^2;
    else
      small = max ([small, 1]) * %eps * 1e4 * (1 + length (p))^2;
    end
    p(abs (p) < small) = 0;
  
    // Determine if the poles are (effectively) real, or imaginary.
    idx = (abs (imag (p)) < small);
    p(idx) = real (p(idx));
    idx = (abs (real (p)) < small);
    p(idx) = 1*%i * imag (p(idx));
  
    // The remainder determines the residue2s.  The case of one pole is trivial.
    if (lp == 1)
      r = polyval (b, p);
      return;
    end
  
    // Determine the order of the denominator and remaining numerator.
    // With the direct term removed, the potential order of the numerator
    // is one less than the order of the denominator.
    aorder = length (a) - 1;
    border = aorder - 1;
  
    // Construct a system of equations relating the individual
    // contributions from each residue2 to the complete numerator.
    A = zeros (border+1, border+1);
  
    B = prepad (matrix (b, [length(b), 1]), border+1, 0);
    B = B(:); // incase b have only 1 element
    for ip = 1:length (p)
      ri = zeros (size (p,1),size(p,2));
      ri(ip) = 1;
     // A(:,ip) = prepad (rresidue (ri, p, [], tol), border+1, 0).';// invalid index error
     temprr=rresidue (ri, p, [], tol)
     ppr=prepad(temprr,border+1,0)
     A(:,ip) = ppr 
    end
  
    // Solve for the residue2s.
    // FIXME: Use a pre-conditioner d to make A \ B work better (bug #53869).
    //        It would be better to construct A and B so they are not close to
    //        singular in the first place.
    d = max (abs (A),'c');

    r = (diag (d) \ A) \ (B ./ d);
  
  endfunction
  
  // Reconstitute the numerator and denominator polynomials
  // from the residue2s, poles, and direct term.
  function [pnum, pden, e] = rresidue (r, p, k, tol, e )
    
    if nargin < 3 then k = [] ; end
    if nargin < 4 then tol = [] ; end
    if nargin < 5 then e = [] ; end
    if (~isempty (e))
      idx = 1:length (p);
    else
      [e, idx] = mpoles (p, tol, 0);
      p = p(idx);
      r = r(idx);
    end
  
    idx = 1:length (p);
    for n = idx
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
    // pm is the multiple pole for the nth residue2
    // pn is the numerator contribution for the nth residue2
  
    D = length (pden) - 1;
    K = length (k) - 1;
    N = K + D;
    pnum = zeros (1, N+1);
    for n = idx(abs (r) > 0)
      p1 = [1, -p(n)];
      pn = 1;
      for j = 1:n - 1
        pn = conv (pn, [1, -p(j)]);
      end
      for j = n + 1:length (p)
        pn = conv (pn, [1, -p(j)]);
      end
      for j = 1:e(n) - 1
        pn = deconv (pn, p1);
      end
      pn = r(n) * pn;
      pnum = pnum + prepad (pn, N+1, 0, 2);
    end
  
    // Add the direct term.
    if (length (k))
      pnum = pnum + conv (pden, k);
    end
  
    pnum = polyreduce (pnum);
    pden = polyreduce (pden);
  
  endfunction
  
function y = polyreduce(p)
    // Remove leading zeros from the polynomial
    idx = find(p, 1)
    if isempty(idx) then
        y = 0;
    else
        y = p(idx(1):$);
    end
endfunction
/*
//test passed
 b = [1, 1, 1];
 a = [1, -5, 8, -4];
 [r, p, k, e] = residue (b, a);
 assert_checkalmostequal (r, [-2; 7; 3], 1e-12);
 assert_checkalmostequal (p, [2; 2; 1], 1e-12);
 assert_checkalmostequal (k,[]);
 assert_checkalmostequal (e, [1; 2; 1]);
 k = [1 0];
 b = conv (k, a) + prepad (b, length (k) + length (a) - 1, 0);
 a = a;
 [br, ar] = residue (r, p, k);
 assert_checkalmostequal (br, b,1e-12);
 assert_checkalmostequal (ar, a,1e-12);
 [br, ar] = residue (r, p, k, e);
 assert_checkalmostequal (br, b,1e-12);
 assert_checkalmostequal (ar, a,1e-12);

//test passed
 b = [1, 0, 1];
 a = [1, 0, 18, 0, 81];
 [r, p, k, e] = residue (b, a); // error filter: Wrong type for input argument #1: Real matrix or polynomial expect
 FIXME :  builtin filter doesn't support complex paramters 
 r1 = [-5*%i; 12; +5*%i; 12]/54;
 p1 = [+3*%i; +3*%i; -3*%i; -3*%i];
 assert_checkalmostequal (r, r1, 1e-12);
 assert_checkalmostequal (p, p1, 1e-12);
 assert_checkalmostequal (k,[]);
 assert_checkalmostequal (e, [1; 2; 1; 2]);
 [br, ar] = residue (r, p, k);
 assert_checkalmostequal (br, b, 1e-12);
 assert_checkalmostequal (ar, a, 1e-12);

//test passed
 r = [7; 3; -2];
 p = [2; 1; 2];
 k = [1 0];
 e = [2; 1; 1];
 [b, a] = residue (r, p, k, e);
 assert_checkalmostequal (b, [1, -5, 9, -3, 1], 1e-12);
 assert_checkalmostequal (a, [1, -5, 8, -4], 1e-12);

 
 [rr, pr, kr, er] = residue (b, a);
 [_, m] = mpoles (rr);
 [_, n] = mpoles (r);
 assert_checkalmostequal (rr(m), r(n), 1e-12);
 assert_checkalmostequal (pr(m), p(n), 1e-12);
 assert_checkalmostequal (kr, k, 1e-12);
 assert_checkalmostequal (er(m), e(n), 1e-12);

//test passed
 b = [1];
 a = [1, 10, 25];
 [r, p, k, e] = residue (b, a);
 r1 = [0; 1];
 p1 = [-5; -5];
 assert_checkalmostequal (r, r1, 1e-12);
 assert_checkalmostequal (p, p1, 1e-12);
 assert_checkalmostequal (k,[]);
 assert_checkalmostequal (e, [1; 2]);
 [br, ar] = residue (r, p, k);
 assert_checkalmostequal (br, b, 1e-12);
 assert_checkalmostequal (ar, a, 1e-12);

// The following //test is due to Bernard Grung
//test <*34266> passed
 z1 =  7.0372976777e6;
 p1 = -3.1415926536e9;
 p2 = -4.9964813512e8;
 r1 = -(1 + z1/p1)/(1 - p1/p2)/p2/p1;
 r2 = -(1 + z1/p2)/(1 - p2/p1)/p2/p1;
 r3 = (1 + (p2 + p1)/p2/p1*z1)/p2/p1;
 r4 = z1/p2/p1;
 r = [r1; r2; r3; r4];
 p = [p1; p2; 0; 0];
 k = [];
 e = [1; 1; 1; 2];
 b = [1, z1];
 a = [1, -(p1 + p2), p1*p2, 0, 0];
 [br, ar] = residue (r, p, k, e);
 assert_checkalmostequal (br, [0,0,b],%eps,1e-8);
 assert_checkalmostequal (ar, a, %eps,1e-8);

//test <*49291> passed
 rf = [1e3, 2e3, 1e3, 2e3];
 cf = [316.2e-9, 50e-9, 31.6e-9, 5e-9];
 [num, den] = residue (1./cf,-1./(rf.*cf),0);
 assert_checkalmostequal (length (num), 4);
 assert_checkalmostequal (length (den), 5);
 assert_checkalmostequal (den(1), 1);

//test <*51148> passed
 r = [1.0000e+18, 3.5714e+12, 2.2222e+11, 2.1739e+10];
 pin = [-1.9231e+15, -1.6234e+09, -4.1152e+07, -1.8116e+06];
 k = 0;
 [p, q] = residue (r, pin, k);
 assert_checkalmostequal (p(4), 4.6828e+42, 1e-5);

//test <*60384> passed
 B = [1315.789473684211];
 A = [1, 1.100000536842105e+04, 1.703789473684211e+03, 0];
 poles1 = roots (A);
 [r, p, k, e] = residue (B, A);
 [B1, A1] = residue (r, p, k, e);
 assert_checkalmostequal (B, B1);
 assert_checkalmostequal (A, A1);

%/
