function [zero, pole, gain] = besselap (n)
//Return bessel analog filter prototype.
//Calling Sequence
//[zero, pole, gain] = besselap (n)
//[zero, pole] = besselap (n)
//zero = besselap (n)
//Parameters 
//n: Filter Order
//zero: Zeros
//pole: Poles
//gain: Gain
//Description
//This is an Octave function.
//It Return bessel analog filter prototype of nth order.
//Examples
//[zero, pole, gain] = besselap (5)
//zero = [](0x0)
//pole =
//
//  -0.59058 + 0.90721i
//  -0.59058 - 0.90721i
//  -0.92644 + 0.00000i
//  -0.85155 + 0.44272i
//  -0.85155 - 0.44272i
//
//gain =  1

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 1 | rhs > 1)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 1 then
		if(lhs==1)
		zero = callOctave("besselap",n)
		elseif(lhs==2)
		[zero, pole] = callOctave("besselap",n)
		elseif(lhs==3)
		[zero, pole, gain] = callOctave("besselap",n)
		else
		error("Wrong number of output argments.")
		end
	end
endfunction
