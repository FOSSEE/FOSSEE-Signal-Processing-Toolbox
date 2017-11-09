function h= hilbert1(f, varargin)

funcprot(0);
rhs= argn(2);
if(rhs<1 | rhs>3)
	error("Wrong number of Input Arguments")
end

select(rhs)
	case 1 then
		h= callOctave("hilbert", f);
	case 2 then
		h= callOctave("hilbert", f, varargin(1));
	case 3 then
		h= callOctave("hilbert", f, varargin(1), varargin(2));
end
endfunction
