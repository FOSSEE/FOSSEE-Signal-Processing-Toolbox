function [y,i]=bitrevorder(x)

// Returns input data in bit-reversed order 
// Calling Sequence
//	[y,i]=bitrevorder(x)
// Parameters
//	x: Vector of real or complex values
// Description
//	This is an Octave function. 
//	This function returns the input data after reversing the bits of the indices and reordering the elements of the input array.
// Examples
// 1.	[y]=bitrevorder ([i,1,3,6i])
//	y =   [0 + 1i   3 + 0i   1 + 0i   0 + 6i]
// 2.	[y,i]=bitrevorder (['a','b','c','d'])
//	y = acbd
//	i =   [1   3   2   4]

funcprot(0);
[lhs,rhs]=argn(0);
if (rhs<1) then
	error ("Wrong number of input arguments.")
end
[y,i]=callOctave("bitrevorder",x)

endfunction
