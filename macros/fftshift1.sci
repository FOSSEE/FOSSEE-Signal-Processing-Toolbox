function y= fftshift1(X,DIM)
	rhs= argn(2);
	if(rhs <1 | rhs >2)
		error('Wrong number of Input arguments');
	end
	select(rhs)
	case 1 then
		y=callOctave("fftshift",X);
	case 2 then
		y=callOctave("fftshift",X,DIM);
	end
endfunction