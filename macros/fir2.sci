function B = fir2(N, F, M, varargin)
//Produce an order N FIR filter with arbitrary frequency response M over frequency bands F, returning the N+1 filter coefficients in B.
//Calling Sequence
//B = fir2(N, F, M)
//B = fir2(N, F, M, GRID_N)
//B = fir1(N, F, M, GRID_N, RAMP_N)
//B = fir1(N, F, M, GRID_N, RAMP_N, WINDOW)
//Parameters
//N: Integer
//F, M: Vector
//Description
//Produce an order N FIR filter with arbitrary frequency response M over frequency bands F, returning the N+1 filter coefficients in B. The vector F specifies the frequency band edges of the filter response and M specifies the magnitude response at each frequency.
//
//The vector F must be nondecreasing over the range [0,1], and the first and last elements must be 0 and 1, respectively. A discontinuous jump in the frequency response can be specified by duplicating a band edge in F with different values in M.
//
//The resolution over which the frequency response is evaluated can be controlled with the GRID_N argument. The default is 512 or the next larger power of 2 greater than the filter length.
//
//The band transition width for discontinuities can be controlled with the RAMP_N argument. The default is GRID_N/25. Larger values will result in wider band transitions but better stopband rejection.
//
//An optional shaping WINDOW can be given as a vector with length N+1. If not specified, a Hamming window of length N+1 is used.
//Examples
// fir2 (10, [0, 0.5, 1], [1, 2, 3])
//ans = 
//     -0.00130   0.00000  -0.01792   0.00000  -0.36968   2.00000  -0.36968   0.00000  -0.01792   0.00000  -0.00130 
funcprot(0);
rhs = argn(2);
if(rhs<3 | rhs>6)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 3 then
	B = callOctave("fir2", N, F, M);
        case 4 then
        B = callOctave("fir2", N, F, M, varargin(1));
        case 5 then
        B = callOctave("fir2", N, F, M, varargin(1), varargin(2));
        case 6 then
        B = callOctave("fir2", N, F, M, varargin(1), varargin(2), varargin(3));
	end
endfunction
