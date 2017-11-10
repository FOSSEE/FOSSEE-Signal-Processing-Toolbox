function y = cceps (x,correct)

funcprot(0);
//
rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end

	select(rhs)
	case 1 then
	y = callOctave("cceps",x)
	case 2 then
	y = callOctave("cceps",x,correct)
	end
endfunction
