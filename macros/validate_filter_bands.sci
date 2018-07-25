// Copyright (C) 2018 - IIT Bombay - FOSSEE
//
// This file must be used under the terms of the CeCILL.
// This source file is licensed as described in the file COPYING, which
// you should have received as part of this distribution.  The terms
// are also available at
// http://www.cecill.info/licences/Licence_CeCILL_V2-en.txt
// Original Source : https://octave.sourceforge.io/signal/
// Modifieded by:Sonu Sharma, RGIT Mumbai
// Organization: FOSSEE, IIT Bombay
// Email: toolbox@scilab.in

// Supporting function

function validate_filter_bands (func, wp, ws)
    funcprot();
    nargin = argn(2);

  if (nargin ~= 3)
    error("validate_filter_bands: invalid number of inputs")
  elseif (~ (type(func) == 10))
    error ("validate_filter_bands: FUNC must be a string");
  elseif (~ ((isvector (wp) | length(wp) == 1) & (isvector (ws) | length(ws) == 1) & (length (wp) == length (ws))))
    error (msprintf( "%s: WP and WS must both be scalars or vectors of length 2", func));
  elseif (~ ((length (wp) == 1) | (length (wp) == 2)))
    error (msprintf("%s: WP and WS must both be scalars or vectors of length 2", func));
  elseif (~ (isreal (wp) & and (wp >= 0) & and (wp <= 1)))
    error (msprintf("%s: and elements of WP must be in the range [0,1]",func ));
  elseif (~ (isreal (ws) & and (ws >= 0) & and (ws <= 1)))
    error (msprintf("%s: and elements of WS must be in the range [0,1]",func ));
  elseif ((length (wp) == 2) & (wp(2) <= wp(1)))
    error (msprintf("%s: WP(1) must be less than WP(2)",func ))
  elseif ((length (ws) == 2) & (ws(2) <= ws(1)))
    error (msprintf("%s: WS(1) must be less than WS(2)",func ))
  elseif ((length (wp) == 2) & (and (wp > ws) | and (ws > wp)))
    error (msprintf("%s: WP must be contained by WS or WS must be contained by WP",func ));
  end

endfunction
