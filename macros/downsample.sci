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


//Function File vary = downsample (x, n)
//Function File y = downsample (x, n, offset)
// Downsample the signal, selecting every nth element.  If x
// is a matrix, downsample every column.
//
// If offset is defined, select every nth element starting at
// sample offset.
//
//

//Test cases:

//1.downsample([1,2,3,4,5],2)
//EXPECTED OUTPUT:[1,3,5]


//2.downsample([1;2;3;4;5],2)
//EXPECTED OUTPUT:[1;3;5]


//3.downsample([1,2;3,4;5,6;7,8;9,10],2)
//EXPECTED OUTPUT:[1,2;5,6;9,10]


//4.downsample([1,2,3,4,5],2,1)
//EXPECTED OUTPUT:[2,4]


//5.downsample([1,2;3,4;5,6;7,8;9,10],2,1)
//EXPECTED OUTPUT:[3,4;7,8]



function y = downsample (x, n, phase)
[nargout,nargin]=argn();
  if (nargin<2 | nargin>3)
       error ("wrong no. of input arguments");
       end

if nargin==2
    phase=0;
    else
  if phase > n-1
    warning("This is incompatible with Matlab (phase = 0:n-1). See octave-forge signal package release notes for details." )
  end
end

  if isvector(x)
    y = x(phase + 1:n:$);
  else
    y = x(phase + 1:n:$,:);
  end

endfunction
