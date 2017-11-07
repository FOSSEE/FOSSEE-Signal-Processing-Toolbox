function y = downsample (x, n, phase)
//This function downsamples the signal by selecting every nth element.
//Calling Sequence
//y = downsample (x, n)
//y = downsample (x, n, phase)
//Parameters 
//x: scalar, vector or matrix of real or complex numbers
//n: real number or vector
//phase: integer value, 0 <= phase <= (n - 1), default value 0, or logical
//Description
//This is an Octave function.
//This function downsamples the signal by selecting every nth element supplied as parameter 2. If x is a matrix, the function downsamples every column.
//If the phase is specified, every nth element is selected starting from the sample phase. The default phase is 0.
//Examples
//downsample([1,2,4],2)
//ans  =
//    1.    4.  

funcprot(0);
rhs = argn(2)
if(rhs<2 | rhs>3)
error("Wrong number of input arguments.")
end
  
	select(rhs)
	case 2 then
	y = callOctave("downsample",x,n)
	case 3 then
	y = callOctave("downsample",x,n,phase)
	end
endfunction
