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

//Function y=upfirdn(xin,h,p,q)
//
//this function upsamples the input data xin by factor "p", filters it using fiter coefficients "h" and the downsamples this filtered data by a factor "q".
//Esentially it is a cascade of three processes:
//1)Upsampling(Interpolation)
//2)Filtering
//3)Downsampling(Decimation)


//Test cases:

//1.yout=upfirdn (1:100, 1, 1, 1)
//Expected output: yout=1:100

//2.yout=upfirdn (1:100, 1, 1, 2)
//Expected outut: yout=1:2:100




function yout = upfirdn(xin,h,p,q)

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
