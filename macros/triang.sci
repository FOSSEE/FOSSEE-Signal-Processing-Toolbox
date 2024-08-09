function w =  triang (m)
//This function returns the filter coefficients of a triangular window.
//Calling Sequence
//w =  triang (m)
//Parameters
//m: positive integer value
//w: output variable, vector of real numbers
//Description
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

//test input validation:
//assert_checkerror("triang()", "Wrong number of input arguments.");
//assert_checkerror("triang(1, 2)", "Wrong number of input arguments.");
//assert_checkerror("triang(0.5)", "parzenwin: M must be a positive integer");
//assert_checkerror("triang(-1)", "parzenwin: M must be a positive integer");
//assert_checkerror("triang(zeros (2, 5))", "parzenwin: M must be a positive integer");

//tests:
//assert_checkequal(triang(1), 1);
//assert_checkequal(triang(2), [1; 1]/2);
//assert_checkequal(triang(3), [1; 2; 1]/2);
//assert_checkequal(triang(4), [1; 3; 3; 1]/4);
