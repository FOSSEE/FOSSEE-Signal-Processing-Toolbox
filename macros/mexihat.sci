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



function [psi,x]=mexihat(lb,ub,n)

// Generates Mexican Hat wavelet
// Calling Sequence
//	[psi,x]=mexihat(lb,ub,n)
// Parameters
//	lb: Real or complex valued vector or matrix
//	ub: Real or complex valued vector or matrix
//	n: Real strictly positive scalar number
// Description
//	This is an Octave function which is built in scilab.
//	This function returns values of the Mexican hat wavelet in the specified interval at all the sample points.
// Examples
// 1.	[a,b]= mexihat(1,2,3)
//	a =   [0.00000  -0.35197  -0.35214]
//	b =   [1.0000   1.5000   2.0000]
// 2.	[a,b]= mexihat([1 2 3],1,1)
//	a = [0;0;0]
//	b = [1;1;1]

funcprot(0);

[nargout,nargin]=argn();

  if (nargin < 3)
       error("wrong number of input arguments");
      end

  if (n <= 0)
    error("n must be strictly positive");
  end

  if(isvector(lb))
      for(i=1:length(lb))
  x(i) = linspace(lb(i),ub,n);
  psi(i) = (1-x(i).^2).*(2/(sqrt(3)*%pi^0.25)) .* exp(-x(i).^2/2)  ;
  end

else
    x = linspace(lb,ub,n);
  psi = (1-x.^2).*(2/(sqrt(3)*%pi^0.25)) .* exp(-x.^2/2)  ;
end
endfunction
