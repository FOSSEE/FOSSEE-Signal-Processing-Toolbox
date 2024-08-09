function y = tripuls(t, w, skew)
//This function generates a triangular pulse over the interval [-w/2, w/2] sampled at times t. 
//Calling Sequence:
//y = tripuls(t)
//y = tripuls(t, w)
//y = tripuls(t, w, skew)
//Parameters: 
//t: Vector of real numbers
//w: Real number. The default value is 1.
//skew: Real number in the interval [-1, 1], The default value is 0.
//Description:
//This function generates a triangular pulse which is sampled at times t over the interval [-w/2,w/2].
//The value of skew lies between -1 and 1. The value of skew represents the relative placement of the peak in the given width.
//Examples:
//tripuls([0, .5, .6, 1], 0.9)
//ans =
//   1   0   0   0

  funcprot(0);
  rhs= argn(2);
  if (rhs < 1 | rhs > 3)
    error("tripuls: wrong number of input arguments");
  end
  
  if (rhs == 1)
    w = 1;
    skew = 0;
    else if (rhs == 2)
      skew = 0;
    end
  end

  if (~isreal(w) | ~isscalar(w))
    error ("tripuls: arg2 (W) must be a real scalar");
  end

  if (~isreal(skew) | ~isscalar(skew) | skew < -1 | skew > 1)
    error ("tripuls: arg3 (SKEW) must be a real scalar in the range [-1, 1]");
  end
  
  y = zeros(size(t, 'r'), size(t, 'c'));
  peak = skew * w/2;

  idx = find((t >= -w/2) & (t <= peak));
  if (idx)
    y(idx) = (t(idx) + w/2) / (peak + w/2);
  end

  idx = find((t > peak) & (t < w/2));
  if (idx)
    y(idx) = (t(idx) - w/2) / (peak - w/2);
  end

endfunction

//input validation:
//assert_checkerror("tripuls()", "tripuls: wrong number of input arguments");
//assert_checkerror("tripuls(1, 2, 3, 4)", "Wrong number of input arguments.");
//assert_checkerror("tripuls(1, 2*%i)", "tripuls: arg2 (W) must be a real scalar");
//assert_checkerror("tripuls(1, 2, 2)", "tripuls: arg3 (SKEW) must be a real scalar in the range [-1, 1]");
//assert_checkerror("tripuls(1, 2, -2)", "tripuls: arg3 (SKEW) must be a real scalar in the range [-1, 1]");

//tests:
//assert_checkequal(tripuls([]), []);
//assert_checkequal(tripuls([], 0.1), []);
//assert_checkequal(tripuls(zeros (10, 1)), ones (10, 1));
//assert_checkequal(tripuls(-1:1), [0, 1, 0]);
//assert_checkequal(tripuls(-5:5, 9), [0, 1, 3, 5, 7, 9, 7, 5, 3, 1, 0] / 9);
//assert_checkequal(tripuls(0:1/100:0.3, 0.1), tripuls([0:1/100:0.3]', 0.1)');
