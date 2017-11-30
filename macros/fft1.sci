function res =  fft1 (x, n, dim)
//Calculates the discrete Fourier transform of a matrix using Fast Fourier Transform algorithm.
//Calling Sequence
//fft (x, n, dim)
//fft (x, n)
//fft (x)
//Parameters 
//x: input matrix
//n: Specifies the number of elements of x to be used
//dim: Specifies the dimention of the matrix along which the FFT is performed
//Description
//This is an Octave function.
//The FFT is calculated along the first non-singleton dimension of the array. Thus, FFT is computed for each column of x.
//
//n is an integer specifying the number of elements of x to use. If n is larger than dimention along. which the FFT is calculated, then x is resized and padded with zeros.
//Similarly, if n is smaller, then x is truncated.
//
//dim is an integer specifying the dimension of the matrix along which the FFT is performed.
//Examples
//x = [1 2 3; 4 5 6; 7 8 9]
//n = 3
//dim = 2
//fft1 (x, n, dim)
//ans =
//
//    6.0000 +  0.0000i   -1.5000 +  0.8660i   -1.5000 -  0.8660i
//   15.0000 +  0.0000i   -1.5000 +  0.8660i   -1.5000 -  0.8660i
//   24.0000 +  0.0000i   -1.5000 +  0.8660i   -1.5000 -  0.8660i

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 1 | rhs > 3)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 1 then
	res = callOctave("fft", x)

	case 2 then
	res = callOctave("fft", x, n)

	case 3 then
	res = callOctave("fft", x, n, dim)

	end
endfunction
