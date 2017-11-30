function y= sinetone(x, varargin)
//Return a sinetone of the input
//Calling Sequence
//y= sinetone(FREQ)
//y= sinetone(FREQ, RATE)
//y= sinetone(FREQ, RATE, SEC)
//y= sinetone(FREQ, RATE, SEC, AMPL)
//Parameters 
//FREQ: frequency of sinetone
//RATE: Sampling rate
//SEC: Length in seconds
//AMPL: Amplitude
//Description
//Return a sinetone of frequency FREQ with a length of SEC seconds atsampling rate RATE and with amplitude AMPL.The arguments FREQ and AMPL may be vectors of common size.The defaults are RATE = 8000, SEC = 1, and AMPL = 64.
funcprot(0);
rhs= argn(2);
if(rhs<1 | rhs>4)
error("Wrong number of input arguments")
end

select(rhs)
	case 1 then
		y= callOctave("sinetone", x);
	case 2 then
		y= callOctave("sinetone", x , varargin(1));
	case 3 then
		y= callOctave("sinetone", x , varargin(1), varargin(2));
	case 4 then
		y= callOctave("sinetone", x , varargin(1), varargin(2), varargin(3));

end
endfunction
