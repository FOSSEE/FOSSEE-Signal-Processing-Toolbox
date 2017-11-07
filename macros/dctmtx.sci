function [y]= dctmtx(n)

// Performs Direct Cosine Transformation
// Calling Sequence
//	[y]=dctmtx(n)
// Parameters
//	n: Real scalar integer greater than or equal to 1
// Description
//	This is an Octave function
//	dctmtx(n) returns a Discrete cosine transform matrix of order n-by-n. It is useful for jpeg image compression. D*A is the DCT of the columns of A and D'*A is the inverse DCT of the columns of A (when A is n-by-n).
// Examples
// 1.	dctmtx(2)
//	ans = [0.70711   0.70711;   0.70711  -0.70711]
// 2.	dctmtx(3)
//	ans = [5.7735e-01   5.7735e-01   5.7735e-01;
//	       7.0711e-01   4.9996e-17  -7.0711e-01;
//	       4.0825e-01  -8.1650e-01   4.0825e-01]

funcprot(0);
rhs=argn(2);
if (rhs<1) then
	error ("Wrong number of input arguments.")
else [y]=callOctave("dctmtx",n)
end
endfunction
