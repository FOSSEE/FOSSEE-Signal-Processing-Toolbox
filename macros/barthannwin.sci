function y = barthannwin(m)
//This function returns the filter coefficients of a modified Bartlett-Hann window.
//Calling Sequence
//y = barthannwin(m)
//Parameters 
//m: positive integer value
//y: output variable, vector of real numbers
//Description
//This is an Octave function.
//This function returns the filter coefficients of a modified Bartlett Hann window of length m supplied as input, to the output vector y.
//Examples
//barthannwin(4)
//ans  =
//    0.    
//    0.73  
//    0.73  
//    0.    

funcprot(0);
rhs = argn(2)
if(rhs~=1)
error("Wrong number of input arguments.")
end

y = callOctave("barthannwin",m)

endfunction

