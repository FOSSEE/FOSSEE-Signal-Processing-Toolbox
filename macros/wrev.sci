function [y]= wrev(x)

// Reverses order of elements of input vector
// Calling Sequence
//	[y]=wrev(x)
// Parameters
//	x: Input vector of string, real or complex values
// Description
//	This is an Octave function.
//	This function reverses the order of elements of the input vector x.
// Examples
// 1.	wrev([1 2 3])
//	ans= 3  2  1
// 2.	wrev(['a','b','c'])
//	ans= cba

funcprot(0);
rhs=argn(2);
if (rhs~=1) then
	error("Wrong number of input arguments.")
else	y=callOctave("wrev",x)
end
endfunction
