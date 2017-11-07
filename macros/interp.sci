//function already exists in scilab -- doesnt work like this one (I guess)    
function y = interp(x, q, n, Wc)
//This function upsamples the signal x by a factor of q, using an order 2*q*n+1 FIR filter.
//Calling Sequence
//y = interp(x, q)
//y = interp(x, q, n)
//y = interp(x, q, n, Wc)
//Parameters 
//x: scalar or vector of complex or real numbers 
//q: positive integer value, or logical
//n: positive integer, default value 4
//Wc: non decreasing vector or scalar, starting from 0 uptill 1, default value 0.5
//Description
//This is an Octave function.
//This function upsamples the signal x by a factor of q, using an order 2*q*n+1 FIR filter.
//The second argument q must be an integer. The default values of the third and fourth arguments (n, Wc) are 4 and 0.5 respectively.
//Examples
//interp(1,2)
//ans  = 
//    0.4792743    0.3626016 
funcprot(0);
rhs = argn(2)
if(rhs<2 | rhs>4)					//source code says rhs<1 -- but crashes for just one arg 
error("Wrong number of input arguments.")
end
	
		 


	select(rhs)
	case 2 then
	y = callOctave("interp",x,q)
	case 3 then
	y = callOctave("interp",x,q,n)
	case 4 then
	y = callOctave("interp",x,q,n,Wc)
	end
endfunction
