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

function y = wkeep(x,l,opt )
// Extracts a vector from the given vector of length l
// Calling Sequence
//	[y]=wkeep(x,l)
//	[y]=wkeep(x,l,opt)
// Parameters
//	x: Real, complex or string type input vector or matrix
//	l: Length of matrix required
//	opt: Character input to determine which side to extract from
// Description
//	This is an Octave function
//	[y]=wkeep(x,l) extracts a vector of length l from the centre of input vector x.
//	[y]=wkeep(x,l,opt) extracts vector based on opt which could be 'l','r' or 'c' (left, right or central).
// Examples
// 1.	[y]=wkeep([1 2 3;4 5 6],[2 2])
//	y=  1   2
// 2.	[y]=wkeep([1 2 3 4 5 6],3,'r')
//	y=  4   5   6


[nargout,nargin]=argn();

  if (nargin < 2 | nargin > 3)
       error("wrong number of input arguments");
       end
  if(isvector(x))

    if(l > length(x))
      error('l must be less than or equal the size of x');
    end

    if(opt=='c')
      s = (length(x)-l)./2;
      y = x(1+floor(s):$-ceil(s));

    elseif(opt=='l')
      y=x(1:l);

    elseif(opt=='r')
      y = x($-l+1:$);

    else
      error('opt must be equal to c, l or r');
    end
  else
   if(max(size(l,1),size(l,2)) == 2)
      s1 = (max(size(x,1),size(x,2))-l(1))./2;
      s2 = (max(size(x,1),size(x,2))-l(2))./2;
    else
        disp("entered the else" )    ///remove later
      error('For a matrix l must be a 1x2 vector');
    end

    if(nargin==2)
      y = x(1+floor(s1):$-ceil(s1),1+floor(s2):$-ceil(s2));
    else
      if(max(size(opt,1),size(opt,2)) == 2)
        firstr=opt(1);
        firstc=opt(2);
      else
          disp("entered the else2")    ////remove later
        error('For a matrix l must be a 1x2 vector');
      end

      y=x(firstr:firstr+l(1)-1,firstc:firstc+l(2)-1);
    end

  end

endfunction
