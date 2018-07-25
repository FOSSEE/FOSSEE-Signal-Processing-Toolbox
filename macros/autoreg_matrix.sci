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



//function y = autoreg_matrix(Y, varargin)
//funcprot(0);
//rhs = argn(2)
//if(rhs<2 | rhs>2)
//error("Wrong number of input arguments.");
//end
//
//	select(rhs)
//	case 2 then
//	y = callOctave("autoreg_matrix", Y, varargin(1));
//	end
//endfunction

function X = autoreg_matrix (y, k)

  funcprot(0);
  [nargout, nargin] = argn() ;

  if (nargin ~= 2)
    error('autoreg_matrix: invalid input') ;
  end

  if (~ (isvector (y)))
    error ("autoreg_matrix: Y must be a vector");
  end

  T = length (y);
  y = matrix(y, T, 1);
  X = ones (T, k+1);
  for j = 1 : k;
    X(:, j+1) = [(zeros (j, 1)); y(1:T-j)];
  end

endfunction
