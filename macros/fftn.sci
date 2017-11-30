function y = fftn(A, SIZE)
//This function computes the N-dimensional discrete Fourier transform of A using a Fast Fourier Transform (FFT) algorithm.
//Calling Sequence
//Y = fftn(A)
//Y = fftn(A, size)
//Parameters
//A: Matrix 
//Description
//This function computes the N-dimensional discrete Fourier transform of A using a Fast Fourier Transform (FFT) algorithm. The optional vector argument SIZE may be used specify the dimensions of the array to be used.  If an element of SIZE is smaller than the corresponding dimension of A, then the dimension of A is truncated prior to performing the FFT.  Otherwise, if an element of SIZE is larger than the corresponding dimension then A is resized and padded with zeros.
//Examples
//fftn([2,3,4])
//ans = 
//     9.  - 1.5 + 0.8660254i  - 1.5 - 0.8660254i  
funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 1 then
	y = callOctave("fftn",A);
	case 2 then
	y = callOctave("fftn",A, SIZE);
	end
endfunction
