function [k] = is2rc(isin)
// Convert inverse sine parameters to reflection coefficients
// 
// Calling Sequence
// K = is2rc(isin) 
// 
// Parameters
// isin: input inverse sine parameters. Needs to be an array real numbers
// k: output reflection coefficients  corresponding to the reflection coefficients in input
//
// Description
// This function returns a vector of reflection coefficients from a vector of inverse sine parameters
// output array has k(i) = sin(pi/2*isin(i))
//
// Example
// k = [0.3090 0.9801 0.0031 0.0082 -0.0082];
// isin = rc2is(k)      //Gives inverse sine parameters
// k_dash = is2rc(isin)
//
// See also 
// rc2is
// rc2poly
// rc2ac
// rc2lar
//
// Author
// Parthe Pandit
//
// Bibliography
// J.R. Deller, J.G. Proakis, J.H.L. Hansen, "Discrete-Time Processing of Speech Signals", Prentice Hall, Section 7.4.5

//errcheck1
if (~isreal(isin)),
 error('Input inverse sine coefficients are not real');
end           

k = sin(isin*%pi/2);
endfunction
