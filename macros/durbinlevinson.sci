function y= durbinlevinson(C, varargin)
	rhs=argn(2);
	if(rhs<1 | rhs>3)
		error("Wrong number of input arguments");
	end
	select(rhs)
	case 1 then
		y=callOctave("durbinlevinson",C);
	case 2 then
		y=callOctave("durbinlevinson",C, varargin(1));
	case 3 then
		y=callOctave("durbinlevinson",C, varargin(1), varargin(2));
	end
endfunction