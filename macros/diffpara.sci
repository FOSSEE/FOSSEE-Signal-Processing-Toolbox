function [D,DD] = diffpara(X,varargin)
//Return the estimator D for the differencing parameter of an integrated time series
//Calling Sequence
// [D, DD] = diffpara (X)
// [D, DD] = diffpara (X, A)
// [D, DD] = diffpara (X, A, B)
//Parameters
//X: Input scalar or vector. 
//DD:The estimators for all frequencies in the intervals described above.
//D:The mean of DD 
//Description
//Return the estimator D for the differencing parameter of an integrated time series.
//
//The frequencies from [2*pi*a/t, 2*pi*b/T] are used for the estimation. If B is omitted, the interval [2*pi/T, 2*pi*a/T] is used.  If both B and A are omitted then a = 0.5 * sqrt (T) and b = 1.5 * sqrt (T) is used, where T is the sample size.  If X is a matrix, the differencing parameter of each column is estimated.
//
//The estimators for all frequencies in the intervals described above is returned in DD.
//
//The value of D is simply the mean of DD.
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
