function y = upsamplefill (x, w, cpy)
//This function upsamples a vector interleaving given values or copies of the vector elements.
//Calling Sequence
//y = upsamplefill (x, w)
//y = upsamplefill (x, w, cpy)
//Parameters 
//x: scalar, vector or matrix of real or complex numbers 
//w: scalar or vector of real or complex values
//cpy: can take in "true" or "false", default is false
//Description
//This is an Octave function.
//This function upsamples a vector interleaving given values or copies of the vector elements.
//The second argument has the values in the vector w that are placed in between the elements of x.
//The third argument, if true, means that w should be scalar and that each value in x repeated w times.
//Examples
//upsamplefill([0.4,0.5],7)
//ans  =
//    0.4    7.    0.5    7. 
funcprot(0);
rhs = argn(2)

if(rhs<2 | rhs>3)
error("Wrong number of input arguments.")
end

	select(rhs)
	case 2 then
	y = callOctave("upsamplefill", x, w)
	case 3 then
	y = callOctave("upsamplefill", x, w, cpy)
	end
endfunction
