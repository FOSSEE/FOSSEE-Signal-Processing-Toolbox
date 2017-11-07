function [a, b, c, d] = cheby1 (n, rp, w, varargin)
//This function generates a Chebyshev type I filter with rp dB of passband ripple.
//Calling Sequence
//[a, b] = cheby1 (n, rp, w)
//[a, b] = cheby1 (n, rp, w, "high")
//[a, b] = cheby1 (n, rp, [wl, wh])
//[a, b] = cheby1 (n, rp, [wl, wh], "stop")
//[a, b, c] = cheby1 (…)
//[a, b, c, d] = cheby1 (…)
//[…] = cheby1 (…, "s")
//Parameters 
//n: positive integer value
//rp: non negative scalar value
//w: vector, all elements must be in the range [0,1]
//Description
//This is an Octave function.
//This function generates a Chebyshev type I filter with rp dB of passband ripple.
//The fourth parameter takes in high or low, default value is low. The cutoff is pi*Wc radians.
//[b, a] = cheby1(n, Rp, [Wl, Wh]) indicates a band pass filter with edges pi*Wl and pi*Wh radians.
//[b, a] = cheby1(n, Rp, [Wl, Wh], ’stop’) indicates a band reject filter with edges pi*Wl and pi*Wh radians.
//[z, p, g] = cheby1(...) returns filter as zero-pole-gain rather than coefficients of the numerator and denominator polynomials.
//[...] = cheby1(...,’s’) returns a Laplace space filter, w can be larger than 1.
//[a,b,c,d] = cheby1(...) returns state-space matrices.
//Examples
//[a,b,c]=cheby1(2,6,0.7,"high")
//a =
//   1   1
//b =
//  -0.62915 + 0.55372i  -0.62915 - 0.55372i
//c =  0.055649

rhs = argn(2)
lhs = argn(1)
[rows,columns] = size(w)
if(rhs>5 | rhs<3)
error("Wrong number of input arguments.")
end
if(lhs>4 | lhs<2)
error("Wrong number of output arguments.")
end

	select (rhs)
	case 3 then
		if (lhs==2) 	 [a,b] = callOctave("cheby1",n, rp, w)
		elseif (lhs==3)  [a,b,c] = callOctave("cheby1",n, rp, w)
		elseif (lhs==4)  [a,b,c,d] = callOctave("cheby1",n, rp, w)
		end
	case 4 then
		if (lhs==2) 	 [a,b] = callOctave("cheby1",n, rp, w, varargin(1))
		elseif (lhs==3)  [a,b,c] = callOctave("cheby1",n, rp, w, varargin(1))
		elseif (lhs==4)  [a,b,c,d] = callOctave("cheby1",n, rp, w, varargin(1))
		end
	case 5 then
		if (lhs==2) 	 [a,b] = callOctave("cheby1",n, rp, rs, w, varargin(1), varargin(2))
		elseif (lhs==3)  [a,b,c] = callOctave("cheby1",n, rp, rs, w, varargin(1), varargin(2))
		elseif (lhs==4)  [a,b,c,d] = callOctave("cheby1",n, rp, rs, w, varargin(1), varargin(2))
		end
	end
endfunction
