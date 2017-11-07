function [a, b, c, d] = ellip (n, rp, rs, w, varargin)
//This function generates an elliptic or Cauer filter with rp dB of passband ripple and rs dB of stopband attenuation.
//Calling Sequence
//[a, b] = ellip (n, rp, rs, wp)
//[a, b] = ellip (n, rp, rs, wp, "high")
//[a, b] = ellip (n, rp, rs, [wl, wh])
//[a, b] = ellip (n, rp, rs, [wl, wh], "stop")
//[a, b, c] = ellip (…)
//[a, b, c, d] = ellip (…)
//[…] = ellip (…, "s")
//Parameters 
//n: positive integer value
//rp: non negative scalar value
//rs: non negative scalar value
//w: scalar or vector, all elements should be in the range [0,1]
//Description
//This is an Octave function.
//This function generates an elliptic or Cauer filter with rp dB of passband ripple and rs dB of stopband attenuation.
//[b, a] = ellip(n, Rp, Rs, Wp) indicates low pass filter with order n, Rp decibels of ripple in the passband and a stopband Rs decibels down and cutoff of pi*Wp radians. If the fifth argument is high, then the filter is a high pass filter.
//[b, a] = ellip(n, Rp, Rs, [Wl, Wh]) indictaes band pass filter with band pass edges pi*Wl and pi*Wh. If the fifth argument is stop, the filter is a band reject filter.
//[z, p, g] = ellip(...) returns filter as zero-pole-gain.
//[...] = ellip(...,’s’) returns a Laplace space filter, w can be larger than 1.
//[a, b, c, d] = ellip(...) returns state-space matrices. 
//Examples
//[a,b]=ellip(2, 0.5, 0.7, [0.3,0.4])
//a =
//   0.88532  -1.58410   2.40380  -1.58410   0.88532
//b =
//   1.00000  -1.78065   2.68703  -1.75725   0.97454

rhs = argn(2)
lhs = argn(1)
if(rhs>3)
[rows,columns] = size(w)
end
if(rhs>6 | rhs<4)
error("Wrong number of input arguments.")
end
if(lhs>4 | lhs<2)
error("Wrong number of output arguments.")
end

select (rhs)
	case 4 then
		if (lhs==2) 	 [a,b] = callOctave("ellip",n, rp, rs, w)
		elseif (lhs==3)  [a,b,c] = callOctave("ellip",n, rp, rs, w)
		elseif (lhs==4)  [a,b,c,d] = callOctave("ellip",n, rp, rs, w)
		end
	case 5 then
		if (lhs==2) 	 [a,b] = callOctave("ellip",n, rp, rs, w, varargin(1))
		elseif (lhs==3)  [a,b,c] = callOctave("ellip",n, rp, rs, w, varargin(1))
		elseif (lhs==4)  [a,b,c,d] = callOctave("ellip",n, rp, rs, w, varargin(1))
		end
	case 6 then
		if (lhs==2) 	 [a,b] = callOctave("ellip",n, rp, rs, w, varargin(1), varargin(2))
		elseif (lhs==3)  [a,b,c] = callOctave("ellip",n, rp, rs, w,varargin(1), varargin(2))
		elseif (lhs==4)  [a,b,c,d] = callOctave("ellip",n, rp, rs, w, varargin(1), varargin(2))
		end
	end
endfunction
