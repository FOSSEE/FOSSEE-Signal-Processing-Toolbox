function y = fftw1(x, n, dim)
// Short description on the first line following the function header.
//
// Syntax
//   y = fftw1(x)
//   y = fftw1(x, n)
//   y = fftw1(x, n, dim)
//
// Parameters
// x: Input array.
// n: Number of points for the FFT. Default is the length of `x`.
// dim: Dimension along which to compute the FFT. Default is the first non-singleton dimension.
// y: FFT of the input array.
//
// Description
// This function computes the Fast Fourier Transform (FFT) of the input array `x` using the FFTW library.
//
// Examples
// y = fftw1([1, 2, 3, 4])
//
// See also
//  fft1, ifftw1
//
// Authors
//  Author name ; should be listed one pr line. Use ";" to separate names from additional information 
//
// Bibliography
//   Literature references one pr. line

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 1 | rhs > 2)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 1 then
	res = callOctave("fftw",a)

	case 2 then
	res = callOctave("fftw",a, b)
	end
endfunction
