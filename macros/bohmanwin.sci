function w = bohmanwin (m)

 funcprot(0);
    rhs= argn(2);

  if (rhs ~= 1)
     error("Wrong Number of input arguments");
  end

  if (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("bohmanwin: M must be a positive integer");
  end

  if (m == 1)
    w = 1;
  else
    N = m - 1;
    n = -N/2:N/2;

    w = (1-2.*abs(n)./N).*cos(2*%pi.*abs(n)./N) + (1/%pi).*sin(2*%pi.*abs(n)./N);
    w(1) = 0;
    w(length(w))=0;
    w = w';
  end

endfunction
