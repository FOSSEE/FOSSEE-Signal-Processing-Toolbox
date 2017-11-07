function [y] = rectwin (m)
//This function returns the filter coefficients of a rectangular window.
//Calling Sequence
//y = rectwin (m)
//Parameters 
//m: positive integer value
//y: output variable, vector of real numbers
//Description
//This is an Octave function.
//This function returns the filter coefficients of a rectangular window of length m supplied as input, to the output vector y. 
//Examples
//rectwin(3)
//ans  =
//    1.  
//    1.  
//    1.  
rhs = argn(2)

if(rhs~=1)
error("Wrong number of input arguments.")
end 

y = callOctave("rectwin",m)

endfunction
