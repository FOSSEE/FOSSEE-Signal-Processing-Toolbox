function w = nuttallwin (m, opt)
//This function returns the filter coefficients of a Blackman-Harris window.
//Calling Sequence
//w = nuttallwin (m)
//w = nuttallwin (m, opt)
//Parameters 
//m: positive integer value
//opt: string value, takes in "periodic" or "symmetric"
//w: output variable, vector of real numbers 
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Blackman-Harris window defined by Nuttall of length m supplied as input, to the output vector w.
//The second parameter can take the values "periodic" or "symmetric", depending on which the corresponding form of window is returned. The default is symmetric.
//Examples
//nuttallwin(2, "periodic")
//ans  =
//  - 2.429D-17  
//    1.    



rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end

	select(rhs)
	case 1 then
	w = callOctave("nuttallwin",m)
	case 2 then
	w = callOctave("nuttallwin",m,opt)
	end
endfunction

