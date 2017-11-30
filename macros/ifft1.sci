function res =  ifft1 (x, n, dim)
//Calculates the inverse discrete Fourier transform of a matrix using Fast Fourier Transform algorithm.
//Calling Sequence
//ifft (x, n, dim)
//ifft (x, n)
//ifft (x)
//Parameters 
//x: input matrix
//n: Specifies the number of elements of x to be used
//dim: Specifies the dimention of the matrix along which the inverse FFT is performed
//Description
//This is an Octave function.
//Description
//This is an Octave function.
//The inverse FFT is calculated along the first non-singleton dimension of the array. Thus, inverse FFT is computed for each column of x.
//
//n is an integer specifying the number of elements of x to use. If n is larger than dimention along. which the inverse FFT is calculated, then x is resized and padded with zeros.
//Similarly, if n is smaller, then x is truncated.
//
//dim is an integer specifying the dimension of the matrix along which the inverse FFT is performed.
//Examples
//x = [1 2 3; 4 5 6; 7 8 9]
//n = 3
//dim = 2
//ifft1 (x, n, dim)
//ans =
//
//   2.00000 + 0.00000i  -0.50000 - 0.28868i  -0.50000 + 0.28868i
//   5.00000 + 0.00000i  -0.50000 - 0.28868i  -0.50000 + 0.28868i
//   8.00000 + 0.00000i  -0.50000 - 0.28868i  -0.50000 + 0.28868i

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 1 | rhs > 3)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 1 then
	res = callOctave("ifft", x)

	case 2 then
	res = callOctave("ifft", x, n)

	case 3 then
	res = callOctave("ifft", x, n, dim)

	end
endfunction
