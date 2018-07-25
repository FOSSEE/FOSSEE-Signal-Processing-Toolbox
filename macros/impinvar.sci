function [b_out, a_out] = impinvar (b, a, fs, tol)
//This function converts analog filter with coefficients b and a to digital, conserving impulse response.
//Calling Sequence
//[b, a] = impinvar (b, a)
//[b, a] = impinvar (b, a, fs)
//[b, a] = impinvar (b, a, fs, tol)
//Parameters 
//b: real or complex valued scalar or vector
//a: real or complex valued scalar or vector, order should be greater than b
//fs: real or complex value, default value 1Hz
//tol: real or complex value, default value 0.0001 
//Description
//This is an Octave function.
//This function converts analog filter with coefficients b and a to digital, conserving impulse response.
//This function does the inverse of impinvar.
//Examples
//b =  0.0081000
//a = [2.0000000,   0.56435378,   0.4572792,   0.00705544,   0.091000]
//[ay,by] = impinvar(b,a,10)
//ay =
//   0.0000e+00   7.5293e-08   2.9902e-07   7.4238e-08
//by =
//   1.00000  -3.96992   5.91203  -3.91428   0.97218

funcprot(0);
rhs = argn(2)
if(rhs<2)
error("Wrong number of input arguments.")
end


	select(rhs)
	case 2 then
//	[b, a] = callOctave("impinvar",b,a)
	[b_out, a_out] = callOctave("impinvar",b,a)
	case 3 then
//	[b, a] = callOctave("impinvar",b,a,fs)
	[b_out, a_out] = callOctave("impinvar",b,a,fs)
	case 4 then
//	[b, a] = callOctave("impinvar",b,a,fs,tol)
	[b_out, a_out] = callOctave("impinvar",b,a,fs,tol)
	end
endfunction
