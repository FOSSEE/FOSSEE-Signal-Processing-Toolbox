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

function y = gmonopuls(t, fc )
// Gaussian monopulse of amplitude unity.
// 
// Syntax
//	[y]=gmonopuls(t)
//	[y]=gmonopuls(t,fc)
// 
// Parameters
// t: Real or complex valued vector or matrix
// fc: Real non-negative value or complex value or a vector or matrix with not all real values negative.
// 
// Description
// This function returns samples of the Gaussian monopulse of amplitude unity.
// 
// Examples
// gmonopuls([1 2 3],0.1)
// 



    [nargout,nargin]=argn();

  if (nargin<1 | nargin > 2)
       error("wrong number of input arguments");
   end
   if(isempty(fc))
       fc=1e3;
       end

  if fc < 0
       error("fc must be positive");
        end
  y = 2*sqrt(exp(1)) .* %pi.*t.*fc.*exp(-2 .* (%pi.*t.*fc).^2);

endfunction
