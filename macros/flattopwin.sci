function w = flattopwin (m, opt)
//This function returns the filter coefficients of a Flat Top window.
//Calling Sequence
//w = flattopwin (m)
//w = flattopwin (m, opt)
//Parameters 
//m: positive integer value
//opt: string value, takes in "periodic" or "symmetric"
//w: output variable, vector of real numbers 
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Flat Top window of length m supplied as input, to the output vector w.
//The second parameter can take the values "periodic" or "symmetric", depending on which the corresponding form of window is returned. The default is symmetric.
//This window has low pass-band ripple but a high bandwidth. 
//Examples
//flattopwin(8,"periodic")
//ans  =
//    0.0009051  
//  - 0.0264124  
//  - 0.0555580  
//    0.4435496  
//    1.         
//    0.4435496  
//  - 0.0555580  
//  - 0.0264124  
funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end

if(rhs==2)
	if(opt~="periodic" & opt~="symmetric")
	error("Window type should be periodic or symmetric.")
	end
end

	select(rhs)
	case 1 then
	w = callOctave("flattopwin",m)
	case 2 then
	w = callOctave("flattopwin",m,opt)
	end
endfunction



