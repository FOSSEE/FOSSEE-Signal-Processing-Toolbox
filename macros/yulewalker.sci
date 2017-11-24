function [A,V]= yulewalker(C)
// Fit an AR (p)-model with Yule-Walker estimates given a vector C of autocovariances '[gamma_0, ..., gamma_p]'.
//Calling Sequence
//A    = yulewalker(C)
//[A,V]= yulewalker(C)
//Parameters 
//C: Autocovariances
//Description
//Fit an AR (p)-model with Yule-Walker estimates given a vector C of autocovariances '[gamma_0, ..., gamma_p]'.
//Returns the AR coefficients, A, and the variance of white noise, V.
funcprot(0);
lhs=argn(1);
rhs= argn(2);

if(rhs<1 | rhs>1)
	error("Wrong number of input arguments");
end

if(lhs<1 | lhs>2)
	error("Wrong number of output arguments");
end

select(lhs)

	case 1 then
		A= callOctave("yulewalker", C);
	case 2 then
		[A,V]= callOctave("yulewalker", C);
end
endfunction 


