function [a, b, c, d] = butter (n, w, varargin)
//This function generates a Butterworth filter. 
//Calling Sequence
//[a, b] = butter (n, w)
//[a, b] = butter (n, w, "high")
//[a, b] = butter (n, [wl, wh])
//[b, a] = butter (n, [wl, wh], "stop")
//[a, b, c] = butter (…)
//[a, b, c, d] = butter (…)
//[…] = butter (…, "s")
//Parameters 
//n: positive integer value
//w: positive real value, w in the range [0,1]
//Description
//This is an Octave function.
//This function generates a Butterworth filter. Default is a discrete space (Z) filter.
//The third parameter takes in low or high, default value is low. The cutoff is pi*Wc radians.
//[b,a] = butter(n, [Wl, Wh]) indicates a band pass filter with edges pi*Wl and pi*Wh radians. 
//[b,a] = butter(n, [Wl, Wh], ’stop’) indicates a band reject filter with edges pi*Wl and pi*Wh radians.
//[z,p,g] = butter(...) returns filter as zero-pole-gain rather than coefficients of the numerator and denominator polynomials.
//[...] = butter(...,’s’) returns a Laplace space filter, w can be larger than 1.
//[a,b,c,d] = butter(...) returns state-space matrices.
//Examples
//[a,b]=butter(3, 0.7)
//a =
//   0.37445   1.12336   1.12336   0.37445
//b =
//   1.00000   1.16192   0.69594   0.13776

rhs = argn(2)
lhs = argn(1)
if(rhs>4 | rhs<2)
error("Wrong number of input arguments.")
end
if(lhs>4 | lhs<2)
error("Wrong number of output arguments.")
end

	select (rhs)
	case 2 then
		if (lhs==2) 	 [a,b] = callOctave("butter",n, w)
		elseif (lhs==3)  [a,b,c] = callOctave("butter",n, w)
		elseif (lhs==4)  [a,b,c,d] = callOctave("butter",n, w)
		end
	case 3 then
		if (lhs==2)	 [a,b] = callOctave("butter",n, w,varargin(1))
		elseif (lhs==3)  [a,b,c] = callOctave("butter",n, w,varargin(1))
		elseif (lhs==4)  [a,b,c,d] = callOctave("butter",n, w,varargin(1))
		end
	case 4 then
		if (lhs==2)      [a,b] = callOctave("butter",n, w,varargin(1),varargin(2))
		elseif (lhs==3)  [a,b,c] = callOctave("butter",n, w,varargin(1),varargin(2))
		elseif (lhs==4)  [a,b,c,d] = callOctave("butter",n, w,varargin(1),varargin(2))
		end
	end
endfunction
	

