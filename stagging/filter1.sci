function [Y, SF] = filter1 (B, A, X, SI, DIM)
// Short description on the first line following the function header.
//
// Syntax
//   y = filter1(b, a, x)
//
// Parameters
// b: Numerator coefficients of the filter.
// a: Denominator coefficients of the filter.
// x: Input signal.
// y: Filtered signal.
//
// Description
// This function applies a digital filter to the input signal `x` using the coefficients `b` and `a`.
//
// Examples
// y = filter1([1, -1], [1, 0.5], [1, 2, 3, 4])
//
// See also
//  filtfilt, filter
//
// Authors
//  Author name ; should be listed one pr line. Use ";" to separate names from additional information 
//
// Bibliography
//   Literature references one pr. line

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 3 | rhs > 5)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 3 then
		if(lhs==1)
		Y=callOctave("filter",B,A,X)
		elseif(lhs==2)
		[Y, SF] = callOctave("filter",B,A,X)
		else
		error("Wrong number of output arguments.")
		end
	case 4 then
		if(lhs==2)
		[Y, SF] = callOctave("filter",B,A,X,SI)
		else
		error("Wrong number of output arguments.")
	    end
	case 5 then
		if(lhs==2)
		[Y, SF] = callOctave("filter",B,A,X,SI,DIM)
		else
		error("Wrong number of output arguments.")
	    end
	
	end
endfunction
