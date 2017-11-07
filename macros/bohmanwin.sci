function y = bohmanwin (m)
//This function returns the filter coefficients of a Bohman window. 
//Calling Sequence
//y = bohmanwin (m)
//Parameters 
//m: positive integer value
//y: output variable, vector of real numbers 
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Bohman window of length m supplied as input, to the output vector y.
//Examples
//bohmanwin(4)
//ans  =
//    0.         
//    0.6089978  
//    0.6089978  
//    0.      

rhs = argn(2)

if(rhs~=1)
error("Wrong number of input arguments.")
end

y = callOctave("bohmanwin",m)

endfunction 
