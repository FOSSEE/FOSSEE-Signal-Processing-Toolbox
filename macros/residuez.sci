function [r,p,f,m]=residuez(b,a)

// Compute the partial fraction expansion(PFE) of filter H(z) = B(z)/A(z).
// Calling Sequence
//	[r,p,f,m]=residuez(b,a)
// Parameters
//	b: Real or complex valued vector or matrix
//	a: Real or complex valued vector or matrix
// Description
//	This is an Octave function
//	It compute the PFE of filter H(z)= B(z)/A(z) where inputs b and a are vectors specifying the digital filter.
// Examples
// 1.	[a,b,c,d]=residuez([i 2i 3i; -4 1 4i],[1 2 3])
//	a =  [0.6262 - 1.4412i;  -0.4039 + 1.4658i]
//	b =  [-1.0000 - 1.4142i;  -1.0000 + 1.4142i]
//	c =  [-0.22222 - 0.97531i   0.33333 + 0.51852i   0.00000 - 0.11111i;   0.00000 - 1.33333i]
//	d =   1

funcprot(0);
rhs=argn(2);
if (rhs<2) then
	error ("Wrong number of input arguments.")
else	[r,p,f,m]=callOctave("residuez",b,a)
end
endfunction
