function [y] = parzenwin (m)
//This function returns the filter coefficients of a Parzen window.
//Calling Sequence
//y = parzenwin (m)
//Parameters 
//m: positive integer value
//y: output variable, vector of real numbers 
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Parzen window of length m supplied as input, to the output vector y. 
//Examples
//parzenwin(3)
//ans  =
//    0.0740741  
//    1.         
//    0.0740741

rhs = argn(2)

if(rhs~=1)
error("Wrong number of input arguments.")
end

y = callOctave("parzenwin",m)

endfunction
