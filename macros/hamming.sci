function y = hamming(m, varargin)
funcprot(0);
rhs= argn(2);
if(rhs <1 | rhs>2)
error("Wrong number of Input parameters");
end

select(rhs)
	case 1 then
		y= callOctave("hamming", m);
	case 2 then
		y= callOctave("hamming", m , varargin(1));
end
endfunction
