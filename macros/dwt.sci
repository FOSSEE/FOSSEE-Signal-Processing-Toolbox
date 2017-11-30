function [U, V] = dwt(X, varargin)
//Discrete wavelet transform (1D)
//Calling Sequence
//[U, V] = dwt(X, WNAME)
//[U, V] = dwt(X, HP, GP)
//[U, V] = dwt(X, HP, GP,...)
//Parameters
//Inputs:
//X: Signal Vector.
//WNAME: Wavelet name.
//HP: Coefficients of low-pass decomposition FIR filter.
//GP: Coefficients of high-pass decomposition FIR filter.
//Outputs:
//U: Signal vector of average, approximation.
//V: Signal vector of difference, detail.
//Description
//This function calculates the discrete wavelet transform (1D).
//Examples
//
funcprot(0);
rhs = argn(2)
if(rhs<2 | rhs>4)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 2 then
	[U, V] = callOctave("dwt", X, varargin(1));
    case 3 then
    [U, V] = callOctave("dwt", X, varargin(1), varargin(2));
    case 4 then
    [U, V] = callOctave("dwt", X, varargin(1), varargin(2), varargin(3));
	end
endfunction
