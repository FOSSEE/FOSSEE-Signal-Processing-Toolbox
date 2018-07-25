function c = hamming (m, opt)

 funcprot(0);
    rhs= argn(2);

  if (rhs < 1 | rhs > 2)
     error("Wrong Number of input arguments");
  end

  if (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("hamming: M must be a positive integer");
  end

  N = m - 1;
  if (rhs == 2)
    select (opt)
      case "periodic"
        N = m;
      case "symmetric"
        //Default option, same as no option specified.
      else
        error ('hamming: window type must be either periodic or symmetric");
    end
  end

  if (m == 1)
    c = 1;
  else
    m = m - 1;
    c = 0.54 - 0.46 * cos (2 * %pi * (0 : m)' / N);
  end

endfunction
