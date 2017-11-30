function [n, Wn, beta, ftype] = kaiserord (f, m, dev, fs)
//Return the parameters needed to produce a filter of the desired specification from a Kaiser window.
//Calling Sequence
//[n, Wn, beta, ftype] = kaiserord (f, m, dev, fs)
//[…] = kaiserord (f, m, dev, fs)
//[…] = kaiserord (f, m, dev)
//Parameters
//f: Pairs of frequency band edges.
//m: Magnitude response for each band.
//dev: Deviation of the filter.
//fs: Sampling rate.
//Description
//This is an Octave function.
//The vector f contains pairs of frequency band edges in the range [0,1]. The vector m specifies the magnitude response for each band. The values of m must be zero for all stop bands and must have the
//same magnitude for all pass bands. The deviation of the filter dev can be specified as a scalar or a vector of the same length as m. The optional sampling rate fs can be used to indicate that f is in
//Hz in the range [0,fs/2].
//
//The returned value n is the required order of the filter (the length of the filter minus 1). The vector Wn contains the band edges of the filter suitable for passing to fir1. The value beta is the
//parameter of the Kaiser window of length n+1 to shape the filter. The string ftype contains the type of filter to specify to fir1.
//
//The Kaiser window parameters n and beta are computed from the relation between ripple (A=-20*log10(dev)) and transition width (dw in radians) discovered empirically by Kaiser:
//
// 
//           / 0.1102(A-8.7)                        A > 50
//    beta = | 0.5842(A-21)^0.4 + 0.07886(A-21)     21 <= A <= 50
//           \ 0.0                                  A < 21
//
//    n = (A-8)/(2.285 dw)
//Examples
//[n, w, beta, ftype] = kaiserord ([1000, 1200], [1, 0], [0.05, 0.05], 11025)
//n =  1
//w =  1100
//beta =  1.5099
//ftype = low

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 3 | rhs > 4)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 3 then
		if(lhs==1)
		n = callOctave("kaiserord",f, m, dev)
		elseif(lhs==2)
		[n, Wn] = callOctave("kaiserord",f, m, dev)
		elseif(lhs==3)
		[n, Wn, beta] = callOctave("kaiserord",f, m, dev)
		elseif(lhs==4)
		[n, Wn, beta, ftype] = callOctave("kaiserord",f, m, dev)
		else
		error("Wrong number of output argments.")
	       	end
	case 4 then
		if(lhs==1)
		n = callOctave("kaiserord",f, m, dev, fs)
		elseif(lhs==2)
		[n, Wn] = callOctave("kaiserord",f, m, dev, fs)
		elseif(lhs==3)
		[n, Wn, beta] = callOctave("kaiserord",f, m, dev, fs)
		elseif(lhs==4)
		[n, Wn, beta, ftype] = callOctave("kaiserord",f, m, dev, fs)
		else
		error("Wrong number of output argments.")
	       	end
	end
endfunction
