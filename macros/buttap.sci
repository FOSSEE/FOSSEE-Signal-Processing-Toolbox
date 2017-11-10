function [z, p, g] = buttap (n)
//Design a lowpass analog Butterworth filter.
//Calling Sequence
//z = buttap (n)
//[z, p] = buttap (n)
//[z, p, g] = buttap (n)
//Parameters 
//n: Filter Order
//z: Zeros
//p: Poles
//g: Gain
//Description
//This is an Octave function.
//It designs a lowpass analog Butterworth filter of nth order.
//Examples
//[z, p, g] = buttap (5)
//z = [](0x0)
//p =
//
//  -0.30902 + 0.95106i  -0.80902 + 0.58779i  -1.00000 + 0.00000i  -0.80902 - 0.58779i  -0.30902 - 0.95106i
//
//g =  1


funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 1 | rhs > 1)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 1 then
		if(lhs==1)
		z = callOctave("buttap",n)
		elseif(lhs==2)
		[z, p] = callOctave("buttap",n)
		elseif(lhs==3)
		[z, p, g] = callOctave("buttap",n)
		else
		error("Wrong number of output argments.")
		end
	end
endfunction
