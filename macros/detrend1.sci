function y = detrend1 (x, p)
//Remove the best fit of a polynomial of order p from the data x.
//Calling Sequence:
//detrend1(x,p)
//Parameters: 
//x: Input vecor or matrix
//p: The order of polnomial
//Description:
//If X is a vector, 'detrend1(X, P)' removes the best fit of apolynomial of order P from the data X.
//If X is a matrix, 'detrend1(X, P)' does the same for each column in X.
//The second argument p is optional.  If it is not specified, a value of 1 is assumed.  This corresponds to removing a linear trend.
//The order of the polynomial can also be given as a string, in which case p must be either "constant" (corresponds to 'P=0') or "linear" (corresponds to 'P=1')
//Example:
//detrend1([1, 6, 9])
//ans = [ -0.3333, 0.6667, -0.3333]

  funcprot(0);
  rhs = argn(2);
  if (rhs < 1 | rhs > 2)
    error("detrend1: wrong number of input arguments");
  end
  
  if (rhs == 1)
    p = 1;
  end

  if (~or(type(x)==[1 5 8]) | ndims (x) > 2)
    error ("detrend1: X must be a numeric vector or matrix");
  end

  if (type(p) == 10 & ~strcmp(p, "constant", 'i'))
    p = 0;
  elseif (type(p) == 10 & ~strcmp(p, "linear", 'i'))
    p = 1;
  elseif (~isscalar(p) | p < 0 | p ~= fix (p))
    error ("detrend1: P must be constant, linear, or a positive integer");
  end

  [m, n] = size (x);
  if (m == 1)
    x = x.';
  end

  r = size(x, 'r');
  b = ((1 : r).' * ones (1, p + 1)) .^ (ones (r, 1) * (0 : p));
  y = x - b * (b \ x);

  if (m == 1)
    y = y.';
  end

endfunction
//
//input validation:
//assert_checkerror("detrend1()", "detrend1: wrong number of input arguments");
//a = "string";
//assert_checkerror("detrend1(a)", "detrend1: X must be a numeric vector or matrix");
//assert_checkerror("detrend1(%T)", "detrend1: X must be a numeric vector or matrix");
//assert_checkerror("detrend1(1, -1)", "detrend1: P must be constant, linear, or a positive integer");
//assert_checkerror("detrend1(1, 1.25)", "detrend1: P must be constant, linear, or a positive integer");

//tests:
//N = 32;
//x = (0:1:N-1)/N + 2;
//y = detrend1(x);
//assert_checktrue(abs (y(:)) < 20*%eps);
//assert_checkequal(detrend1([2, 5, 8]), detrend1([2. 5, 8], "linear"));
//assert_checkequal(detrend1([2, 5, 8], 0), detrend1([2. 5, 8], "constant"));
//assert_checkalmostequal(detrend1([1; 6; 9], "constant"), [-4.33333; 0.66666; 3.66666], 5*10^-5);
//assert_checkalmostequal(detrend1([5, 12, 14; 8, 16, 14; 5, 10, 12]), [-1, -1.6666, -0.3333; 2, 3.3333, 0.6666; -1, -1.6666, -0.3333], 5*10^-4);
//assert_checkalmostequal(detrend1([-5-5*%i; 2+%i; -4+3*%i], "linear"), [-2.1667-0.6667*%i; 4.3333+1.3333*%i; -2.1667-0.6667*%i], 5*10^-4);
//assert_checkalmostequal(detrend1([5*%i, 1+2*%i,; -8, -1-6*%i], 0), [4+2.5*%i, 1+4*%i; -4-2.5*%i, -1-4*%i], 5*10^-4);
