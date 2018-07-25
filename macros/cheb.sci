function T = cheb (n, x)

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
