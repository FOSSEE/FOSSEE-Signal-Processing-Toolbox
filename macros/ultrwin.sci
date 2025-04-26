function [w, xmu] = ultrwin (m, mu, par, key, norm)
//This function returns the coefficients of an Ultraspherical window.
//Calling Sequence
//w = ultrwin (m, mu, par)
//w = ultrwin (m, mu, par, key)
//w = ultrwin (m, mu, par, key, norm)
//[w, xmu] = ultrwin (...)
//Parameters 
//m: positive integer value
//mu:
//par:
//key:
//norm:
//Description
//This is an Octave function.
//This function returns the coefficients of an Ultraspherical window of length m supplied as input, to the output vector w. 
//The second parameter controls the ratio between side lobe to side lobe of the window's Fourier transform. 
//The third parameter controls the ratio between main lobe width to side lobe. The default value is beta.
//The value of xmu is also returned for given beta, att or latt.
//Examples
//ultrwin(3,-0.4,0.5)
//ans  =
//  - 1.  
//    1.  
//  - 1.  

rhs = argn(2)
lhs = argn(1)
if(rhs<3 | rhs>5)
error("Wrong number of input arguments.")
end

	select(rhs)
	case 3 then
	if(lhs==1)
	[w] = callOctave("ultrwin", m, mu, par)
	elseif(lhs==2)
	[w,xmu] = callOctave("ultrwin", m, mu, par)
	end
	case 4 then
	if(lhs==1)
	[w] = callOctave("ultrwin", m, mu, par, key)
	elseif(lhs==2)
	[w,xmu] = callOctave("ultrwin", m, mu, par, key)
	end
	case 5 then
	if(lhs==1)
	[w] = callOctave("ultrwin", m, mu, par, key, norm)
	elseif(lhs==2)
	[w,xmu] = callOctave("ultrwin", m, mu, par, key, norm)
	end
	end
endfunction
