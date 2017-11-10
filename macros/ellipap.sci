function [z, p, g] = ellipap (n, Rp, Rs)
//Designs a lowpass analog elliptic filter.
//Calling Sequence
//[z, p, g] = ellipap (n, Rp, Rs)
//[z, p] = ellipap (n, Rp, Rs)
//z = ellipap (n, Rp, Rs)
//Parameters 
//n: Filter Order
//Rp: Peak-to-peak passband ripple
//Rs: Stopband attenuation
//Description
//This is an Octave function.
//It designs a lowpass analog elliptic filter of nth order, with a Peak-to-peak passband ripple of Rp and a stopband attenuation of Rs.
//Examples
//[z, p, g] = ellipap (5, 10, 10)
//z =
//
//   0.0000 + 2.5546i   0.0000 + 1.6835i  -0.0000 - 2.5546i  -0.0000 - 1.6835i
//
//p =
//
//  -0.05243 + 0.63524i  -0.01633 + 0.96289i  -0.05243 - 0.63524i  -0.01633 - 0.96289i  -0.07369 + 0.00000i
//
//g =  0.0015012

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 3 | rhs > 3)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 3 then
		if(lhs==1)
		z = callOctave("ellipap", n, Rp, Rs)
		elseif(lhs==2)
		[z, p] = callOctave("ellipap", n, Rp, Rs)
		elseif(lhs==3)
		[z, p, g] = callOctave("ellipap", n, Rp, Rs)
		else
		error("Wrong number of output argments.")
		end
	end
endfunction
