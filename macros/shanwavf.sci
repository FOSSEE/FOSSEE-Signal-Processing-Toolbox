function [psi,x]=shanwavf(lb,ub,n,fb,fc)

// Complex Shannon Wavelet
// Calling Sequence
//	[psi,x]=shanwavf(lb,ub,n,fb,fc)
// Parameters
//	lb: Real or complex valued vector or matrix
//	ub: Real or complex valued vector or matrix
//	n: Real valued integer strictly positive
//	fb: Real or complex valued vector or matrix, strictly positive value for scalar input
//	fc: Real or complex valued vector or matrix, strictly positive value for scalar input
// Description
//	This is an Octave function
//	This function implements the complex Shannon wavelet function and returns the value obtained. The complex Shannon wavelet is defined by a bandwidth parameter FB, a wavelet center frequency FC on an N point regular grid in the interval [LB,UB].
// Examples
// 1.	[a,b]=shanwavf (2,8,3,1,6)
//	a =   [-3.8982e-17 + 1.1457e-31i   3.8982e-17 - 8.4040e-31i  -3.8982e-17 + 4.5829e-31i]
//	b =   [2   5   8]
// 2.	[a,b]=shanwavf(1,2,1,[2,2;i,2],[-1,2;-i,i])
//	a =   [-5.5128e-17 - 2.7005e-32i  -5.5128e-17 + 5.4010e-32i;
//	       8.6404e+06 + 8.6404e+06i  -1.9225e-22 - 0.0000e+00i]
//	b =  2

funcprot(0);
rhs=argn(2);
if (rhs~=5) then
	error ("Wrong number of input arguments.")
else [psi,x]=callOctave("shanwavf",lb,ub,n,fb,fc)
end
endfunction
