function res = fft21 (A, m, n)
//Calculates the two-dimensional discrete Fourier transform of A using a Fast Fourier Transform algorithm.
//Calling Sequence
//fft2 (A, m, n)
//fft2 (A)
//Parameters 
//A: input matrix
//m: number of rows of A to be used
//n: number of columns of A to be used
//Description
//This is an Octave function.
//It performs two-dimentional FFT on the matrix A. m and n may be used specify the number of rows and columns of A to use. If either of these is larger than the size of A, A is resized and padded with zeros.
//If A is a multi-dimensional matrix, each two-dimensional sub-matrix of A is treated separately.
//Examples
//x = [1 2 3; 4 5 6; 7 8 9]
//m = 4
//n = 4
//fft21 (A, m, n)
//ans =
//
//   45 +  0i   -6 - 15i   15 +  0i   -6 + 15i
//  -18 - 15i   -5 +  8i   -6 -  5i    5 -  4i
//   15 +  0i   -2 -  5i    5 +  0i   -2 +  5i
//  -18 + 15i    5 +  4i   -6 +  5i   -5 -  8i

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 1 | rhs > 3)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 1 then
	res = callOctave("fft2", A)

	case 2 then
	error("Wrong number of input arguments.")

	case 3 then
	res = callOctave("fft2", A, m, n)

	end
endfunction
