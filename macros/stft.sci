function [y,c]= stft(x, varargin)

funcprot(0);
lhs= argn(1);
rhs= argn(2);

if(rhs <1 | rhs>5)
	error("Wrong number of input arguments");
end

if(lhs<1 | lhs>2)
	error("Wrong number of output arguments");
end

select(rhs)
	case 1 then
		select(lhs)
			case 1 then
				y= callOctave("stft", x);
			case 2 then
				[y,c]= callOctave("stft", x);
		end
	case 2 then
		select(lhs)
			case 1 then
				y= callOctave("stft", x,varargin(1));
			case 2 then
				[y,c]= callOctave("stft", x, varargin(1));
		end
	case 3 then
		select(lhs)
			case 1 then
				y= callOctave("stft", x,varargin(1), varargin(2));
			case 2 then
				[y,c]= callOctave("stft", x,varargin(1), varargin(2));
		end
	case 4 then
		select(lhs)
			case 1 then
				y= callOctave("stft", x,varargin(1), varargin(2), varargin(3));
			case 2 then
				[y,c]= callOctave("stft", x,varargin(1), varargin(2), varargin(3));
		end
	case 5 then
		select(lhs)
			case 1 then
				y= callOctave("stft", x,varargin(1), varargin(2), varargin(3), varargin(4));
			case 2 then
				[y,c]= callOctave("stft", x,varargin(1), varargin(2), varargin(3), varargin(4));
		end
end
endfunction


