function [Zb, Za, Zg]= bilinear(Sb,varargin)
	funcprot(0);
	lhs= argn(1);
	rhs= argn(2);
	if(rhs < 3 | rhs > 4)
		error("Wrong number of input arguments");
	end
	if(lhs < 2 | lhs > 3)
		error("Wrong number of output arguments");
	end
	select(rhs)
	case 3 then
		select(lhs)
		case 2 then
			[Zb, Za]= callOctave("bilinear", Sb, varargin(1), varargin(2));
		case 3 then
			[Zb, Za, Zg]= callOctave("bilinear", Sb, varargin(1), varargin(2));
		end
	case 4 then
		select(lhs)
		case 2 then
			[Zb, Za]= callOctave("bilinear", Sb, varargin(1), varargin(2), varargin(3));
		case 3 then
			[Zb, Za, Zg]= callOctave("bilinear", Sb, varargin(1), varargin(2), varargin(3));
		end
	end
endfunction		