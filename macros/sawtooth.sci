function [y]=sawtooth (t,width)

// Generates a Sawtooth wave
// Calling Sequence
//	[y]=sawtooth(t)
//	[y]=sawtooth(t,width)
// Parameters
//	t: Real valued vector or matrix
//	width: Real number between 0 and 1
// Description
//	This is an Octave function
//	This function returns a sawtooth wave with period 2*pi with +1/-1 as the maximum and minimum values for elements of t. If width is specified, it determines where the maximum is in the interval [0,2*pi].
// Examples
// 1.	sawtooth([1 2 3 4 5],0.5)
//	ans =  [-0.36338   0.27324   0.90986   0.45352  -0.18310]
// 2.	sawtooth([1 2; 4 5])
//	ans =  [-0.68169  -0.36338;   0.27324   0.59155]

funcprot(0);
rhs=argn(2);
if (rhs<1) then
	error ("Wrong number of input arguments.")
elseif (rhs==1)
	y=callOctave("sawtooth",t)
else	y=callOctave("sawtooth",t,width)
end
endfunction
