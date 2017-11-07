function [y]=meyeraux(x)

// Returns value of Meyer Wavelet Auxiliary function
// Calling Sequence
//	[y]=meyeraux(x)
// Parameters
//	x: Real or complex valued vector or matrix
// Description
//	This is an Octave function.
//	This function returns values of the auxiliary function used for Meyer wavelet generation.
// Examples
// 1.	meyeraux([1 2 3])
//	ans= [1    -208  -10287]
// 2.	meyeraux([1 2 3;4 5 6])
//	ans=  [1      -208    -10287  ;	 -118016   -709375  -2940624 ]

funcprot(0);
rhs=argn(2);
if (rhs~=1) then
	error ("Wrong number of input arguments.")
else y=callOctave("meyeraux",x)
end
endfunction
