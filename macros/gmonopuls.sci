function [y]=gmonopuls(t,fc)

// Gaussian monopulse
// Caling Sequence
//	[y]=gmonopuls(t)
//	[y]=gmonopuls(t,fc)
// Parameters
//	t: Real or complex valued vector or matrix
//	fc: Real non-negative value or complex value or a vector or matrix with not all real values negative.
// Description
//	This is an Octave function
//	This function returns samples of the Gaussian monopulse of amplitude unity.
// Examples
// 1.	gmonopuls([1 2 3],0.1)
//	ans= 0.85036   0.94070   0.52591
// 2.	gmonopuls([1 2 3])
//	ans= 0 0 0

funcprot(0);
rhs=argn(2);
if ( rhs<1 ) then
	error ("Wrong number of input arguments.")
elseif (rhs==1)
	y=callOctave("gmonopuls",t)
else y=callOctave("gmonopuls",t,fc)
end
endfunction
