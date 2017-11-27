function y = autoreg_matrix(Y, varargin)

funcprot(0);
rhs = argn(2)
if(rhs<2 | rhs>2)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 2 then
	y = callOctave("autoreg_matrix", Y, varargin(1));
	end
endfunction
