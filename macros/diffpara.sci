function [D,DD] = diffpara(X,varargin)
	lhs= argn(1);
	rhs= argn(2);
	if(rhs <1 | rhs> 3)
		error("Wrong number of input parameters");
	end
	if(lhs<1 | lhs>2)
		error("Wrong number of output parameters");
	end
	select(rhs)
	case 1 then
		select(lhs)
		case 1 then
			D= diffpara(X);
		case 2 then 
			[D, DD]= diffpara(X);
		end
	case 2 then
		select(lhs)
		case 1 then
			D= diffpara(X, varargin(1));
		case 2 then 
			[D, DD]= diffpara(X, varargin(1));
		end
	case 3 then
		select(lhs)
		case 1 then
			D= diffpara(X, varargin(1), varargin(2));
		case 2 then 
			[D, DD]= diffpara(X, varargin(1), varargin(2));
		end
	end
endfunction
