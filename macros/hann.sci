function w = hann (varargin)
//This function returns the filter coefficients of a Hanning window.
//Calling Sequence
//w = hann(m)
//w = hann(m, "symmteric")
//w = hann(m, "periodic")
//Parameters 
//m: positive integer value
//opt: string value, takes in "periodic" or "symmetric"
//w: output variable, vector of real numbers 
//Description
//This is an Octave function.
//This function returns the filter coefficients of a Hanning window of length m supplied as input, to the output vector w.
//The second parameter can take the values "periodic" or "symmetric", depending on which the corresponding form of window is returned. The default is symmetric.
//Examples
//hann(6,"symmetric")
//ans  =
//    0.         
//    0.3454915  
//    0.9045085  
//    0.9045085  
//    0.3454915  
//    0.  
funcprot(0);
rhs = argn(2)
m = varargin(1)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end

w = hanning (varargin(:));

endfunction
