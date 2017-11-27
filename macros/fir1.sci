function B = fir1(N, W, varargin)

funcprot(0);
rhs = argn(2)
if(rhs<2 | rhs>5)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 2 then
	B = callOctave("fir1", N, W);
    case 3 then
    B = callOctave("fir1", N, W, varargin(1));
    case 4 then
    B = callOctave("fir1", N, W, varargin(1), varargin(2));
    case 5 then
    B = callOctave("fir1", N, W, varargin(1), varargin(2), varargin(3));
	end
endfunction
