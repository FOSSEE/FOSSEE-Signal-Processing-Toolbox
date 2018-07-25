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

//Calling sequence:
//  y = upsample (x, n)
//  y = upsample (x, n, offset)
// Upsample the signal, inserting n-1 zeros between every element.
//
// If x is a matrix, upsample every column.
//
// If offset is specified, control the position of the inserted sample in
// the block of n zeros.
//

//Testcases:
//1.upsample([1,3,5],2)
//EXPECTED OUTPUT:[1,0,3,0,5,0]


//2.upsample([1;3;5],2)
//EXPECTED OUTPUT:[1;0;3;0;5;0]


//3.upsample([1,2;5,6;9,10],2)
//EXPECTED OUTPUT:[1,2;0,0;5,6;0,0;9,10;0,0]
//
//



function y = upsample (x,n,phase )
  [nargout,nargin]=argn()

  if (nargin<2 | nargin>3),
        error("wrong no. of input arguments")
        end
if nargin==2
    phase=0;
    else
  if phase > n-1
    warning("This is incompatible with Matlab (phase = 0:n-1). See octave-forge signal package release notes for details." )
  end
end

  [nr,nc] = size(x);
  if (nc==1 | nr==1) then

  if ( nc==1)
    y = zeros(n*nr*nc,1);
   y(phase+1:n:$) = x;
   end
    if (nr==1)
         y = zeros(n*nr*nc,1);
        y(phase+1:n:$) = x';
        y = y.';
        end
  else
    y = zeros(n*nr,nc);
    y(phase + 1:n:$,:) = x;
  end

endfunction
