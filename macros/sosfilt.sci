function [y]=sosfilt(sos,x)

// Second order section IIR filtering of x. 
// Calling Sequence
//	[y]=sosfilt(sos,x)
// Parameters
//	sos: Real or complex valued Lx6 vector or matrix
//	x: Real or complex valued vector or matrix
// Description
//	This is an Octave function
//	Second order section digital filter sos is applied to the input vector and the output vector obtained is of the same length.
// Examples
// 1.	sosfilt([1 2 3 4 5 6],[-1 10i;1 2])
//	ans =[ -0.25000   0.00000;  0.06250   0.50000]
// 2.	sosfilt([32 28 84 47 2 29],-1)
//	ans = -0.68085

funcprot(0);
y=callOctave("sosfilt",sos,x)
endfunction
