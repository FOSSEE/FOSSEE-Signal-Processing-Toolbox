
function w = rectwin (m)
// This function returns the filter coefficients of a rectangular window.
//
// Syntax
// y = rectwin (m)
//
// Parameters
// m: positive integer value
// y: output variable, vector of real numbers
//
// Description
//This function returns the filter coefficients of a rectangular window of length m supplied as input, to the output vector y.
//
// Examples
//rectwin(3)
// 


 funcprot(0);
    rhs= argn(2);

  if (rhs ~= 1)
     error("Wrong Number of input arguments");
  end

  if (~ (isscalar (m) & (m == fix (m)) & (m > 0)))
    error ("rectwin: M must be a positive integer");
  end

  w=ones(m,1);

endfunction
