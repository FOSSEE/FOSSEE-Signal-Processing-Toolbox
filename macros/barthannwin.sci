function w = barthannwin (m)

 funcprot(0);
    rhs= argn(2);

  if (rhs ~= 1)
     error("Wrong Number of input arguments");
  end

  if (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("barthannwin: M must be a positive integer");
  end


   if (m == 1)
    w = 1;
  else
    N = m - 1;
    n = 0:N;

    w = 0.62 -0.48.*abs(n./(m-1) - 0.5)+0.38*cos(2.*%pi*(n./(m-1)-0.5));
    w = w';
  end

endfunction
