function [sos,g] = zp2sos(z,p,k)
//This function converts filter poles and zeros to second-order sections.
//Calling Sequence
//[sos] = zp2sos(z)
//[sos] = zp2sos(z, p)
//[sos] = zp2sos(z, p, k)
//[sos, g] = zp2sos(...)
//Parameters 
//z: column vector
//p: column vector
//k: real or complex value, default value is 1
//Description
//This is an Octave function.
//This function converts filter poles and zeros to second-order sections.
//The first and second parameters are column vectors containing zeros and poles. The third parameter is the overall filter gain, the default value of which is 1.
//The output is the sos matrix and the overall gain.
//If there is only one output argument, the overall filter gain is applied to the first second-order section in the sos matrix.
//Examples
//zp2sos([1, 2, 3], 2, 6)
//ans =
//    6  -18   12    1   -2    0
//    1   -3    0    1    0    0


funcprot(0);
rhs = argn(2)
lhs = argn(1)
if(rhs<1 | rhs>3)
error("Wrong number of input arguments.")
end
	select(rhs)
	case 1 then
	if (lhs<2) 
	sos=callOctave("zp2sos",z)
	else
	[sos,g]=callOctave("zp2sos",z)
	end
	case 2 then
	if(lhs<2)
	[sos]=callOctave("zp2sos",z,p)
	else
	[sos,g]=callOctave("zp2sos",z,p)
	end
	case 3 then
	if(lhs<2)
	sos=callOctave("zp2sos",z,p,k)
	else
	[sos,g]=callOctave("zp2sos",z,p,k)
	end
	end
endfunction
