function [f] = fwhm(y, varargin)
//This function computes peak full width at half minimum or at another level of peak minimum for vector or matrix data y supplied as input.
//Calling Sequence
//f = fwhm (y)
//f = fwhm (x, y)
//f = fwhm (…, "zero")
//f = fwhm (…, "min")
//f = fwhm (…, "alevel", level)
//f = fwhm (…, "rlevel", level)
//Parameters 
//y: vector or matrix

//Description
//This is an Octave function.
//This function computes peak full width at half minimum or at another level of peak minimum for vector or matrix data y supplied as input.
//If y is a matrix, fwhm is calculated for each column as a row vector.
//The second argument is by default "zero" which computes the fwhm at half maximum. If it is "min", fwhm is computed at middle curve.
//The option "rlevel" computes full-width at the given relative level of peak profile.
//The option "alevel" computes full-width at the given absolute level of y.
//This function returns 0 if FWHM does not exist.
//Examples
//fwhm([1,2,3;9,-7,0.6],[4,5,6])
//ans = 0.
funcprot(0);

rhs = argn(2)
if(rhs<1 | rhs>5)
error("Wrong number of input arguments.")
end

select(rhs)
	case 1 then
	f = callOctave("fwhm",y)
	case 2 then
	f = callOctave("fwhm",y,varargin(1))
	case 3 then
	f = callOctave("fwhm",y,varargin(1),varargin(2))
	case 4 then
	f = callOctave("fwhm",y,varargin(1),varargin(2),varargin(3))
	case 5 then
	f = callOctave("fwhm",y,varargin(1),varargin(2),varargin(3),varargin(4))
	end
endfunction
