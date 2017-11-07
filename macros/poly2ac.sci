function r = poly2ac(a,efinal)
// Convert prediction polynomial to autocorrelation sequence.
//Run rlevinson.sci before running this
// Calling Sequence
// R = poly2ac(a,efinal)
// 
// Parameters
// a: input prediction polynomial with 1st element 1 (if not, poly2ac normalizes it to 1 before proceeding).
// efinal: input prediction error
// r: output autocorrelation sequence
//
// Description
// This function obtains the underlying autocorrelation sequence that would best fit a linear prediction filter described by the
// denominator polynomial and the numerator scaling. The filter is H(z) = efinal/(a(1) + a(2) x z a(3) x z^2 ... a(n) x z^n-1)
// 
// Examples
//   a = [1.0000 0.4288 0.76 0.0404 -0.02];
//   efinal = 0.2;           // Step prediction error
//   r = poly2ac(a,efinal)   // Autocorrelation sequence
//
// See also
// ac2poly 
// poly2rc 
// rc2poly 
// rc2ac
// ac2rc 
//
// Author: Parthe Pandit
//
// Bibliography
// S. Kay, Modern Spectral Estimation, Prentice Hall, N.J., 1987, Chapter 6.

    //errcheck 1: Check for input format of polynomial
   if (size(a,1) > 1 & size(a,2) > 1)  then
      error("Input polynomial has to be a 1-dimensional array")
    end
    if (length(efinal) > 1)  then
        error("Input efinal has to be a scalar")
    end
         r = rlevinson(a,efinal);
   
endfunction
