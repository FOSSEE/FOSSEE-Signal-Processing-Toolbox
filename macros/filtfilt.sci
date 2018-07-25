function [y]=filtfilt(b,a,x)

// Zero phase digital filtering
// Calling Sequence
//	[y]=filtfilt(b,a,x)
// Parameters
//	b: Real or complex valued vector or matrix
//	a: Real or complex valued vector or matrix
//	x: Real or complex valued vector or matrix
// Description
//	This is an Octave function
//	In theory, it forwards and reverse filters the signal and corrects phase distortion upto an extent by a one-pass filter but squares the magnitude response in the process. Practically though, the correction isn't perfect and magnitude response, particularly the stop band is distorted.
// Examples
// 1.	y=filtfilt (1,2*%i,[%i -4 0])        // Number of Output argument should be equal to 1
//	y =   [-0.25i   1   0]

funcprot(0);
rhs=argn(2);
if (rhs~=3) then
	error ("Wrong number of input arguments.")
else y=callOctave("filtfilt",b,a,x)
end
endfunction
