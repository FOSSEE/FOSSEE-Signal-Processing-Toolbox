function b = polystab(a)
//This function stabilizes the polynomial transfer function. 
//Calling Sequence
//b = polystab(a)
//Parameters 
//a:
//Description
//This is an Octave function.
//This function stabilizes the polynomial transfer function by replacing all roots outside the unit circle with their reflection inside the unit circle.
//Examples
//polystab([1,3,5])
//ans  =
//    1.    0.6    0.2  

funcprot(0);
rhs = argn(2)
if(rhs~=1)
error("Wrong number of input arguments.")
end
b = callOctave("polystab",a)
endfunction
