function [f]=fwhmjlt(y,varargin)
//This function Computes peak full-width at half maximum

//calling sequence
//f = fwhm (y)
//f = fwhm (x, y)
//f = fwhm (…, "zero")
//f = fwhm (…, "min")
//f = fwhm (…, "alevel", level)
//f = fwhm (…, "rlevel", level)

//Description
//Compute peak full-width at half maximum (FWHM) or at another level of peak maximum for vector or matrix    data y, optionally sampled as y(x). If y is a matrix, return FWHM for each column as a row vector.
//The default option "zero" computes fwhm at half maximum, i.e. 0.5*max(y). The option "min" computes fwhm at the middle curve, i.e. 0.5*(min(y)+max(y)).
//The option "rlevel" computes full-width at the given relative level of peak profile
//The option "alevel" computes full-width at the given absolute level of y.

//Example
//t=-50:0.01:50;
//y=(1/(2*sqrt(2*%pi)))*exp(-(t.^2)/8);
//z=fwhmjlt(y)
//Output: 470.96442

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
