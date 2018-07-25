//Simulate an ARCH sequence of length t with AR coefficients b and CH coefficients a.

//Calling Sequence
//arch_rnd (a, b, t)

//Parameters
//a: CH coefficients
//b: AR coefficients
//t: Length of ARCH sequence

//Description
//This is an Octave function.
//It Simulates an ARCH sequence of length t with AR coefficients b and CH coefficients a.
//The result y(t) follows the model
//
//y(t) = b(1) + b(2) * y(t-1) + … + b(lb) * y(t-lb+1) + e(t),
//where e(t), given y up to time t-1, is N(0, h(t)), with
//
//h(t) = a(1) + a(2) * e(t-1)^2 + … + a(la) * e(t-la+1)^2

//Examples
//a = [1 2 3 4 5];
//b = [7 8 9 10];
//t = 5 ;
//arch_rnd (a, b, t)
//Output
// ans  =
//
//    7.2113249
//    65.479684
//    654.00814
//    7194.6572
//    78364.905



//function res = arch_rnd (a, b, t)
//funcprot(0);
//lhs = argn(1)
//rhs = argn(2)
//if (rhs < 3 | rhs > 3)
//error("Wrong number of input arguments.")
//end
//
//select(rhs)
//
//	case 3 then
//	res = callOctave("arch_rnd",a, b, t)
//
//	end
//endfunction


function y = arch_rnd (a, b, t)

  funcprot(0);
  [nargout, nargin] = argn() ;

  if (nargin ~= 3)
    error("arch_rnd: invalid input arguments")
  end

  if (~ ((min (size (a)) == 1) & (min (size (b)) == 1)))
    error ("arch_rnd: A and B must both be scalars or vectors");
  end
  if (~ (isscalar (t) & (t > 0) & (modulo(t, 1) == 0)))
    error ("arch_rnd: T must be a positive integer");
  end

  if (~ (a(1) > 0))
    error ("arch_rnd: A(1) must be positive");
  end
  // perhaps add a test for the roots of a(z) here ...

  la = length (a);
  a  = matrix(a, 1, la);
  if (la == 1)
    a  = [a, 0];
    la = la + 1;
  end

  lb = length (b);
  b  = matrix(b, 1, lb);
  if (lb == 1)
    b  = [b, 0];
    lb = lb + 1;
  end
  m = max ([la, lb]);

  e = zeros (t, 1);
  h = zeros (t, 1);
  y = zeros (t, 1);

  h(1) = a(1);
  e(1) = sqrt (h(1)) * rand();
  y(1) = b(1) + e(1);

  for t = 2:m
    ta   = min ([t, la]);
    h(t) = a(1) + a(2:ta) * e(t-ta+1:t-1).^2;
    e(t) = sqrt (h(t)) * rand() ;
    tb   = min ([t, lb]);
    y(t) = b(1) + b(2:tb) * y(t-tb+1:t-1) + e(t);
  end

  if (t > m)
    for t = m+1:t
      h(t) = a(1) + a(2:la) * e(t-la+1:t-1).^2;
      e(t) = sqrt (h(t)) * rand() ;
      y(t) = b(1) + b(2:lb) * y(t-tb+1:t-1) + e(t);
    end
  end

  y = y(1:t);

endfunction
