function x = arma_rnd (a, b, v, t, n)
//Return a simulation of the ARMA model.
//Calling Sequence:
//arma_rnd (a, b, v, t, n)
//arma_rnd (a, b, v, t)
//Parameters:
//a: Real vector
//b: Real vector
//v: Variance
//t: Length of output vector
//n: Number of dummy x(i) used for initialization
//Description:
//The ARMA model is defined by x(n) = a(1) * x(n-1) + … + a(k) * x(n-k)     + e(n) + b(1) * e(n-1) + … + b(l) * e(n-l)
//in which k is the length of vector a, l is the length of vector b and e is Gaussian white noise with variance v. The function returns a vector of length t.
//The optional parameter n gives the number of dummy x(i) used for initialization, i.e., a sequence of length t+n is generated and x(n+1:t+n) is returned.
//If n is omitted, n = 100 is used.
//Examples:
//a = [1 2 3 4 5];
//b = [7 8 9 10 11];
//v = 10;
//t = 5;
//n = 100;
//arma_rnd (a, b, v, t, n)
//Output :
// ans  =
//    61400.907
//    158177.11
//    407440.29
//    1049604.
//    2703841.3

  funcprot(0);
  [nargout,nargin] = argn() ;

  if (nargin == 4)
    n = 100;
  elseif (nargin == 5)
    if (~ isscalar (n))
      error ("arma_rnd: N must be a scalar");
    end
  else
    error("Wrong number of input arguments.");
  end

  if ((min (size (a)) > 1) | (min (size (b)) > 1))
    error ("arma_rnd: A and B must not be matrices");
  end

  if (~ isscalar (t))
    error ("arma_rnd: T must be a scalar");
  end

  ar = length (a);
  br = length (b);

  a = matrix (a, ar, 1);
  b = matrix (b, br, 1);
  a = [1; -a];
  b = [1; b];

  n = min (n, ar + br);
  e = sqrt (v) * rand(t + n, 1);

  x = filter (b, a, e);
  x = x(n + 1 : t + n);

endfunction

//input validation:
//a = [1, 2, 3, 4];
//b = [5, 6, 7];
//assert_checkerror("arma_rnd()", "Wrong number of input arguments.");
//assert_checkerror("arma_rnd(1, 2, 3, 4, 5, 6)", "Wrong number of input arguments.");
//assert_checkerror("arma_rnd(a, b, 5, 2, a);", "arma_rnd: N must be a scalar");
//assert_checkerror("arma_rnd(a, b, 5, a);", "arma_rnd: T must be a scalar");
//assert_checkerror("arma_rnd([1 2; 3 4], [5 6; 7 8], 5, 1);", "arma_rnd: A and B must not be matrices");

//tests:
//NOTE: The output of arma_rnd is supposed to be random, so we cannot expect the same output for equivalent input.
//a = [1, 2, 3, 4];
//b = [5, 6, 7, 8];
//assert_checkequal(size(arma_rnd(a, b, 5, 1)), [1 1]);
//assert_checkequal(size(arma_rnd(a, b, 5, 2, 100)), [2 1]);
//assert_checkequal(size(arma_rnd(a', b', 1, 10, 50)), [10 1]);
//assert_checkequal(size(arma_rnd(a, b', 1, 4, 5)), [4 1]);
