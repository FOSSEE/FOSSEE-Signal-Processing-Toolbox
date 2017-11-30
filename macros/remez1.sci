function b = remez1(n,f,a, varargin)
//Parks-McClellan optimal FIR filter design
//Calling Sequence
//b = remez1 (n, f, a)
//b = remez1 (n, f, a, w)
//b = remez1 (n, f, a, w, ftype)
//b = remez1 (n, f, a, w, ftype, griddensity)
//Parameters 
//n: gives the number of taps in the returned filter
//f:gives frequency at the band edges [b1 e1 b2 e2 b3 e3 …]
//a:gives amplitude at the band edges [a(b1) a(e1) a(b2) a(e2) …]
//w:gives weighting applied to each band
//ftype:is "bandpass", "hilbert" or "differentiator"
//griddensity:determines how accurately the filter will be constructed. The minimum value is 16, but higher numbers are slower to compute.
//Description
// Frequency is in the range (0, 1), with 1 being the Nyquist frequency.

funcprot(0);
rhs= argn(2);

if(rhs<3 | rhs>6)
error("Wrong number of input arguments");
end

select(rhs)

	case 3 then
		b= callOctave("remez", n,f,a);
	case 4 then
		b= callOctave("remez", n,f,a,varargin(1));
	case 5 then
		b= callOctave("remez", n,f,a,varargin(1), varargin(2));
	case 6 then
		b= callOctave("remez", n,f,a,varargin(1), varargin(2), varargin(3));
end
endfunction
