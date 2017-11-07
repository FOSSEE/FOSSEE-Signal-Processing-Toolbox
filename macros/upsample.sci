function y = upsample (x, n, phase)
//This function upsamples the signal, inserting n-1 zeros between every element.
//Calling Sequence
//y = upsample (x, n)
//y = upsample (x, n, phase)
//Parameters 
//x: scalar, vector or matrix of real or complex numbers
//n: real number or vector
//phase: integer value, 0 <= phase <= (n - 1 ), default value 0, or logical
//Description
//This is an Octave function.
//This function upsamples the signal, inserting n-1 zeros between every element. If x is a matrix, every column is upsampled.
//The phase determines the position of the inserted sample in the block of zeros. The default value is 0.
//Examples
//upsample(4,5,2)
//ans  =
//    0.    0.    4.    0.    0.

funcprot(0);
rhs = argn(2)
if(rhs<2 | rhs>3)
error("Wrong number of input arguments.")
end  

	select(rhs)
	case 2 then
	y = callOctave("upsample",x,n)
	case 3 then
	y = callOctave("upsample",x,n,phase)
	end

endfunction

