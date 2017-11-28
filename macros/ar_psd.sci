function [P, F]= ar_psd(A, varargin)
	funcprot(0);
	rhs= argn(2);
	if(rhs <2 | rhs>5)
		error("Wrong number of input arguments");
	end
	select(rhs)
	case 2 then
		[P,F]= callOctave("ar_psd", A, varargin(1));
	case 3 then
		[P,F]= callOctave("ar_psd", A, varargin(1), varargin(2));
	case 4 then
		[P,F]= callOctave("ar_psd", A, varargin(1), varargin(2), varargin(3));
	case 5 then
		[P,F]= callOctave("ar_psd", A, varargin(1), varargin(2), varargin(3), varargin(4));
	end
endfunction
