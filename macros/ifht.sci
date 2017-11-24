function m = ifht(d, varargin)
//Calculate the inverse Fast Hartley Transform of real input D
//Calling Sequence
//m= ifht (d)
//m= ifht (d,n)
//m= ifht (d,n,dim)
//Parameters 
//d: real or complex valued scalar or vector
//n: Similar to the options of FFT function
//dim: Similar to the options of FFT function 
//Description
//Calculate the inverse Fast Hartley Transform of real input d. If d is a matrix, the inverse Hartley transform is calculated along the columns by default. The options n and dim are similar to the options of FFT function.
//
//The forward and inverse Hartley transforms are the same (except for a scale factor of 1/N for the inverse hartley transform), but implemented using different functions.
//
//The definition of the forward hartley transform for vector d, m[K] = 1/N \sum_{i=0}^{N-1} d[i]*(cos[K*2*pi*i/N] + sin[K*2*pi*i/N]), for 0 <= K < N. m[K] = 1/N \sum_{i=0}^{N-1} d[i]*CAS[K*i], for 0 <= K < N.
//Examples
//ifht(1 : 4)
//ifht(1:4, 2)
funcprot(0);
rhs= argn(2);
if(rhs<1 | rhs>3)
error("Wrong number of Inputs")
end

select(rhs)
	case 1 then 
		m= callOctave("ifht", d);
	case 2 then
		m= callOctave("ifht", d , varargin(1));
	case 3 then 
		m= callOctave("ifht", d , varargin(1),varargin(2) );
end
endfunction
