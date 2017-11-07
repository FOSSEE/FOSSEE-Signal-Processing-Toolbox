function w = tukeywin (m, r)
//This function returns the filter coefficients of a Tukey window.
//Calling Sequence
//w = tukeywin (m)
//w = tukeywin (m, r)
//Parameters
//m: positive integer
//r: positive real number, between 0 and 1
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Tukey window of length m supplied as input, to the output vector w. 
//The second parameter r defines the ratio between the constant and cosine section and its value has to be between 0 and 1, with default value 0.5.
//Examples
//tukeywin(5, 2)
//ans  =
//    0.   
//    0.5  
//    1.   
//    0.5  
//    0.  

funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end
	select(rhs)
	case 1 then
	w = callOctave("tukeywin",m)
	case 2 then
	w = callOctave("tukeywin",m,r)
	end
endfunction

