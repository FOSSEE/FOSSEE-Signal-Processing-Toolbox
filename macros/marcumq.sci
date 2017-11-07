function q = marcumq (a, b, m, tol)
//This function computes the generalized Marcum Q function of order m with noncentrality parameter a and argument b. 
//Calling Sequence
//q = marcumq (a, b)
//q = marcumq (a, b, m)
//q = marcumq (a, b, m, tol)
//Parameters 
//a:
//b:
//m: default value 1
//tol: default value eps
//Description
//This is an Octave function.
//This function computes the generalized Marcum Q function of order m with noncentrality parameter a and argument b. 
//The third argument m is the order, which by default is 1.
//The fourth argument tol is the tolerance, which by default is eps.
//If input arguments are vectors which correspond in size and degree, the output is a table of values.
//This function calculates Marcum’s Q function using the infinite Bessel series, which is truncated when the relative error is less than the specified tolerance.
//Examples
//marcumq([1,2,3],4)
//ans  =
//    0.0028895    0.0341348    0.1965122 

funcprot(0);
rhs = argn(2)
if(rhs<2 | rhs>4)
error("Wrong number of input arguments.")
end
	select(rhs)
	case 2 then
	q = callOctave("marcumq",a,b)
	case 3 then
	q = callOctave("marcumq",a,b,m)
	case 4 then
	q = callOctave("marcumq",a,b,m,tol)
	end
endfunction
	
