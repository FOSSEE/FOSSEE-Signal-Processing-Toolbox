function w = boxcar(m)
// Generate a rectangular (boxcar) window.
//
// Syntax
//   w = boxcar(m)
//
// Parameters
// m: Positive integer. Length of the rectangular window.
//
// Description
// This function generates a rectangular (boxcar) window of length `m`. The window has constant amplitude across its length.
//
// Examples
// w = boxcar(5)
// 

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
