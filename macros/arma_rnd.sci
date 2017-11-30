function res = arma_rnd (a, b, v, t, n)
//Return a simulation of the ARMA model.
//Calling Sequence
//arma_rnd (a, b, v, t, n)
//arma_rnd (a, b, v, t)
//Parameters 
//a: vector
//b: vector
//v: Variance
//t: Length of output vector
//n: Number of dummy x(i) used for initialization
//Description
//This is an Octave function.
//The ARMA model is defined by
//
//x(n) = a(1) * x(n-1) + … + a(k) * x(n-k)
//     + e(n) + b(1) * e(n-1) + … + b(l) * e(n-l)
//in which k is the length of vector a, l is the length of vector b and e is Gaussian white noise with variance v. The function returns a vector of length t.
//
//The optional parameter n gives the number of dummy x(i) used for initialization, i.e., a sequence of length t+n is generated and x(n+1:t+n) is returned. If n is omitted, n = 100 is used.
//Examples
//a = [1 2 3 4 5];
//b = [7; 8; 9; 10; 11];
//v = 10;
//t = 5;
//n = 100;
//arma_rnd (a, b, v, t, n)
//ans =
//
//  -1.6176e+05
//  -4.1663e+05
//  -1.0732e+06
//  -2.7648e+06
//  -7.1221e+06

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 5 | rhs > 6)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 5 then
	res = callOctave("arma_rnd",a, b, v, t)

	case 6 then
	res = callOctave("arma_rnd",a, b, v, t, n)

	end
endfunction
