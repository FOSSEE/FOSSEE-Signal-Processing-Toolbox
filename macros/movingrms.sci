function [rmsx,w]=movingrms(x,w,rc,Fs)

// Find moving RMS value of signal in x
// Calling Sequence
//	[rmsx,w]=movingrms(x,w,rc,Fs=1)
// Parameters
//	x: Real or complex valued vector or matrix
//	w: Real or complex scalar value
//	rc: Real or complex scalar value
//	Fs: Real or complex scalar value
// Description
//	This is an Octave function.
//	The signal is convoluted against a sigmoid window of width w and risetime rc with the units of these parameters relative to the value of the sampling frequency given in Fs (Default value=1).
// Examples
// 1.	[a,b]=movingrms ([4.4 94 1;-2 5i 5],1,-2)
//	a =    0.91237   17.71929    0.96254
//	       0.91237   17.71929    0.96254
//	b =   0.18877
//	      0.18877
// 2.	[a,b]=movingrms ([4.4 94 1;-2 5i 5],1,-2,2)
//	a =   4.8332   93.8669    5.0990
//	      4.8332   93.8669    5.0990
//	b =   1
//	      1

funcprot(0);
rhs=argn(2);
if (rhs<3) then
	error("Wrong number of input arguments.")
elseif (rhs==3) then Fs=1;
end
[rmsx,w]=callOctave("movingrms",x,w,rc,Fs)
endfunction
