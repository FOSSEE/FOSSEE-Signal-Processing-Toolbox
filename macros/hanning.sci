function y = hanning(m, varargin)
//Return the filter coefficients of a Hanning window of length M
//Calling Sequence
//hanning (M)
//hanning (M, "periodic")
//hanning (M, "symmetric")
//Parameters 
//M: real scalar, which will be the length of hanning window
//Description
//Return the filter coefficients of a Hanning window of length M.
//If the optional argument "periodic" is given, the periodic form of the window is returned.  This is equivalent to the window of length M+1 with the last coefficient removed.  The optional argument "symmetric" is equivalent to not specifying a second argument.	

funcprot(0);
rhs= argn(2);
if(rhs <1 | rhs>2)
error("Wrong number of Input parameters");
end

select(rhs)
	case 1 then
		y= callOctave("hanning", m);
	case 2 then
		y= callOctave("hanning", m , varargin(1));
end
endfunction
