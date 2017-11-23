function y= spectral_xdf(x, varargin)

funcprot(0);
rhs= argn(2);
if(rhs<1 | rhs>3)
error("Wrong number of input arguments")
end

select(rhs)
	case 1 then
		y= callOctave("spectral_xdf", x);
	case 2 then
		y= callOctave("spectral_xdf", x , varargin(1));
	case 3 then
		y= callOctave("spectral_xdf", x , varargin(1), varargin(2));

end
endfunction
