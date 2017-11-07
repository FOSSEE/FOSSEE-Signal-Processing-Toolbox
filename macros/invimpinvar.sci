function [b_out, a_out] = invimpinvar (b, a, fs, tol)
//This function converts digital filter with coefficients b and a to analog, conserving impulse response.
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
//This function converts digital filter with coefficients b and a to analog, conserving impulse response.
//This function does the inverse of impinvar. 
//Examples
//b =  0.0081000
//a = [2.0000000,   0.56435378,   0.4572792,   0.00705544,   0.091000]
//[ay, by] = invimpinvar(b,a,10)
//ay =
//  -1.6940e-16   4.6223e+00  -4.5210e+00   7.2880e+02
//by =
// Columns 1 through 4:
//   1.0000e+00   3.0900e+01   9.6532e+02   1.2232e+04
// Column 5:
//   1.1038e+05
funcprot(0);
rhs = argn(2)
if(rhs<2)
error("Wrong number of input arguments.")
end


	select(rhs)
	case 2 then
	[b_out,a_out] = callOctave("invimpinvar",b,a)
	case 3 then
	[b_out,a_out] = callOctave("invimpinvar",b,a,fs)
	case 4 then
	[b_out,a_out] = callOctave("invimpinvar",b,a,fs,tol)
	end
endfunction
