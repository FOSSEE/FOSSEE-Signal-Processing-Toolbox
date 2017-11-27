function B = fir2(N, F, M, varargin)

funcprot(0);
rhs = argn(2)
if(rhs<3 | rhs>6)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 3 then
	B = callOctave("fir2", N, F, M);
    case 4 then
    B = callOctave("fir2", N, F, M, varargin(1));
    case 5 then
    B = callOctave("fir2", N, F, M, varargin(1), varargin(2));
    case 6 then
    B = callOctave("fir2", N, F, M, varargin(1), varargin(2), varargin(3));
	end
endfunction
