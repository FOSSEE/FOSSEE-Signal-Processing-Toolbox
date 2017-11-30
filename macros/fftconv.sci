function y = fftconv(X, Y, varargin)
//Convolve two vectors using the FFT for computation.
//Calling Sequence
//Y = fftconv(X, Y)
//Y = fftconv(X, Y, N)
//Parameters
//X, Y: Vectors 
//Description
//Convolve two vectors using the FFT for computation. 'c' = fftconv (X, Y)' returns a vector of length equal to 'length(X) + length (Y) - 1'.  If X and Y are the coefficient vectors of two polynomials, the returned value is the coefficient vector of the product polynomial.
//Examples
//fftconv([1,2,3], [3,4,5])
//ans = 
//    3.    10.    22.    22.    15. 
funcprot(0);
rhs = argn(2)
if(rhs<2 | rhs>3)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 2 then
	y = callOctave("fftconv", X, Y);
	case 3 then
	y = callOctave("fftconv",X, Y, varargin(1));
	end
endfunction
