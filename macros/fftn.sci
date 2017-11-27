function y = fftn(A, SIZE)

funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>2)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 1 then
	y = callOctave("fftn",A);
	case 2 then
	y = callOctave("fftn",A, SIZE);
	end
endfunction
