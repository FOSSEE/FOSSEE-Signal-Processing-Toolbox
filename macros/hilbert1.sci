function h= hilbert1(f, varargin)
//Analytic extension of real valued signal.
//Calling Sequence
// h= hilbert1(f)
// h= hilbert1(f,N)
// h= hilbert1(f,N,dim)
//Parameters 
//f: real or complex valued scalar or vector
//N: The result will have length N
//dim : It analyses the input in this dimension
//Description
//h = hilbert1 (f) computes the extension of the real valued signal f to an analytic signal. If f is a matrix, the transformation is applied to each column. For N-D arrays, the transformation is applied to the first non-singleton dimension.
//
//real (h) contains the original signal f. imag (h) contains the Hilbert transform of f.
//
//hilbert1 (f, N) does the same using a length N Hilbert transform. The result will also have length N.
//
//hilbert1 (f, [], dim) or hilbert1 (f, N, dim) does the same along dimension dim.
//Examples
//## notice that the imaginary signal is phase-shifted 90 degrees
// t=linspace(0,10,256);
// z = hilbert1(sin(2*pi*0.5*t));
// grid on; plot(t,real(z),';real;',t,imag(z),';imag;');

funcprot(0);
rhs= argn(2);
if(rhs<1 | rhs>3)
	error("Wrong number of Input Arguments")
end

select(rhs)
	case 1 then
		h= callOctave("hilbert", f);
	case 2 then
		h= callOctave("hilbert", f, varargin(1));
	case 3 then
		h= callOctave("hilbert", f, varargin(1), varargin(2));
end
endfunction
