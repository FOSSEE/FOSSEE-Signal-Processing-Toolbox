function [y]= diric(x,n)
// Calculates the dirichlet function
//
// Syntax
//   y = diric(x, n)
//
// Parameters
// x: Real valued vector or matrix
// n: Real positive integer or complex integer
// y: Dirichlet function values.
//
// Description
// This function computes the Dirichlet function values for the input array `x` and number of harmonics `n`.
//
// Examples
// y = diric([0, %pi/2, %pi], 5)
//

funcprot(0);
rhs=argn(2);
if (argn(2)~=2) then
	error ("Wrong number of input arguments.")
elseif (n <= 0 | ceil(n) ~= n) then
          error("n must be an positive integer.");
          
   else       
    y = sin(n.*x./2)./(n.*sin(x./2));
  y(pmodulo(x,2*%pi)==0) = (-1).^((n-1).*x(pmodulo(x,2*%pi)==0)./(2.*%pi));
end

endfunction
