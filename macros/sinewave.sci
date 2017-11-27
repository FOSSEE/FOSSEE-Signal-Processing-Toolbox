function y= sinewave(x, varargin)
//Return an M-element vector with I-th element given by 'sin(2* pi *(I+D-1)/N).'
//Calling Sequence
//y= sinewave(M)
//y= sinewave(M,N)
//y= sinewave(M,N,D)
//Parameters 
//M: Input vector
//N: The default value for N is M
//D: The default value for D is 0 
//AMPL: Amplitude
//Description
//Return an M-element vector with I-th element given by 'sin(2* pi *(I+D-1)/N).'
funcprot(0);
rhs= argn(2);
if(rhs<1 | rhs>3)
error("Wrong number of input arguments")
end

select(rhs)
	case 1 then
		y= callOctave("sinewave", x);
	case 2 then
		y= callOctave("sinewave", x , varargin(1));
	case 3 then
		y= callOctave("sinewave", x , varargin(1), varargin(2));

end
endfunction
