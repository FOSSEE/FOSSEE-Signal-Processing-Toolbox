function [a,varargout] = ac2poly(r)
// Convert autocorrelation sequence to polynomial of prediction filter
//
// Calling Sequence
// a = ac2poly(r)
// [a,e] = ac2poly(r)
// 
// Parameters
// r: Autocorrelation sequence to be represented with an FIR linear prediction filter
// a: Output polynomial representing the linear prediction filter e/(a(1) + a(2)z + a(3)z^2 .. a(N)z^N-1)
// e: Output scaling for the lienar prediction filter
//
// Description
// Function ac2poly() finds the best fit polynomial for FIR linear prediction filter a, corresponding to the autocorrelation sequence r. a is the same length as r, and is normalized with the first element. So a(1) = 1.
//
// Author
// Parthe Pandit
// 
// Bibliography
// Kay, Steven M. Modern Spectral Estimation. Englewood Cliffs, NJ: Prentice-Hall, 1988.

//errcheck
if (type(r) > 1) then
	error('Input autocorrelation sequence needs to be of type double');
end

[a,e] = levinson(r);
varargout = list(e);

endfunction
