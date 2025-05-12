function [y]=gauspuls(t,fc,bw)
// Generates Gaussian-modulated sinusoidal pulses
// 
// Syntax
//	[y]=gauspuls(t,fc,bw)
//	[y]=gauspuls(t,fc)
//	[y]=gauspuls(t)
// 
// Parameters
//	t: Real or complex valued vector or matrix
//	fc: Real non negative number or complex number
//	bw: Real positive number or complex number
// 
// Description
//	This function returns a Gaussian RF pulse of unity amplitude at the times indicated in array t.
// 
// Examples
// 	gauspuls(1,2,3)
// 

if ( argn(2)<1 | argn(2)>3 ) then
 error ("Wrong number of input arguments.")
elseif (argn(2)==1)
    fc = 1e3; bw = 0.5;
elseif (argn(2)==2)
     bw = 0.5;
 end
 
 
 if (~isscalar(fc) | ~isreal(fc) | fc<0) then
     error('fc must be non-negative real scalar')
 end
  if (~isscalar(bw) | ~isreal(bw) | bw<=0) then
     error('bw must be positive real scalar')
 end
  y = exp (-t .* t / (2*(1 / (4*%pi^2 * (-(bw^2 * fc^2) / (8 * log (10 ^ (-6/20)))))))) .* cos (2*%pi*fc * t);

endfunction
