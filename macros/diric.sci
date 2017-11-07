function [y]= diric(x,n)

// Calculates the dirichlet function
// Calling Sequence
//	[y]=diric(x,n)
// Parameters
//	x: Real valued vector or matrix
//	n: Real positive integer or complex integer
// Description
//	This is an Octave function
//	y=diric(x,n) returns the dirichlet function values of parameter x.
// Examples
// 1. 	diric([1 2 3],3)
//	ans= 0.6935349    0.0559021  -0.3266617
// 2.	diric(1,2)
//	ans= 0.8775826

funcprot(0);
rhs=argn(2);
if (rhs~=2) then
	error ("Wrong number of input arguments.")
else y= callOctave("diric",x,n)
end
endfunction
