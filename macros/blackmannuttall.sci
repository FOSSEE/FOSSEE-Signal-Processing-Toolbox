function [w] = blackmannuttall (m, opt)
//This function returns the filter coefficients of a Blackman-Nuttall window.
//Calling Sequence
//w = blackmannuttall (m)
//w = blackmannuttall (m, opt)
//Parameters 
//m: positive integer value
//opt: string value, takes "periodic" or "symmetric"
//w: output variable, vector of real numbers
//Description. 
//This is an Octave function.
//This function returns the filter coefficients of a Blackman-Nuttall window of length m supplied as input, to the output vector w. 
//The second parameter can take the values "periodic" or "symmetric", depending on which the corresponding form of window is returned. The default is symmetric. 
//Examples
//blackmannuttall(5,"symmetric")
//ans  =
//    0.0003628  
//    0.2269824  
//    1.         
//    0.2269824  
//    0.0003628 
rhs = argn(2)

if (rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end
	select (rhs)
	case 1 then
	w = callOctave("blackmannuttall",m)
	case 2 then
	w = callOctave("blackmannuttall",m,opt)
	end
endfunction

