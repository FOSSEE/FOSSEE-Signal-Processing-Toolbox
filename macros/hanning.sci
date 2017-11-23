function y = hanning(m, varargin)

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
