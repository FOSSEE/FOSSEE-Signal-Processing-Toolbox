function [y] = wkeep(x,l,opt)

// Extracts a vector from the given vector of length l
// Calling Sequence
//	[y]=wkeep(x,l)
//	[y]=wkeep(x,l,opt)
// Parameters
//	x: Real, complex or string type input vector or matrix
//	l: Length of matrix required
//	opt: Character input to determine which side to extract from
// Description
//	This is an Octave function
//	[y]=wkeep(x,l) extracts a vector of length l from the centre of input vector x.
//	[y]=wkeep(x,l,opt) extracts vector based on opt which could be 'l','r' or 'c' (left, right or central).
// Examples
// 1.	[y]=wkeep([1 2 3;4 5 6],[2 2])
//	y=  1   2
// 2.	[y]=wkeep([1 2 3 4 5 6],3,'r')
//	y=  4   5   6

funcprot(0);
rhs=argn(2);
if (rhs<2) then
	error ("Wrong number of input arguments.")
elseif (rhs==2)
	y=callOctave("wkeep",x,l)
else	y=callOctave("wkeep",x,l,opt)	
end
endfunction
