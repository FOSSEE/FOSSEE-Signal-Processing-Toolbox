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
// FIXME: check invfreq.sci for todo's


function [B, A, SigN] = invfreqs(H,F,nB,nA,W,iter,tol,tr, varargin)
 // Fit filter B(s)/A(s) to the complex frequency response H at frequency points F.
//
// Syntax
//   [B, A] = invfreqs(H, F, nB, nA)
//   [B, A] = invfreqs(H, F, nB, nA, W)
//   [B, A] = invfreqs(H, F, nB, nA, W, iter, tol, 'trace')
//
// Parameters
// H: Desired complex frequency response.
// F: Frequency (must be the same length as H).
// nA: Order of the denominator polynomial A.
// nB: Order of the numerator polynomial B.
// W: (optional) Vector of weights (must be the same length as F). Default is uniform weighting.
// iter: (optional) Number of iterations for refinement. Default is no iterations.
// tol: (optional) Tolerance for iterations. Default is no tolerance.
// 'trace': (optional) Enables tracing of the iterative process.
// B: Coefficients of the numerator polynomial.
// A: Coefficients of the denominator polynomial.
//
// Description
// The `invfreqs` function fits a rational transfer function B(s)/A(s) to the desired complex frequency response `H` at frequency points `F`. 
// The orders of the numerator and denominator polynomials are specified by `nB` and `nA`, respectively. Optionally, the fit-errors can be 
// weighted using the weights `W`. The function supports iterative refinement of the solution, specified by `iter` and `tol`.
//
// Note: The core implementation of this function relies on `invfreq.sci`.
//
// Examples
// // Fit a filter to a frequency response:
//    B = [1/2, 1];
//    A = [1, 1];
//    w = linspace(0, 4, 128);
//    H = freqs(B, A, w);
//    [Bh, Ah] = invfreqs(H, w, 1, 1);
//    Hh = freqs(Bh, Ah, w);
//    plot(w, [abs(H); abs(Hh)]);
//    legend('Original', 'Measured');
//    err = norm(H - Hh);
//    disp(sprintf('L2 norm of frequency response error = %f', err));
//
// // Fit a filter with weighted frequency samples:
//    B = [1, 0];
//    A = [1, 2, 1];
//    w = linspace(0, 8, 128);
//    H = freqs(B, A, w);
//    W = linspace(1, 2, length(w)); // Example weights
//    [Bh, Ah] = invfreqs(H, w, 2, 2, W);
//    Hh = freqs(Bh, Ah, w);
//    plot(w, [abs(H); abs(Hh)]);
//    legend('Original', 'Measured');
//    err = norm(H - Hh);
//    disp(sprintf('L2 norm of frequency response error = %f', err));
//
// Bibliography
// - J. O. Smith, "Techniques for Digital Filter Design and System Identification with Application to the Violin, Ph.D. Dissertation, Elec. Eng. Dept., Stanford University, June 1983.
// - https://ccrma.stanford.edu/~jos/filters/FFT_Based_Equation_Error_Method.html
// 
// See also
  // invfreq
  // 
// Authors
// FOSSEE Team
// toolbox@scilab.in
//


  if nargin < 9
    varargin = {};
    if nargin < 8
      tr = '';
      if nargin < 7
        tol = [];
        if nargin < 6
          iter = [];
          if nargin < 5
            W = ones(1,length(F));
          end
        end
      end
    end
  end

  // now for the real work
  [B, A, SigN] = invfreq(H, F,nB, nA, W, iter, tol, tr, 's', varargin);

endfunction
/*
demo 
 B = [1 0 0];
 A = [1 6 15 15]/15;
 w = linspace(0, 8, 128);
 [H0 ,_ ] = freqz(B, A, w);
 Nn = (rand(size(w,1),size(w,2),'normal')+%i*rand(size(w,1),size(w,2),'normal'))/sqrt(2);
 order = length(A) - 1;
 [Bh, Ah, Sig0] = invfreqs(H0, w, [length(B)-1 2], length(A)-1);
 [Hh ,_ ] = freqz(Bh,Ah,w);
 [BLS, ALS, SigLS] = invfreqs(H0+1e-5*Nn, w, [2 2], order, [], [], [], [], "method", "LS");
 [HLS,_] = freqz(BLS, ALS, w);
 [BTLS, ATLS, SigTLS] = invfreqs(H0+1e-5*Nn, w, [2 2], order, [], [], [], [], "method", "TLS");
 [HTLS,_] = freqz(BTLS, ATLS, w);
 [BMLS, AMLS, SigMLS] = invfreqs(H0+1e-5*Nn, w, [2 2], order, [], [], [], [], "method", "QR");
 [HMLS,_] = freqz(BMLS, AMLS, w);
 plot(w,[abs(H0); abs(Hh)])
 xlabel("Frequency (rad/sec)");
 ylabel("Magnitude");
 legend('Original','Measured');
 err = norm(H0-Hh);
 disp(sprintf('L2 norm of frequency response error = %f',err));
*/
/*  Octave version
 B = [1 0 0];
 A = [1 6 15 15]/15;
 w = linspace(0, 8, 128);
 [H0 ,_ ] = freqz(B, A, w);
 Nn = (randn(size(w,1),size(w,2))+i*randn(size(w,1),size(w,2)))/sqrt(2);
 order = length(A) - 1;
 [Bh, Ah, Sig0] = invfreqs(H0, w, [length(B)-1 2], length(A)-1);
 [Hh ,_ ] = freqz(Bh,Ah,w);
 [BLS, ALS, SigLS] = invfreqs(H0+1e-5*Nn, w, [2 2], order, [], [], [], [], "method", "LS");
 [HLS,_] = freqz(BLS, ALS, w);
 [BTLS, ATLS, SigTLS] = invfreqs(H0+1e-5*Nn, w, [2 2], order, [], [], [], [], "method", "TLS");
 [HTLS,_] = freqz(BTLS, ATLS, w);
 [BMLS, AMLS, SigMLS] = invfreqs(H0+1e-5*Nn, w, [2 2], order, [], [], [], [], "method", "QR");
 [HMLS,_] = freqz(BMLS, AMLS, w);
 plot(w,[abs(H0); abs(Hh)])
 xlabel("Frequency (rad/sec)");
 ylabel("Magnitude");
 legend('Original','Measured');
 err = norm(H0-Hh);
 disp(sprintf('L2 norm of frequency response error = %f',err));
*/




