function b = remez1(n,f,a, varargin)

funcprot(0);
rhs= argn(2);

if(rhs<3 | rhs>6)
error("Wrong number of input arguments");
end

select(rhs)

	case 3 then
		b= callOctave("remez", n,f,a);
	case 4 then
		b= callOctave("remez", n,f,a,varargin(1));
	case 5 then
		b= callOctave("remez", n,f,a,varargin(1), varargin(2));
	case 6 then
		b= callOctave("remez", n,f,a,varargin(1), varargin(2), varargin(3));
end
endfunction
