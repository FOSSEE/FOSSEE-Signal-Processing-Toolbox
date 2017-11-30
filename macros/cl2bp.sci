function h = cl2bp (m, w1, w2, up, lo, gridsize)
//Constrained L2 bandpass FIR filter design.
//Calling Sequence
//h = cl2bp (m, w1, w2, up, lo, gridsize)
//h = cl2bp (m, w1, w2, up, lo)
//Parameters 
//m: degree of cosine polynomial, i.e. the number of output coefficients will be m*2+1
//w1 and w2: bandpass filter cutoffs in the range 0 <= w1 < w2 <= pi, where pi is the Nyquist frequency
//up: vector of 3 upper bounds for [stopband1, passband, stopband2]
//lo: vector of 3 lower bounds for [stopband1, passband, stopband2]
//gridsize: search grid size; larger values may improve accuracy, but greatly increase calculation time.
//Description
//This is an Octave function.
//Constrained L2 bandpass FIR filter design. Compared to remez, it offers implicit specification of transition bands, a higher likelihood of convergence, and an error criterion combining features of both L2 and Chebyshev approaches.
//Examples
//h = cl2bp(5, 0.3*pi, 0.6*pi, [0.02, 1.02, 0.02], [-0.02, 0.98, -0.02], 2^11)
//h =
//
//   0.038311
//   0.082289
//  -0.086163
//  -0.226006
//   0.047851
//   0.307434
//   0.047851
//  -0.226006
//  -0.086163
//   0.082289
//   0.038311

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 5 | rhs > 6)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 5 then
	res = callOctave("cl2bp", m, w1, w2, up, lo)

	case 6 then
	res = callOctave("cl2bp", m, w1, w2, up, lo, gridsize)

	end
endfunction
