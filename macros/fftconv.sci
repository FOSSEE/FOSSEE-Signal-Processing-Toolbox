function y = fftconv(X, Y, varargin)

funcprot(0);
rhs = argn(2)
if(rhs<2 | rhs>3)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 2 then
	y = callOctave("fftconv", X, Y);
	case 3 then
	y = callOctave("ifftn",X, Y, varargin(1));
	end
endfunction
