function [psi,x]=cmorwavf(lb,ub,n,fb,fc)

// Finds the Complex Morlet Wavelet
// Calling Sequence
// [psi,x]=cmorwavf(lb,ub,n,fb,fc)
// Parameters
// lb: Real or complex valued vector or matrix
// ub: Real or complex valued vector or matrix
// n: Real scalar strictly positive integer
// fb: Real or complex scalar value
// fc: Real or complex scalar value
// Description
// This function returns the value of the Complex Morlet Waveform defined by a positive bandwidth parameter FB, a wavelet center frequency FC on an N point regular grid for the interval [LB,UB].
// Examples
// [a,b]=cmorwavf(1,2,1,3,4)
// b=2
// a=0.0858628 -1.682D-16i


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
