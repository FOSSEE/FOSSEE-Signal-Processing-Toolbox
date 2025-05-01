function y = meyeraux(x)
// Wavelet Auxiliary function
//
// Syntax
//   y = meyeraux(x)
//
// Parameters
// x: Input signal.
// y: Meyer auxiliary function of the input signal.
//
// Description
// This function computes the Meyer auxiliary function for the input signal `x`.
//
// Examples
// y = meyeraux([1, 2, 3, 4])
//


if (argn(2)~=1) then
	error ("Wrong number of input arguments.")
else 
  y = 35.*x.^4-84.*x.^5+70.*x.^6-20.*x.^7;
end
endfunction


