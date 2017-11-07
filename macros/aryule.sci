function [a, v, k] = aryule (x, p)
//This function fits an AR (p)-model with Yule-Walker estimates.
//Calling Sequence
//a = aryule (x, p)
//[a, v] = aryule (x, p)
//[a, v, k] = aryule (x, p)
//Parameters 
//x: vector of real or complex numbers, length > 2
//p: positive integer value < length(x) - 1
//a, v, k: Output variables 
//Description
//This is an Octave function.
//
//This function fits an AR (p)-model with Yule-Walker estimates.
//The first argument is the data vector which is to be estimated. 
//Output variable a gives the AR coefficients, v gives the variance of the white noise and k gives the reflection coefficients to be used in the lattice filter.
//Examples
//aryule([1,2,3,4,5],2)
//ans  =
//    1.  - 0.8140351    0.1192982

funcprot(0);
rhs = argn(2)
lhs = argn(1)

if(rhs~=2)
error("Wrong number of input arguments.")
end

	select(lhs)
	case 1 then
	a = callOctave("aryule",x,p)
	case 2 then
	[a,v] = callOctave("aryule",x,p)
	case 3 then
	[a,v,k] = callOctave("aryule",x,p)
	end

endfunction
