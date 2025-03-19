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
function [b, r] = deconv (y, a)

  if (nargin ~= 2)
    error("deconv : Two arguments are required ");
  end

    if (~isvector(y) && ~isscalar(y))
        error ("deconv: Y must be vector");
    end
if ( ~isvector(a) && ~isscalar(a))
    error ("deconv: A must be vector");
end

  // Ensure A is oriented as Y.
  if ((size(y,1)==1 && size(a,2)==1) || (size(y,2)==1 && size(a,1)==1))
    a = a.';
  end

  la = length (a);
  ly = length (y);

  lb = ly - la + 1;

  if (ly > la)
    x = zeros (size (y,1) - size (a,1) + 1,size(y,2)-size(a,2)+1);
    x(1) = 1;
    [b, r] = filter (y, a, x);
    r = r * a(1);
  elseif (ly == la)
    [b, r] = filter (y, a, 1);
    r = r * a(1);
  else
    b = 0;
    r = y;
  end

  if (nargout() > 1)
    if (ly >= la)
      r = [zeros(ly - la + 1, 1); r(1:la - 1)];
      // Respect the orientation of Y
      r = matrix (r, size (y,1),size(y,2));
    end
  end
endfunction

/*
 //test
 [b, r] = deconv ([3, 6, 9, 9], [1, 2, 3]);
 assert_checkequal (b, [3, 0]);
 assert_checkequal (r, [0, 0, 0, 9]);

 //test
 [b, r] = deconv ([3, 6], [1, 2, 3]);
 assert_checkequal (b, 0);
 assert_checkequal (r, [3, 6]);

 //test
 [b, r] = deconv ([3, 6], [1; 2; 3]);
 assert_checkequal (b, 0);
 assert_checkequal (r, [3, 6]);

//test
 [b,r] = deconv ([3; 6], [1; 2; 3]);
 assert_checkequal (b, 0);
 assert_checkequal (r, [3; 6]);

//test
 [b, r] = deconv ([3; 6], [1, 2, 3]);
 assert_checkequal (b, 0);
 assert_checkequal (r, [3; 6]);

 assert_checkequal (deconv ((1:3)',[1, 1]), [1; 1])

// Test input validation
// error deconv (1)
// error deconv (1,2,3)
// error <Y .* must be vector> deconv ([3, 6], [1, 2; 3, 4])
// error <A must be vector> deconv ([3, 6], [1, 2; 3, 4])

//test
 y = (10:-1:1);
 a = (4:-1:1);
 [b, r] = deconv (y, a);
 assert_checkequal (conv (a, b) + r, y);


//test
 [b, r] = deconv ([1, 1], 1);
 assert_checkequal (r, [0, 0]);

//test
 [b, r] = deconv ([1; 1], 1);
 assert_checkequal (r, [0; 0]);

 */
