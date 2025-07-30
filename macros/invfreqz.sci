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

function [B, A, SigN] = invfreqz(H, F, nB, nA, W, iter, tol, tr, varargin)
// Fit filter B(z)/A(z) to the complex frequency response H at frequency points F.
//
// Syntax
//   [B, A] = invfreqz(H, F, nB, nA)
//   [B, A] = invfreqz(H, F, nB, nA, W)
//   [B, A] = invfreqz(H, F, nB, nA, W, iter, tol, 'trace')
//
// Parameters
// H: Desired complex frequency response.
// F: Normalized frequency (0 to π) (must be the same length as H).
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
// The `invfreqz` function fits a rational transfer function B(z)/A(z) to the desired complex frequency response `H` at frequency points `F`. 
// The orders of the numerator and denominator polynomials are specified by `nB` and `nA`, respectively. Optionally, the fit-errors can be 
// weighted using the weights `W`. The function supports iterative refinement of the solution, specified by `iter` and `tol`.
//
// Note: The core implementation of this function relies on `invfreq.sci`.
//
// Examples
//  order = 9  // order of test filter
//  // going to 10 or above leads to numerical instabilities and large errors
//  fc = 1/2   // sampling rate / 4
//  n = 128    // frequency grid size
//  [B0, A0] = butter(order, fc)
//  [H0, w] = freqz(B0, A0, n);
//  Nn = (rand(size(w,1),size(w,2),'normal')+%i*rand(size(w,1),size(w,2),'normal'))/sqrt(2);
//  [Bh, Ah, Sig0] = invfreqz(H0, w, order, order);
//  [Hh, wh] = freqz(Bh, Ah, n);
//  [BLS, ALS, SigLS] = invfreqz(H0+1e-5*Nn, w, order, order, [], [], [], [], "method", "LS");
//  HLS = freqz(BLS, ALS, n);
//  [BTLS, ATLS, SigTLS] = invfreqz(H0+1e-5*Nn, w, order, order, [], [], [], [], "method", "TLS");
//  HTLS = freqz(BTLS, ATLS, n);
//  [BMLS, AMLS, SigMLS] = invfreqz(H0+1e-5*Nn, w, order, order, [], [], [], [], "method", "QR");
//  HMLS = freqz(BMLS, AMLS, n);
//  plot(w,[abs(H0) abs(Hh)])
//  xlabel("Frequency (rad/sample)");
//  ylabel("Magnitude");
//  legend('Original','Measured');
//  err = norm(H0-Hh)
//  disp(sprintf('L2 norm of frequency response error = %f',err));
//  Authors
// FOSSEE Team
// toolbox@scilab.in
//
// Bibliography
// - J. O. Smith, "Techniques for Digital Filter Design and System Identification with Application to the Violin, Ph.D. Dissertation, Elec. Eng. Dept., Stanford University, June 1983.
// - https://ccrma.stanford.edu/~jos/filters/FFT_Based_Equation_Error_Method.html
// 
  // See also
  // invfreq


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
  [B, A, SigN] = invfreq(H, F, nB, nA, W, iter, tol, tr, 'z', varargin);

endfunction
/*
demo       
order = 9;  //order of test filter
//going to 10 or above leads to numerical instabilities and large errors
fc = 1/2;   // sampling rate / 4
n = 128;    // frequency grid size
// butterworth filter of order 9 and fc=0.5
B0 = [5.1819e-03   4.6637e-02   1.8655e-01   4.3528e-01   6.5292e-01   6.5292e-01   4.3528e-01   1.8655e-01  4.6637e-02   5.1819e-03];
A0 = [  1.0000e+00  -8.6736e-16   1.2010e+00  -7.7041e-16   4.0850e-01  -1.7013e-16   4.2661e-02  -9.0155e-18 9.6666e-04  -5.3661e-20];
[H0, w] = freqz(B0, A0, n);
Nn = (rand(size(w,1),size(w,2),'normal')+%i*rand(size(w,1),size(w,2),'normal'))/sqrt(2);
[Bh, Ah, Sig0] = invfreqz(H0, w, order, order);
[Hh, wh] = freqz(Bh, Ah, n);
[BLS, ALS, SigLS] = invfreqz(H0+1e-5*Nn, w, order, order, [], [], [], [], "method", "LS");
[HLS _ ] = freqz(BLS, ALS, n);
[BTLS, ATLS, SigTLS] = invfreqz(H0+1e-5*Nn, w, order, order, [], [], [], [], "method", "TLS");
[HTLS _ ]= freqz(BTLS, ATLS, n);
[BMLS, AMLS, SigMLS] = invfreqz(H0+1e-5*Nn, w, order, order, [], [], [], [], "method", "QR");
[HMLS _ ] = freqz(BMLS, AMLS, n);
plot(w,[abs(H0) abs(Hh)])
xlabel("Frequency (rad/sample)");
ylabel("Magnitude");
legend('Original','Measured');
err = norm(H0-Hh);
disp(sprintf('L2 norm of frequency response error = %f',err));
        
*/
/*
order = 9; 
fc = 1/2; 
n = 128;
B0 = [5.1819e-03   4.6637e-02   1.8655e-01   4.3528e-01   6.5292e-01   6.5292e-01   4.3528e-01   1.8655e-01  4.6637e-02   5.1819e-03];
A0 = [  1.0000e+00  -8.6736e-16   1.2010e+00  -7.7041e-16   4.0850e-01  -1.7013e-16   4.2661e-02  -9.0155e-18 9.6666e-04  -5.3661e-20];
[H0, w] = freqz(B0, A0, n);
Nn = (randn(size(w,1),size(w,2))+i*randn(size(w,1),size(w,2)))/sqrt(2);
[Bh, Ah, Sig0] = invfreqz(H0, w, order, order);
[Hh, wh] = freqz(Bh, Ah, n);
[BLS, ALS, SigLS] = invfreqz(H0+1e-5*Nn, w, order, order, [], [], [], [], "method", "LS");
[HLS _ ] = freqz(BLS, ALS, n);
[BTLS, ATLS, SigTLS] = invfreqz(H0+1e-5*Nn, w, order, order, [], [], [], [], "method", "TLS");
[HTLS _ ]= freqz(BTLS, ATLS, n);
[BMLS, AMLS, SigMLS] = invfreqz(H0+1e-5*Nn, w, order, order, [], [], [], [], "method", "QR");
[HMLS _ ] = freqz(BMLS, AMLS, n);
plot(w,[abs(H0) abs(Hh)])
xlabel("Frequency (rad/sample)");
ylabel("Magnitude");
legend('Original','Measured');
err = norm(H0-Hh);
disp(sprintf('L2 norm of frequency response error = %f',err));
*/
