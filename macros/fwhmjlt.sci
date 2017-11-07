function [f]=bitrevorder(y,varargin)
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
