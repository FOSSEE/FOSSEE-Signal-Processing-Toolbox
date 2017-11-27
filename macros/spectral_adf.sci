function y= spectral_adf(x, varargin)
// Return the spectral density estimator given a vector of autocovariances C, window name WIN, and bandwidth, B.
//Calling Sequence
//spectral_adf(C)
//spectral_adf(C, WIN)
//spectral_adf(C, WIN, B)
//Parameters 
//C: Autocovariances
//WIN: Window names
//B: Bandwidth 
//Description
//Return the spectral density estimator given a vector ofautocovariances C, window name WIN, and bandwidth, B.
//The window name, e.g., "triangle" or "rectangle" is used to search for a function called 'WIN_lw'.
//If WIN is omitted, the triangle window is used.
//If B is omitted, '1 / sqrt (length (C))' is used.

   
funcprot(0);
rhs= argn(2);
if(rhs<1 | rhs>3)
error("Wrong number of input arguments")
end

select(rhs)
	case 1 then
		y= callOctave("spectral_adf", x);
	case 2 then
		y= callOctave("spectral_adf", x , varargin(1));
	case 3 then
		y= callOctave("spectral_adf", x , varargin(1), varargin(2));

end
endfunction
