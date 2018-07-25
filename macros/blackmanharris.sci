function w = blackmanharris (m, opt)

 funcprot(0);
    rhs= argn(2);

  if (rhs < 1 | rhs > 2)
     error("Wrong Number of input arguments");
  end

  if (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("blackmanharris: M must be a positive integer");
  end

  N = m - 1;
  if (rhs == 2)
    select (opt)
      case "periodic"
        N = m;
      case "symmetric"
        N = m-1;
      else
        error ("blackmanharris: window type must be either periodic or symmetric");
    end
  end


  if (m == 1)
    w = 1;
  else
    a0 = 0.35875;
    a1 = 0.48829;
    a2 = 0.14128;
    a3 = 0.01168;
    n = [0:m-1]';
    w = a0 - a1.*cos(2.*%pi.*n./N) + a2.*cos(4.*%pi.*n./N) - a3.*cos(6.*%pi.*n./N);
  end

endfunction
