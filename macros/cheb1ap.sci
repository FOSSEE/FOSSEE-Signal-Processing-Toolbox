function [z, p, g] = cheb1ap (n, Rp)
//This function designs a lowpass analog Chebyshev type I filter.
//Calling Sequence
//[z, p, g] = cheb1ap (n, Rp)
//[z, p] = cheb1ap (n, Rp)
//p = cheb1ap (n, Rp)
//Parameters 
//n: Filter Order
//Rp: Peak-to-peak passband ripple
//z: Zeros
//p: Poles
//g: Gain
//Description
//This is an Octave function.
//It designs a lowpass analog Chebyshev type I filter of nth order and with a Peak-to-peak passband ripple of Rp.
//Examples
//[z, p, g] = cheb1ap (10, 20)
//z = [](0x0)
//p =
//
// Columns 1 through 6:
//
//  -0.00157 - 0.98774i  -0.00456 - 0.89105i  -0.00709 - 0.70714i  -0.00894 - 0.45401i  -0.00991 - 0.15644i  -0.00991 + 0.15644i
//
// Columns 7 through 10:
//
//  -0.00894 + 0.45401i  -0.00709 + 0.70714i  -0.00456 + 0.89105i  -0.00157 + 0.98774i
//
//g =  1.9630e-04 - 6.3527e-22i

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 2 | rhs > 2)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 2 then
		if(lhs==1)
		z = callOctave("cheb1ap", n, Rp)
		elseif(lhs==2)
		[z, p] = callOctave("cheb1ap", n, Rp)
		elseif(lhs==3)
		[z, p, g] = callOctave("cheb1ap", n, Rp)
		else
		error("Wrong number of output argments.")
		end
	end
endfunction
