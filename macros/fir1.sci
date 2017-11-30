function B = fir1(N, W, varargin)
//Produce an order N FIR filter with the given frequency cutoff, returning the N+1 filter coefficients in B.
//Calling Sequence
//B = fir1(N, W)
//B = fir1(N, W, TYPE)
//B = fir1(N, W, TYPE, WINDOW)
//B = fir1(N, W, TYPE, WINDOW, NOSCALE)
//Parameters
//N: Integer
//W: Integer or Vector
//Description
// Produce an order N FIR filter with the given frequency cutoff W, returning the N+1 filter coefficients in B. If W is a scalar, it specifies the frequency cutoff for a lowpass or highpass filter. If W is a two-element vector, the two values specify the edges of a bandpass or bandstop filter. If W is an N-element vector, each value specifies a band edge of a multiband pass/stop filter.
//
//The filter TYPE can be specified with one of the following strings: "low", "high", "stop", "pass", "bandpass", "DC-0", or "DC-1". The default is "low" is W is a scalar, "pass" if W is a pair, or "DC-0" if W is a vector with more than 2 elements.
//
//An optional shaping WINDOW can be given as a vector with length N+1. If not specified, a Hamming window of length N+1 is used.
//
//With the option "noscale", the filter coefficients are not normalized. The default is to normalize the filter such that the magnitude response of the center of the first passband is 1.
//Examples
// fir1 (5, 0.4)
//ans = 
//        9.2762e-05   9.5482e-02   4.0443e-01   4.0443e-01   9.5482e-02   9.2762e-05 
funcprot(0);
rhs = argn(2);
if(rhs<2 | rhs>5)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 2 then
	B = callOctave("fir1", N, W);
        case 3 then
        B = callOctave("fir1", N, W, varargin(1));
        case 4 then
        B = callOctave("fir1", N, W, varargin(1), varargin(2));
        case 5 then
        B = callOctave("fir1", N, W, varargin(1), varargin(2), varargin(3));
	end
endfunction
