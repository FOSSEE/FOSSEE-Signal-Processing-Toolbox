function c = hamming (m, opt)
// Generate the filter coefficients of a Hamming window.
//
// Syntax
//   c = hamming(m)
//   c = hamming(m, "periodic")
//   c = hamming(m, "symmetric")
//
// Parameters
// m: the length of the Hamming window. Must be a positive integer.
// opt: (optional) specifies the type of the window. Can be "periodic" or "symmetric".
//
// Description
// Return the filter coefficients of a Hamming window of length m.
//
// If the optional argument "periodic" is given, the periodic form of the window is returned. 
// This is equivalent to the window of length m+1 with the last coefficient removed. 
// The optional argument "symmetric" is equivalent to not specifying a second argument.
//
// For a definition of the Hamming window, see, e.g., A.V. Oppenheim & R. W. Schafer, 
// Discrete-Time Signal Processing.
//
// Examples
// c = hamming(10)
// c = hamming(10, "periodic")
// c = hamming(10, "symmetric")
//
// Bibliography
//   A.V. Oppenheim & R. W. Schafer, Discrete-Time Signal Processing

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
        error ("hamming: window type must be either periodic or symmetric");
    end
  end

  if (m == 1)
    c = 1;
  else
    m = m - 1;
    c = 0.54 - 0.46 * cos (2 * %pi * (0 : m)' / N);
  end

endfunction
