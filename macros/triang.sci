function w =  triang (m)
//This function returns the filter coefficients of a triangular window.
//Calling Sequence
//w =  triang (m)
//Parameters
//m: positive integer value
//w: output variable, vector of real numbers
//Description
//This is an Octave function.
//This function returns the filter coefficients of a triangular window of length m supplied as input, to the output vector y.
//Examples
//triang(5)
//ans  =
//    0.3333333
//    0.6666667
//    1.
//    0.6666667
//    0.3333333

funcprot(0);
rhs = argn(2)

  if(rhs~=1)
    error("Wrong number of input arguments.")
  elseif (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("parzenwin: M must be a positive integer");
  end

    w = 1 - abs ([-(m-1):2:(m-1)]' / (m+modulo(m,2)));

endfunction
