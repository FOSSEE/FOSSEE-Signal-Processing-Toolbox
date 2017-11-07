function [sos,varargout] = tf2sos (b, a)
//This function converts direct-form filter coefficients to series second-order sections.
//Calling Sequence
//[sos] = tf2sos (b, a)
//[sos, g] = tf2sos (b, a)
//Parameters 
//b: matrix of real numbers
//a: matrix of real numbers 
//Description
//This is an Octave function.
//This function converts direct-form filter coefficients to series second-order sections.
//The input parameters b and a are vectors specifying the digital filter H(z) = B(z)/A(z). 
//The output is the sos matrix and the overall gain.
//If there is only one output argument, the overall filter gain is applied to the first second-order section in the sos matrix.
//Examples
//tf2sos([1,2,3,4,5,6],2)
//ans =
//   0.50000   0.80579   1.07239   1.00000   0.00000   0.00000
//   1.00000  -1.10337   1.87524   1.00000   0.00000   0.00000
//   1.00000   1.49180  -0.00000   1.00000   0.00000   0.00000

funcprot(0);
rhs = argn(2)
lhs = argn(1)

if(rhs~=2)
error("Wrong number of input arguments.")
end
	select(lhs)
	case 1 then
	sos = callOctave("tf2sos",b,a)
	case 2 then
	[sos,g] = callOctave("tf2sos",b,a)
	end
endfunction 
