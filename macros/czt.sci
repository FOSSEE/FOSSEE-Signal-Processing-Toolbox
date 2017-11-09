function y = czt(x, varargin)

funcprot(0);
lhs= argn(1);
rhs= argn(2);

if(rhs<1 | rhs > 4)
error("Wrong number of input arguments")
end

select (rhs)
	case 1 then
		y= callOctave("czt", x);
	case 2 then
		y= callOctave("czt", x, varargin(1));
	case 3 then
		y= callOctave("czt", x, varargin(1), varargin(2));
	case 4 then
		y= callOctave("czt", x, varargin(1), varargin(2), varargin(3));
end
endfunction

