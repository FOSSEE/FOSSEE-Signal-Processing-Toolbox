function [z,p,k] = sos2zp (sos, g)
//This function converts series second-order sections to zeros, poles, and gains (pole residues).
//Calling Sequence
//z = sos2zp (sos)
//z = sos2zp (sos, g)
//[z, p] = sos2zp (...)
//[z, p, k] = sos2zp (...)
//Parameters 
//sos: matrix of real or complex numbers
//g: real or complex value, default value is 1
//z: column vector
//p: column vector
//Description
//This is an Octave function. 
//This function converts series second-order sections to zeros, poles, and gains (pole residues).
//The input is the sos matrix and the second parameter is the overall gain, default value of which is 1.
//The outputs are z, p, k. z and p are column vectors containing zeros and poles respectively, and k is the overall gain. 
//Examples
//[a,b,c]=sos2zp([1,2,3,4,5,6])
//a =
//  -1.0000 + 1.4142i
//  -1.0000 - 1.4142i
//b =
//  -0.6250 + 1.0533i
//  -0.6250 - 1.0533i
//c =  1

funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end

	select(rhs)
	case 1 then
	[z,p,k] = callOctave("sos2zp",sos)
	case 2 then
	[z,p,k] = callOctave("sos2zp",sos,g)
	end
endfunction

