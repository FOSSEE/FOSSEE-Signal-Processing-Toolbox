function m = ifht(d, varargin)
funcprot(0);
rhs= argn(2);
if(rhs<1 | rhs>3)
error("Wrong number of Inputs")
end

select(rhs)
	case 1 then 
		m= callOctave("ifht", d);
	case 2 then
		m= callOctave("ifht", d , varargin(1));
	case 3 then 
		m= callOctave("ifht", d , varargin(1),varargin(2) );
end
endfunction
