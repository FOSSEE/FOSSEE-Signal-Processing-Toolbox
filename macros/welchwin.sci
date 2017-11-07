function w = welchwin (m, opt)
//This function returns the filter coefficients of a Welch window.
//Calling Sequence
//w = welchwin (m)
//w = welchwin (m, opt)
//Parameters 
//m: positive integer value
//opt: string value, takes "periodic" or "symmetric"
//w: output variable, vector of real numbers 
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Welch window of length m supplied as input, to the output vector w.
//The second parameter can take the values "periodic" or "symmetric", depending on which the corresponding form of window is returned. The default is symmetric.
//For symmetric, the length should be an integer>2. For periodic, the length should be an integer>1.
//Examples
//welchwin(4,"symmetric")
//ans  =
//    0.         
//    0.8888889  
//    0.8888889  
//    0.         
 


rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end

	select(rhs)
	case 1 then
	w = callOctave("welchwin",m)
	case 2 then
	w = callOctave("welchwin",m,opt)
	end

endfunction
