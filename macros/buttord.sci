function [n, Wc] = buttord(Wp, Ws, Rp, Rs)
///This function computes the minimum filter order of a Butterworth filter with the desired response characteristics. 
//Calling Sequence
//n = buttord(Wp, Ws, Rp, Rs)
//[n, Wc] = buttord(Wp, Ws, Rp, Rs)
//Parameters 
//Wp: scalar or vector of length 2
//Ws: scalar or vector of length 2, elements must be in the range [0,1]
//Rp: real or complex value
//Rs: real or complex value
//Description
//This is an Octave function.
//This function computes the minimum filter order of a Butterworth filter with the desired response characteristics. 
//The filter frequency band edges are specified by the passband frequency wp and stopband frequency ws.
//Frequencies are normalized to the Nyquist frequency in the range [0,1]. 
//Rp is measured in decibels and is the allowable passband ripple, and Rs is also in decibels and is the minimum attenuation in the stop band.
//If ws>wp, the filter is a low pass filter. If wp>ws, the filter is a high pass filter.
//If wp and ws are vectors of length 2, then the passband interval is defined by wp the stopband interval is defined by ws. 
//If wp is contained within the lower and upper limits of ws, the filter is a band-pass filter. If ws is contained within the lower and upper limits of wp the filter is a band-stop or band-reject filter.
//Examples
//Wp = 40/500
//Ws = 150/500
//[n, Wn] = buttord(Wp, Ws, 3, 60)
//n =  5
//Wn =  0.080038

rhs = argn(2)
lhs = argn(1)
if(rhs~=4)
error("Wrong number of input arguments.")
end

	select(lhs)
	case 1 then
	n = callOctave(Wp,Ws,Rp,Rs)
	case 2 then
	[n,Wc] = callOctave(Wp,Ws,Rp,Rs)
	end
endfunction
