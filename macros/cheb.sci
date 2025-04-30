function T = cheb(n, x)
// Compute the Chebyshev polynomial of the first kind.
//
// Syntax
//   T = cheb(n, x)
//
// Parameters
// n: Non-negative integer. Order of the Chebyshev polynomial.
// x: Scalar or array. Input values.
// T: Scalar or array. Values of the Chebyshev polynomial of the first kind.
//
// Description
// This function computes the Chebyshev polynomial of the first kind of order `n` for the input values `x`. The function supports both scalar and array inputs for `x`.
//
// Examples
// T = cheb(3, 0.5)
// Output:
// T = -1

 funcprot(0);
    rhs= argn(2);

  if (rhs ~= 2)
    error("Wrong Number of input arguments");
  elseif (~(isscalar (n) & (n == round(n)) & (n >= 0)))
    error ("cheb: n has to be a positive integer");
  end

  if (max(size(x)) == 0)
    T = [];
  end
  // avoid resizing latencies
  T = zeros(size(x));
  ind = (abs (x) <= 1);
  if (max(size(ind)))
    T(ind) = cos(n*acos(x(ind)));
  end

  ind = abs (x) > 1;
  if (max(size(ind)))
    T(ind) = cosh(n*acosh(x(ind)));
  end

  T = real(T);

  if(size(x)==[1 1])
    T=T(1);
  end

endfunction
