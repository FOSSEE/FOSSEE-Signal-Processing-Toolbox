function y = dst1(x, varargin)

funcprot(0);

lhs= argn(1);
rhs= argn(2);

if(rhs>2)
error("Wrong number of input arguments");
end

select(rhs)
	case 1 then
		y = callOctave("dst", x);
	case 2 then
		y = callOctave("dst", x, varargin(1));
end
endfunction

