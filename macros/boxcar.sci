function w = boxcar (m)

 funcprot(0);
    rhs= argn(2);

  if (rhs ~= 1)
     error("Wrong Number of input arguments");
  end

  if (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("boxcar: M must be a positive integer");
  end

  w=ones(m,1);

endfunction
