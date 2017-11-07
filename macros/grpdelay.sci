function [gd,w] = grpdelay(b,a,nfft,whole,Fs)
//This function computes the group delay of a filter.
//Calling Sequence
//gd = grpdelay(b)
//gd = grpdelay(b, a)
//gd = grpdelay(b, a, nfft)
//gd = grpdelay(b, a, nfft, whole)
//gd = grpdelay(b, a, nfft, whole, Fs)
//[gd, w] = grpdelay(...)

//Parameters 
//b:
//a:
//nfft:

//Description
//This is an Octave function.
//This function computes the group delay of a filter.
//[g, w] = grpdelay(b) returns the group delay g of the FIR filter with coefficients b. The response is evaluated at 512 angular frequencies between 0 and pi. w is a vector containing the 512 frequencies. 
//[g, w] = grpdelay(b, a) returns the group delay of the rational IIR filter whose numerator has coefficients b and denominator coefficients a.
//[g, w] = grpdelay(b, a, n) returns the group delay evaluated at n angular frequencies. 
//[g, w] = grpdelay(b, a, n, ’whole’) evaluates the group delay at n frequencies between 0 and 2*pi.
//[g, f] = grpdelay(b, a, n, Fs) evaluates the group delay at n frequencies between 0 and Fs/2.
//[g, f] = grpdelay(b, a, n, ’whole’, Fs) evaluates the group delay at n frequencies between 0 and Fs.
//[g, w] = grpdelay(b, a, w) evaluates the group delay at frequencies w (radians per sample).
//[g, f] = grpdelay(b, a, f, Fs) evaluates the group delay at frequencies f (in Hz).
//Examples
//grpdelay(1,2,3)
//ans =
//   0.
//   0.
//   0.

funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>5)
error("Wrong number of input arguments.")
end
	select(rhs)
	case 1 then
	[gd,w] = callOctave("grpdelay",b)
	case 2 then
	[gd,w] = callOctave("grpdelay",b,a)
	case 3 then
	[gd,w] = callOctave("grpdelay",b,a,nfft)
	case 4 then
	[gd,w] = callOctave("grpdelay",b,a,nfft,whole)
	case 5 then
	[gd,w] = callOctave("grpdelay",b,a,nfft,whole,Fs)
	end
endfunction
