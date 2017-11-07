function [y] =  triang (m)
//This function returns the filter coefficients of a triangular window.
//Calling Sequence
//y =  triang (m)
//Parameters 
//m: positive integer value
//y: output variable, vector of real numbers
//Description
//This is an Octave function.
//This function returns the filter coefficients of a triangular window of length m supplied as input, to the output vector y. 
//Examples
//triang(5)
//ans  =
//    0.3333333  
//    0.6666667  
//    1.         
//    0.6666667  
//    0.3333333 

funcprot(0);
rhs = argn(2)
if(rhs~=1)
error("Wrong number of input arguments.")
end

y = callOctave("triang",m)

endfunction
