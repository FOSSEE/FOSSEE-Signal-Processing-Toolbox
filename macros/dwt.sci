function [U, V] = dwt(X, varargin)

funcprot(0);
rhs = argn(2)
if(rhs<2 | rhs>4)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 2 then
	[U, V] = callOctave("dwt", X, varargin(1));
    case 3 then
    [U, V] = callOctave("dwt", X, varargin(1), varargin(2));
    case 4 then
    [U, V] = callOctave("dwt", X, varargin(1), varargin(2), varargin(3));
	end
endfunction
