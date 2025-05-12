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






function yout = upfirdn(xin,h,p,q)
// Upsample, filter, and downsample a signal.
//
// Syntax
//   yout = upfirdn(xin, h, p, q)
//
// Parameters
// xin: Input signal (vector).
// h: Filter coefficients (vector).
// p: Upsampling factor (positive integer). Default is 1.
// q: Downsampling factor (positive integer). Default is 1.
// yout: Output signal after upsampling, filtering, and downsampling.
//
// Description
// The `upfirdn` function performs three operations on the input signal `xin`:
// 1. Upsampling by a factor `p` (inserting zeros between samples).
// 2. Filtering the upsampled signal using the filter coefficients `h`.
// 3. Downsampling the filtered signal by a factor `q` (keeping every q-th sample).
//
// Examples
// // Perform upsampling, filtering, and downsampling:
//    xin = 1:10;
//    h = [1, 2, 1];
//    p = 2;
//    q = 3;
//    yout = upfirdn(xin, h, p, q);
//
// // Default upsampling and downsampling factors (p = 1, q = 1):
//    xin = 1:10;
//    h = [1, 2, 1];
//    yout = upfirdn(xin, h);
//
// // Upsample by 2 and downsample by 2:
//    xin = 1:10;
//    h = [1];
//    yout = upfirdn(xin, h, 2, 2);
//
// Authors
// FOSSEE Team
// toolbox@scilab.in

[nargout,nargin]=argn();

if(nargin < 2)
		error("usage : yout = upfirdn(xin,h,p,q)");
	end

	if(nargin < 3)
		p = 1;
		q = 1;
	end

	if(nargin < 4)
		q = 1;
	end

	if(floor(p) ~= p | floor(q) ~= q | p < 1 | q < 1)
		error('p and q must be positive integer');
	end

	yout = upsample(xin,p);
	yout = filter(h,1,yout);
	yout = downsample(yout,q);

endfunction
