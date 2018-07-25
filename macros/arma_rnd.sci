//Return a simulation of the ARMA model.

//Calling Sequence
//arma_rnd (a, b, v, t, n)
//arma_rnd (a, b, v, t)

//Parameters
//a: vector
//b: vector
//v: Variance
//t: Length of output vector
//n: Number of dummy x(i) used for initialization

//Description
//This is an Octave function.
//The ARMA model is defined by
//
//x(n) = a(1) * x(n-1) + … + a(k) * x(n-k)
//     + e(n) + b(1) * e(n-1) + … + b(l) * e(n-l)
//in which k is the length of vector a, l is the length of vector b and e is Gaussian white noise with variance v. The function returns a vector of length t.
//
//The optional parameter n gives the number of dummy x(i) used for initialization, i.e., a sequence of length t+n is generated and x(n+1:t+n) is returned. If n is omitted, n = 100 is used.

//Examples
//a = [1 2 3 4 5];
//b = [7 8 9 10 11];
//v = 10;
//t = 5;
//n = 100;
//arma_rnd (a, b, v, t, n)
//Output :
// ans  =
//
//    61400.907
//    158177.11
//    407440.29
//    1049604.
//    2703841.3


//function res = arma_rnd (a, b, v, t, n)
//funcprot(0);
//lhs = argn(1)
//rhs = argn(2)
//if (rhs < 5 | rhs > 6)
//error("Wrong number of input arguments.")
//end
//
//select(rhs)
//
//	case 5 then
//	res = callOctave("arma_rnd",a, b, v, t)
//
//	case 6 then
//	res = callOctave("arma_rnd",a, b, v, t, n)
//
//	end
//endfunction

function x = arma_rnd (a, b, v, t, n)

  funcprot();
  [nargout,nargin] = argn() ;

  if (nargin == 4)
    n = 100;
  elseif (nargin == 5)
    if (~ isscalar (n))
      error ("arma_rnd: N must be a scalar");
    end
  else
    error("arma_rnd: invalid input");
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

  // Apply our notational convention.
  a = [1; -a];
  b = [1; b];

  n = min (n, ar + br);

  e = sqrt (v) * rand(t + n, 1);

  x = filter (b, a, e);
  x = x(n + 1 : t + n);

endfunction
