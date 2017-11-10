function [a, b, c, d] = zp2ss (z, p, k)
//Converts zeros / poles to state space.
//Calling Sequence
//[a, b, c, d] = zp2ss (z, p, k)
//[a, b, c] = zp2ss (z, p, k)
//[a, b] = zp2ss (z, p, k)
//a = zp2ss (z, p, k)
//Parameters 
//z: Zeros
//p: Poles
//k: Leading coefficient
//a: State space parameter
//a: State space parameter
//b: State space parameter
//c: State space parameter
//d: State space parameter
//Description
//This is an Octave function.
//It converts zeros / poles to state space.
//Examples
//z = [1 2 3]
// p = [4 5 6]
//k = 5
//[a, b, c, d] = zp2ss (z, p, k)
//a =
//
//   -0.00000    0.00000   -1.20000
//  -10.00000    0.00000   -7.40000
//    0.00000   10.00000   15.00000
//
//b =
//
//   -5.7000
//  -31.5000
//   45.0000
//
//c =
//
//   0.00000   0.00000   1.00000
//
//d =  5	

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 3 | rhs > 3)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 3 then
		if(lhs==1)
		a = callOctave("zp2ss", z, p, k)
		elseif(lhs==2)
		[a, b] = callOctave("zp2ss", z, p, k)
		elseif(lhs==3)
		[a, b, c] = callOctave("zp2ss", z, p, k)
		elseif(lhs==4)
		[a, b, c, d] = callOctave("zp2ss", z, p, k)
		else
		error("Wrong number of output argments.")
		end
	end
endfunction
