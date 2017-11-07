function [a, b, c, d] = besself (n, w, varargin)
//This function generates a Bessel filter.
//Calling Sequence
//[a, b] = besself(n, w)
//[a, b] = besself (n, w, "high")
//[a, b, c] = besself (…)
//[a, b, c, d] = besself (…)
//[…] = besself (…, "z")
//Parameters 
//n: positive integer value
//w: positive real value
//Description
//This is an Octave function.
//This function generates a Bessel filter. The default is a Laplace space (s) filter.
//The third parameter takes in high or low, the default value being low. The cutoff is pi*Wc radians.
//[z,p,g] = besself(...) returns filter as zero-pole-gain rather than coefficients of the numerator and denominator polynomials.
//[...] = besself(...,’z’) returns a discrete space (Z) filter. w must be less than 1.
//[a,b,c,d] = besself(...) returns state-space matrices. 
//Examples
//[a,b]=besself(2,3,"low")
//a =  9.0000
//b =
//   1.0000   5.1962   9.0000

funcprot(0);
rhs = argn(2)
lhs = argn(1)
if(rhs<2 | rhs>4)
error("Wrong number of input arguments.")
end
if(lhs<2 | lhs>4)
error("Wrong number of output arguments.")
end


	select (rhs)
	case 2 then
		if (lhs==2) 	 [a,b] = callOctave("besself",n, w)
		elseif (lhs==3)  [a,b,c] = callOctave("besself",n, w)
		elseif (lhs==4)  [a,b,c,d] = callOctave("besself",n, w)
		end
	case 3 then
		if (lhs==2)	 [a,b] = callOctave("besself",n, w,varargin(1))
		elseif (lhs==3)  [a,b,c] = callOctave("besself",n, w,varargin(1))
		elseif (lhs==4)  [a,b,c,d] = callOctave("besself",n, w,varargin(1))
		end
	case 4 then
		if (lhs==2)      [a,b] = callOctave("besself",n, w,varargin(1),varargin(2))
		elseif (lhs==3)  [a,b,c] = callOctave("besself",n, w,varargin(1),varargin(2))
		elseif (lhs==4)  [a,b,c,d] = callOctave("besself",n, w,varargin(1),varargin(2))
		end
	end
endfunction
