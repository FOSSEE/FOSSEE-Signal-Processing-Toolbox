function [a, b, c, d] = cheby2 (n, rs, w, varargin)
//This function generates a Chebyshev type II filter with rs dB of stopband attenuation.
//Calling Sequence
//[a, b] = cheby2 (n, rs, wc)
//[a, b] = cheby2 (n, rs, wc, "high")
//[a, b] = cheby2 (n, rs, [wl, wh])
//[a, b] = cheby2 (n, rs, [wl, wh], "stop")
//[a, b, c] = cheby2 (…)
//[a, b, c, d] = cheby2 (…)
//[…] = cheby2 (…, "s")
//Parameters 
//n: positive integer value
//rp: non negative scalar value
//w: vector, all elements must be in the range [0,1]
//Description
//This is an Octave function.
//This function generates a Chebyshev type II filter with rs dB of stopband attenuation.
//The fourth parameter takes in high or low, default value is low. The cutoff is pi*Wc radians.
//[b, a] = cheby2(n, Rp, [Wl, Wh]) indicates a band pass filter with edges pi*Wl and pi*Wh radians.
//[b, a] = cheby2(n, Rp, [Wl, Wh], ’stop’) indicates a band reject filter with edges pi*Wl and pi*Wh radians.
//[z, p, g] = cheby2(...) returns filter as zero-pole-gain rather than coefficients of the numerator and denominator polynomials.
//[...] = cheby2(...,’s’) returns a Laplace space filter, w can be larger than 1.
//[a,b,c,d] = cheby2(...) returns state-space matrices.
//Examples
//[a,b,c]=cheby2(2,5,0.7,"high")
//a =
//  -0.31645 - 0.94861i  -0.31645 + 0.94861i
//b =
//  -0.39388 + 0.53138i  -0.39388 - 0.53138i
//c =  0.47528

rhs = argn(2)
lhs = argn(1)

if(rhs>5 | rhs<3)
error("wrong number of input arguments.")
end
if(lhs<4 | lhs<2)
error("Wrong number of output arguments.")
end

select (rhs)
	case 3 then
		if (lhs==2) 	 [a,b] = callOctave("cheby2",n, rp, w)
		elseif (lhs==3)  [a,b,c] = callOctave("cheby2",n, rp, w)
		elseif (lhs==4)  [a,b,c,d] = callOctave("cheby2",n, rp, w)
		end
	case 4 then
		if (lhs==2) 	 [a,b] = callOctave("cheby2",n, rp, w, varargin(1))
		elseif (lhs==3)  [a,b,c] = callOctave("cheby2",n, rp, w, varargin(1))
		elseif (lhs==4)  [a,b,c,d] = callOctave("cheby2",n, rp, w, varargin(1))
		end
	case 5 then
		if (lhs==2) 	 [a,b] = callOctave("cheby2",n, rp, rs, w, varargin(1), varargin(2))
		elseif (lhs==3)  [a,b,c] = callOctave("cheby2",n, rp, rs, w, varargin(1), varargin(2))
		elseif (lhs==4)  [a,b,c,d] = callOctave("cheby2",n, rp, rs, w, varargin(1), varargin(2))
		end
	end
endfunction
