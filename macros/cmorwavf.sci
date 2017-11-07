function [psi,x]=cmorwavf(lb,ub,n,fb,fc)
funcprot(0);

// Finds the Complex Morlet Wavelet
// Calling Sequence
//	[psi,x]=cmorwavf(lb,ub,n,fb,fc)
// Parameters
//	lb: Real or complex valued vector or matrix
//	ub: Real or complex valued vector or matrix
//	n: Real scalar strictly positive integer
//	fb: Real or complex scalar value
//	fc: Real or complex scalar value
// Description
//	This is an Octave function.
//	This function returns the value of the Complex Morlet Waveform defined by a positive bandwidth parameter FB, a wavelet center frequency FC on an N point regular grid for the interval [LB,UB].
// Examples
//	[a,b]=cmorwavf(1,2,1,3,4)
//	b=2
//	a=[0.0858628 -1.682D-16i]

rhs=argn(2);
if(rhs~=5) then
	error ("Wrong number of input arguments.")
end
[psi,x]=callOctave("cmorwavf",lb,ub,n,fb,fc)
endfunction
