function [B,A] = sos2tf(sos, g)
//This function converts series second-order sections to direct H(z) = B(z)/A(z) form.
//Calling Sequence
//[B] = sos2tf(sos)
//[B] = sos2tf(sos, g)
//[B,A] = sos2tf(...)
//Parameters 
//sos: matrix of real or complex numbers
//g: real or complex value, default value is 1
//Description
//This is an Octave function.
//This function converts series second-order sections to direct H(z) = B(z)/A(z) form.
//The input is the sos matrix and the second parameter is the overall gain, default value of which is 1. 
//The output is a vector.
//Examples
//sos = [1  1  1  1  0 -1; -2  3  1  1 10  1];
////[b,a] = sos2tf(sos)
//a =
//  -2   1  2  4  1
//b =
//   1 10  0 -10 -1
funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end



	select(rhs)
	case 1 then
	[B,A] = callOctave("sos2tf",sos)
	case 2 then
	[B,A] = callOctave("sos2tf",sos,g)
	end
endfunction
