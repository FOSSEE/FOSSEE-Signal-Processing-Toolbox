function res = cheb (n, x)
//Calculates the nth-order Chebyshev polynomial at the point x.
//Calling Sequence
//cheb(n, x)
//Parameters 
//n: Filter order
//x: Point at which the Chebyshev polynomial is calculater. 
//Description
//This is an Octave function.
//Equation for Chebyshev polynomial is
//           / cos(n acos(x),    |x| <= 1
//   Tn(x) = |
//           \ cosh(n acosh(x),  |x| > 1
//
//x can also be a vector. In that case the output will also be a vector of same size as x.
//Examples
//x = [1 2 3 4]
// cheb(10, x)
//ans =
//
//   1.0000e+00   2.6209e+05   2.2620e+07   4.5747e+08

funcprot(0);
rhs = argn(2)
if (rhs < 2 | rhs > 2)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 2 then
		res = callOctave("cheb",n,x)
	end
endfunction
