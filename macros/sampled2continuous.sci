function x = sampled2continuous (n, s, t)
//This function calculates the output reconstructed from the samples n supplied as input, at a rate of 1/s samples per unit time.
//Calling Sequence
//x = sampled2continuous (n, s, t)
//Parameters 
//n:
//s:
//t:
//Description
//This is an Octave function.
//This function calculates the output reconstructed from the samples n supplied as input, at a rate of 1/s samples per unit time.
//The third parameter t is all the instants where output x is needed from intput n and this time is relative to x(0).
//Examples
//sampled2continuous([1,2,3],5,6)
//ans  =
//    2.4166806  
funcprot(0);
rhs = argn(2)
if(rhs<3)
error("Wrong number of input arguments.")
end
x = callOctave("sampled2continuous", n, s, t)

endfunction
