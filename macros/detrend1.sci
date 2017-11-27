function y = detrend1(x, varargin)
	rhs= argn(2);
	if(rhs<1 | rhs> 2)
		error("Wrong number of input arguments");
	end
	select(rhs)
	case 1 then
		y= callOctave("detrend", x);
	case 2 then
		y= callOctave("detrend", x , varargin(1));
	end
endfunction
