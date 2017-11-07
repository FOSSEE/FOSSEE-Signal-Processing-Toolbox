function [y] = zplane(z,p)
funcprot(0);

rhs = argn(2)

if(rhs<1 | rhs>2)
error("Wrong number of input arguments.")
end
	select(rhs)
	case 1 then
	callOctave("zplane",z)
	case 2 then
	callOctave("zplane",z,p)
	end
endfunction

