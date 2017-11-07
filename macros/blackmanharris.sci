function w = blackmanharris (m, opt)
//This function returns the filter coefficients of a Blackman-Harris window.
//Calling Sequence
//w = blackmanharris (m)
//w = blackmanharris (m, opt)
//Parameters 
//m: positive integer value
//opt: string value, takes "periodic" or "symmetric"
//w: output variable, vector of real numbers 
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Blackman-Harris window of length m supplied as input, to the output vector w. 
//The second parameter can take the values "periodic" or "symmetric", depending on which the corresponding form of window is returned. The default is symmetric. 
//Examples
//blackmanharris(5,"periodic")
//ans  =
//    0.00006    
//    0.1030115  
//    0.7938335  
//    0.7938335  
//    0.1030115  
 
rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end

	select(rhs)
	case 1 then
	w = callOctave("blackmanharris",m)
	case 2 then
	w = callOctave("blackmanharris",m,opt)
	end
endfunction

