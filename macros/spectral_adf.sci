function y= spectral_adf(x, varargin)

funcprot(0);
rhs= argn(2);
if(rhs<1 | rhs>3)
error("Wrong number of input arguments")
end

select(rhs)
	case 1 then
		y= callOctave("spectral_adf", x);
	case 2 then
		y= callOctave("spectral_adf", x , varargin(1));
	case 3 then
		y= callOctave("spectral_adf", x , varargin(1), varargin(2));

end
endfunction
