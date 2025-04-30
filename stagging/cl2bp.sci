function h = cl2bp(m, w1, w2, up, lo, gridsize)
// Design a constrained L2 bandpass FIR filter.
//
// Syntax
//   h = cl2bp(m, w1, w2, up, lo, gridsize)
//   h = cl2bp(m, w1, w2, up, lo)
//
// Parameters
// m: Integer. Degree of the cosine polynomial. The number of output coefficients will be `m*2+1`.
// w1, w2: Real scalars. Bandpass filter cutoffs in the range `0 <= w1 < w2 <= pi`, where `pi` is the Nyquist frequency.
// up: Vector. Upper bounds for [stopband1, passband, stopband2].
// lo: Vector. Lower bounds for [stopband1, passband, stopband2].
// gridsize: Integer. Search grid size. Larger values may improve accuracy but increase calculation time.
// h: Vector. Filter coefficients.
//
// Description
// This function designs a constrained L2 bandpass FIR filter. Compared to `remez`, it offers implicit specification of transition bands, a higher likelihood of convergence, and an error criterion combining features of both L2 and Chebyshev approaches.
//
// Examples
// h = cl2bp(5, 0.3*%pi, 0.6*%pi, [0.02, 1.02, 0.02], [-0.02, 0.98, -0.02], 2^11)
// Output:
// h =
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
