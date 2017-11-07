function [d]=dftmtx(n)

// Computes Discrete n-by-n Fourier transformation matrix
// Calling Sequence
//	[d]=dftmtx(n)
// Parameters
//	n: Real positive scalar number
// Description
//	This is an Octave function
//	This fuction gives a complex matrix of values whose product with a vector produces the discrete Fourier transform. This can also be achieved by directly using the fft function i.e. y=fft(x) is same as y=A*x where A=dftmtx(n).
// Examples
// 1.	dftmtx(3)
//	ans =   1.00000 + 0.00000i   1.00000 + 0.00000i   1.00000 + 0.00000i
//	  	1.00000 + 0.00000i  -0.50000 - 0.86603i  -0.50000 + 0.86603i
//		1.00000 - 0.00000i  -0.50000 + 0.86603i  -0.50000 - 0.86603i

funcprot(0);
rhs=argn(2);
if (rhs<1) then
	error("Wrong number of input arguments.")
else d= callOctave("dftmtx",n)
end
endfunction
