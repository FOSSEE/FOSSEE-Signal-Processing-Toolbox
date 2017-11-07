function [psi,x]=mexihat(lb,ub,n)

// Generates Mexican Hat wavelet
// Calling Sequence
//	[psi,x]=mexihat(lb,ub,n)
// Parameters
//	lb: Real or complex valued vector or matrix
//	ub: Real or complex valued vector or matrix
//	n: Real strictly positive scalar number
// Description
//	This is an Octave function
//	This function returns values of the Mexican hat wavelet in the specified interval at all the sample points.
// Examples
// 1.	[a,b]= mexihat(1,2,3)
//	a =   [0.00000  -0.35197  -0.35214]
//	b =   [1.0000   1.5000   2.0000]
// 2.	[a,b]= mexihat([1 2 3],1,1)
//	a = [0;0;0]
//	b = [1;1;1]

funcprot(0);
rhs=argn(2);
if (rhs<3) then
	error ("Wrong number of input arguments.")
else [psi,x]=callOctave("mexihat",lb,ub,n)
end
endfunction
