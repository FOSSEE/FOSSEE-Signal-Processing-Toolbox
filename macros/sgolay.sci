function F = sgolay (p, n, m, ts)
//This function computes the filter coefficients for all Savitzsky-Golay smoothing filters. 
//Calling Sequence
//F = sgolay (p, n)
//F = sgolay (p, n, m)
//F = sgolay (p, n, m, ts)
//Parameters 
//p: polynomial 
//n: odd integer value, larger than polynomial p
//m: positive integer less than 2^31 or logical
//ts: real or complex value
//Description
//This is an Octave function.
//This function computes the filter coefficients for all Savitzsky-Golay smoothing filters of order p for length n (odd). 
//m can be used in order to get directly the mth derivative; ts is a scaling factor.
//Examples
//y = sgolay(1,3,0)
//y =
//   0.83333   0.33333  -0.16667
//   0.33333   0.33333   0.33333
//  -0.16667   0.33333   0.83333

funcprot(0);
rhs = argn(2)

if(rhs<2 | rhs>4)
error("Wrong number of input arguments.")
end

	select(rhs)
	case 2 then
	F = callOctave("sgolay",p,n)
	case 3 then
	F = callOctave("sgolay",p,n,m)
	case 4 then
	F = callOctave("sgolay",p,n,m,ts)
	end
endfunction


