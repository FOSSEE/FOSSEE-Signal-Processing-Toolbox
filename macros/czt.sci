function y = czt(x, varargin)
//Chirp Z Transform
//Calling Sequence
//czt (x)
//czt (x, m)
//czt (x, m, w)
//czt (x, m, w, a)
//Parameters 
//x: Input scalar or vector
//m: Total Number of steps
//w: ratio between points in each step
//a: point in the complex plane 
//Description
//This is an Octave function.
//Chirp z-transform. Compute the frequency response starting at a and stepping by w for m steps. a is a point in the complex plane, and w is the ratio between points in each step (i.e., radius increases exponentially, and angle increases linearly).
//Examples
// m = 32;                               ## number of points desired
// w = exp(-j*2*pi*(f2-f1)/((m-1)*Fs));  ## freq. step of f2-f1/m
// a = exp(j*2*pi*f1/Fs);                ## starting at frequency f1
// y = czt(x, m, w, a);

funcprot(0);
lhs= argn(1);
rhs= argn(2);

if(rhs<1 | rhs > 4)
error("Wrong number of input arguments")
end

select (rhs)
	case 1 then
		y= callOctave("czt", x);
	case 2 then
		y= callOctave("czt", x, varargin(1));
	case 3 then
		y= callOctave("czt", x, varargin(1), varargin(2));
	case 4 then
		y= callOctave("czt", x, varargin(1), varargin(2), varargin(3));
end
endfunction

