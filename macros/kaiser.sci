function w = kaiser (m, beta)
//This function returns the filter coefficients of a Kaiser window.
//Calling Sequence
//w = kaiser (m)
//w = kaiser (m, beta)
//Parameters 
//m: positive integer value
//beta: real scalar value
//w: output variable, vector of real numbers 
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Kaiser window of length m supplied as input, to the output vector w.
//The second parameter gives the stop band attenuation of the Fourier transform of the window on derivation.
//Examples
//kaiser(6,0.2)
//ans  =
//    0.9900745  
//    0.9964211  
//    0.9996020  
//    0.9996020  
//    0.9964211  
//    0.9900745 
funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end
if(rhs==1)
w = callOctave("kaiser", m)
elseif(rhs==2)
w = callOctave("kaiser", m, beta)
end
endfunction 
