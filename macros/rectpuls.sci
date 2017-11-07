function [y]=rectpuls(t,w)

// Generates a Rectangular pulse based on the width and sampling times.
// Calling Sequence
//	[y]=rectpuls(t)
//	[y]=rectpuls(t,w)
// Parameters
//	t: Real or complex valued vector or matrix
//	w: Real or complex valued vector or matrix
// Description
//	This is an Octave function
//	y = rectpuls(t) returns a continuous, aperiodic, unity-height rectangular pulse depending upon input t, centered about t=0 and having default width of 1.
//	y = rectpuls(t,w) generates a rectangle of width w.
// Examples
// 1.	rectpuls([10 100 1000 13 839],27)
//	ans =   1   0   0   1   0
// 2.	rectpuls([1000 1000 100 100])
//	ans =   0   0   0   0

funcprot(0);
rhs=argn(2);
if (rhs<1) then
	error ("Wrong number of input arguments.")
elseif (rhs==1)
	y=callOctave("rectpuls",t)
else y=callOctave("rectpuls",t,w)
end
endfunction
