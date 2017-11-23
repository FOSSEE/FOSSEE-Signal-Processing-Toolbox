function y = hurst(x)

funcprot(0);
rhs= argn(2);
if(rhs<1 | rhs>1)
	error("Wrong number of input arguments");
end

select(rhs)
	case 1 then
		y= callOctave("hurst", x);
end
endfunction
