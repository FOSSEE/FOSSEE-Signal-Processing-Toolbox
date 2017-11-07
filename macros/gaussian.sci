function w = gaussian (m, a)
//This function returns a Gaussian convolution window.
//Calling Sequence
//w = gaussian (m)
//w = gaussian (m, a)
//Parameters 
//m: positive integer value
//a: 
//w: output variable, vector of real numbers
//Description
//This is an Octave function.
//This function returns a Gaussian convolution window of length m supplied as input, to the output vector w.
//The second parameter is the width measured in sample rate/number of samples and should be f for time domain and 1/f for frequency domain. The width is inversely proportional to a.
//Examples
//gaussian(5,6)
//ans  =
//    5.380D-32  
//    1.523D-08  
//    1.         
//    1.523D-08  
//    5.380D-32  

funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end
if(rhs==1)
w = callOctave("gaussian",m)
elseif(rhs==2)
w = callOctave("gaussian",m, a)
end
endfunction

