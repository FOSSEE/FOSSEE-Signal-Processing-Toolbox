function [psi, x] = cmorwavf(lb, ub, n, fb, fc)
// Compute the Complex Morlet Wavelet.
//
// Syntax
//   [psi, x] = cmorwavf(lb, ub, n, fb, fc)
//
// Parameters
// lb: Real or complex scalar. Lower bound of the interval.
// ub: Real or complex scalar. Upper bound of the interval.
// n: Positive integer. Number of points in the interval.
// fb: Real or complex scalar. Bandwidth parameter. Default is 1.
// fc: Real or complex scalar. Wavelet center frequency. Default is 1.
// psi: Complex vector. Values of the Complex Morlet Wavelet.
// x: Vector. Regular grid points in the interval [lb, ub].
//
// Description
// This function computes the Complex Morlet Wavelet for a given interval [lb, ub] with `n` points, bandwidth parameter `fb`, and wavelet center frequency `fc`.
//
// Examples
// [psi, x] = cmorwavf(1, 2, 100, 3, 4)
// 

if(argn(2)~=5 & argn(2)~=3) then
	error ("Wrong number of input arguments.")
     
elseif (n<=0 | floor(n) ~=n) then
          
    error("n must be an integer strictly positive");
  end 
  
  if (argn(2)==3) then
            fb=1; fc=1;
            end     
          
x = linspace(lb,ub,n);
  psi =((%pi*fb)^(-0.5))*exp(2*%i*%pi*fc.*x).*exp(-x.^2/fb);       
                           
endfunction
