function res = arch_rnd (a, b, t)
//Simulate an ARCH sequence of length t with AR coefficients b and CH coefficients a.
//Calling Sequence
//arch_rnd (a, b, t)
//Parameters 
//a: CH coefficients
//b: AR coefficients
//t: Length of ARCH sequence
//Description
//This is an Octave function.
//It Simulates an ARCH sequence of length t with AR coefficients b and CH coefficients a.
//The result y(t) follows the model
//
//y(t) = b(1) + b(2) * y(t-1) + … + b(lb) * y(t-lb+1) + e(t),
//where e(t), given y up to time t-1, is N(0, h(t)), with
//
//h(t) = a(1) + a(2) * e(t-1)^2 + … + a(la) * e(t-la+1)^2
//Examples
//a = [1 2 3 4 5];
//b = [7 8 9 10];
//arch_rnd (a, b, t)
//ans =
//
//   6.1037e+00
//   5.7294e+01
//   5.7390e+02
//   6.3063e+03
//   6.8695e+04

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 3 | rhs > 3)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 3 then
	res = callOctave("arch_rnd",a, b, t)

	end
endfunction
