function y = autoreg_matrix(Y, varargin)
// Given a time series (vector) Y, return a matrix with ones in the first column and the first K lagged values of Y in the other columns.
//Calling Sequence
//autoreg_matrix(Y, K)
//Parameters
//Y: Vector
//K: Scalar or Vector
//Description
// Given a time series (vector) Y, return a matrix with ones in the first column and the first K lagged values of Y in the other columns.
//
//In other words, for T > K, '[1, Y(T-1), ..., Y(T-K)]' is the t-th row of the result.
//
//The resulting matrix may be used as a regressor matrix in autoregressions.
//Examples
//autoreg_matrix([1,2,3],2)
//ans = 
//      1.    0.    0.  
//      1.    1.    0.  
//      1.    2.    1.   
funcprot(0);
rhs = argn(2)
if(rhs<2 | rhs>2)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 2 then
	y = callOctave("autoreg_matrix", Y, varargin(1));
	end
endfunction
