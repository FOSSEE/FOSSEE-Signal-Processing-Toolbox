function w = triang(n)
// This function returns the filter coefficients of a triangular window.
//
// Syntax
//   w = triang(n)
//
// Parameters
// n: Window length.
// w: Triangular window.
//
// Description
// This function generates a triangular window of length `n`.
//
// Examples
// w = triang(64)
//

funcprot(0);
rhs = argn(2)

  if(rhs~=1)
    error("Wrong number of input arguments.")
  elseif (~ (isscalar (n) & (n == fix (n)) & (n > 0)))
    error ("parzenwin: M must be a positive integer");
  end

    w = 1 - abs ([-(n-1):2:(n-1)]' / (n+modulo(n,2)));

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
