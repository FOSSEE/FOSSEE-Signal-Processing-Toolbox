function y = detrend1(x, varargin)
//This function removes the best fit of a polynomial of order P from the data X
//Calling Sequence
//detrend1(X,P)
//Parameters 
//X: Input vecor or matrix.
//P: The order of polnomial
//Description
//If X is a vector, 'detrend1(X, P)' removes the best fit of apolynomial of order P from the data X.If X is a matrix, 'detrend1(X, P)' does the same for each column in X.
//
//The second argument P is optional.  If it is not specified, a value of 1 is assumed.  This corresponds to removing a linear trend.
//The order of the polynomial can also be given as a string, in which case P must be either "constant" (corresponds to 'P=0') or "linear"(corresponds to 'P=1')
	rhs= argn(2);
	if(rhs<1 | rhs> 2)
		error("Wrong number of input arguments");
	end
	select(rhs)
	case 1 then
		y= callOctave("detrend", x);
	case 2 then
		y= callOctave("detrend", x , varargin(1));
	end
endfunction
