function [num, den] = zp2tf (z, p, k)
//Converts zeros / poles to a transfer function.
//Calling Sequence
//[num, den] = zp2tf (z, p, k)
//num = zp2tf (z, p, k)
//Parameters 
//z: Zeros
//p: Poles
//k: Leading coefficient
//Num: Numerator of the transfer function
//den: Denomenator of the transfer function
//Description
//This is an Octave function.
//It converts zeros / poles to a transfer function.
//Examples
//z = [1 2 3]
// p = [4 5 6]
//k = 5
//[num, den] = zp2tf (z, p, k)
//num =
//
//    5  -30   55  -30
//
//den =
//
//     1   -15    74  -120

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 3 | rhs > 3)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 3 then
		if(lhs==1)
		num = callOctave("zp2tf", z, p, k)
		elseif(lhs==2)
		[num, den] = callOctave("zp2tf", z, p, k)
		else
		error("Wrong number of output argments.")
		end
	end
endfunction
