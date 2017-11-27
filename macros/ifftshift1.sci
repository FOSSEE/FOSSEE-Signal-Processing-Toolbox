function y= ifftshift1(X,DIM)
	rhs= argn(2);
	if(rhs <1 | rhs >2)
		error('Wrong number of Input arguments');
	end
	select(rhs)
	case 1 then
		y=callOctave("ifftshift",X);
	case 2 then
		y=callOctave("ifftshift",X,DIM);
	end
endfunction