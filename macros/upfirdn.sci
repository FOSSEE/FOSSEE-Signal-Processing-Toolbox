function y = upfirdn (x, h, p, q)
//This function upsamples the input data, applies the FIR filter and then downsamples it.
//Calling Sequence
//y = upfirdn (x, h, p, q)
//Parameters 
//x:
//h:
//p:
//q:
//Description
//This is an Octave function.
//This function upsamples the input data in the matrix by a factor of n. Then the upsampled data is FIR filtered. After this, the resultant is downsampled.
//Examples
//upfirdn([1,2,3],2,3,5)
//ans  =
//
//    2.    0. 
funcprot(0);
rhs = argn(2)
if(rhs~=4)
error("Wrong number of input arguments.")
end

y = callOctave("upfirdn",x, h, p, q)

endfunction
