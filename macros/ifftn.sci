function y = ifftn(A, varargin)

funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 1 then
	y = callOctave("ifftn",A);
	case 2 then
	y = callOctave("ifftn",A, varargin(1));
	end
endfunction
