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

/*
  :[B,A] = invfreqs(H,F,nB,nA)
  :[B,A] = invfreqs(H,F,nB,nA,W) 
  :[B,A] = invfreqs(H,F,nB,nA,W,iter,tol,'trace') 

    Fit filter B(s)/A(s)to the complex frequency response H at frequency points F.

    A and B are real polynomial coefficients of order nA and nB.

    Optionally, the fit-errors can be weighted vs frequency according to the weights W.

    Note: all the guts are in invfreq.m

    H: desired complex frequency response

    F: frequency (must be same length as H)

    nA: order of the denominator polynomial A

    nB: order of the numerator polynomial B

    W: vector of weights (must be same length as F)

*/
// Dependencies
// invfreq
function [B, A, SigN] = invfreqs(H,F,nB,nA,W,iter,tol,tr, varargin)

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




