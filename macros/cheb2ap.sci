function [z, p, g] = cheb2ap (n, Rs)
//This function designs a lowpass analog Chebyshev type II filter.
//Calling Sequence
//[z, p, g] = cheb2ap (n, Rs)
//[z, p] = cheb2ap (n, Rs)
//p = cheb2ap (n, Rs)
//Parameters 
//n: Filter Order
//Rs: Stopband attenuation
//z: Zeros
//p: Poles
//g: Gain
//Description
//This is an Octave function.
//This function designs a lowpass analog Chebyshev type II filter of nth order and with a stopband attenuation of Rs.
//Examples
//

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 2 | rhs > 2)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 2 then
		if(lhs==1)
		z = callOctave("cheb2ap", n, Rs)
		elseif(lhs==2)
		[z, p] = callOctave("cheb2ap", n, Rs)
		elseif(lhs==3)
		[z, p, g] = callOctave("cheb2ap", n, Rs)
		else
		error("Wrong number of output argments.")
		end
	end
endfunction
