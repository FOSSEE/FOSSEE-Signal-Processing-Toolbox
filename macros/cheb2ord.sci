function [n, Wc] = cheb2ord(Wp, Ws, Rp, Rs)
//This function computes the minimum filter order of a Chebyshev type II filter with the desired response characteristics. 
//Calling Sequence
//n = cheb2ord(Wp, Ws, Rp, Rs)
//[n, Wc] = cheb2ord(Wp, Ws, Rp, Rs)
//Parameters 
//Wp: scalar or vector of length 2, all elements must be in the range [0,1]
//Ws: scalar or vector of length 2, all elements must be in the range [0,1]
//Rp: real value
//Rs: real value
//Description
//This is an Octave function.
//This function computes the minimum filter order of a Chebyshev type II filter with the desired response characteristics. 
//Stopband frequency ws and passband frequency wp specify the the filter frequency band edges. 
//Frequencies are normalized to the Nyquist frequency in the range [0,1]. 
//Rp is measured in decibels and is the allowable passband ripple and Rs is also measured in decibels and is the minimum attenuation in the stop band.
//If ws>wp then the filter is a low pass filter. If wp>ws, then the filter is a high pass filter.
//If wp and ws are vectors of length 2, then the passband interval is defined by wp and the stopband interval is defined by ws. 
//If wp is contained within the lower and upper limits of ws, the filter is a band-pass filter. If ws is contained within the lower and upper limits of wp, the filter is a band-stop or band-reject filter.
//Examples
//cheb2ord([0.25,0.3],[0.2,0.8],0.3,0.4)
//ans =  1

rhs = argn(2)
lhs = argn(1)
if(rhs~=4)
error("Wrong number of input arguments.")
end

	select(lhs)
	case 1 then
	n = callOctave("cheb2ord",Wp,Ws,Rp,Rs)
	case 2 then
	[n,Wc] = callOctave("cheb2ord",Wp,Ws,Rp,Rs)
	end
endfunction
