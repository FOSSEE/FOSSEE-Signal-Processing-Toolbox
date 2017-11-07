function w = chebwin (m, at)
//This function returns the filter coefficients of a Dolph-Chebyshev window.
//Calling Sequence
//w = chebwin (m)
//w = chebwin (m, at)
//Parameters 
//m: positive integer value
//at: real scalar value 
//w: output variable, vector of real numbers 
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Dolph-Chebyshev window of length m supplied as input, to the output vector w. 
//The second parameter is the stop band attenuation of the Fourier transform in dB. The default value is 100 dB.  
//Examples
//chebwin(7)
//ans  =
//    0.0565041  
//    0.3166085  
//    0.7601208  
//    1.         
//    0.7601208  
//    0.3166085  
//    0.0565041 

rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end
select(rhs)
case 1 then
w = callOctave("chebwin",m)
case 2 then
w = callOctave("chebwin",m,at)
end
endfunction


