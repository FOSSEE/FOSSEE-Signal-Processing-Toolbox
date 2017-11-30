function y = ifftn(A, varargin)
//Compute the inverse N-dimensional discrete Fourier transform of A using a Fast Fourier Transform (FFT) algorithm.
//Calling Sequence
//Y = ifftn(A)
//Y = ifftn(A, size)
//Parameters
//A: Matrix 
//Description
//Compute the inverse N-dimensional discrete Fourier transform of A using a Fast Fourier Transform (FFT) algorithm. The optional vector argument SIZE may be used specify the dimensions of the array to be used.  If an element of SIZE is smaller than the corresponding dimension of A, then the dimension of A is truncated prior to performing the inverse FFT. Otherwise, if an element of SIZE is larger than the corresponding dimension then A is resized and padded with zeros.
//Examples
//ifftn([2,3,4])
//ans = 
//    3.  - 0.5 - 0.2886751i  - 0.5 + 0.2886751i 
funcprot(0);
funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 1 then
	y = callOctave("ifftn",A);
	case 2 then
	y = callOctave("ifftn",A, varargin(1));
	end
endfunction
