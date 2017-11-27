function y = fwht(x, varargin)
//Compute the Walsh-Hadamard transform of x using the Fast Walsh-Hadamard Transform (FWHT) algorithm
//Calling Sequence
//fwht (x)
//fwht (x, n)
//fwht (x, n, order)
//Parameters 
//x: real or complex valued scalar or vector
//n: x is truncated or extended to have length n 
//order: Specification of order in which coefficients should be arranged 
//Description
//Compute the Walsh-Hadamard transform of x using the Fast Walsh-Hadamard Transform (FWHT) algorithm. If the input is a matrix, the FWHT is calculated along the columns of x.
//
//The number of elements of x must be a power of 2; if not, the input will be extended and filled with zeros. If a second argument is given, the input is truncated or extended to have length n.
//
//The third argument specifies the order in which the returned Walsh-Hadamard transform coefficients should be arranged. The order may be any of the following strings:
//
//"sequency"
//The coefficients are returned in sequency order. This is the default if order is not given.
//
//"hadamard"
//The coefficients are returned in Hadamard order.
//
//"dyadic"
//The coefficients are returned in Gray code order.

funcprot(0);
rhs= argn(2);

if(rhs<1 | rhs > 3)
error("Wrong number of input arguments");
end

select(rhs)
	case 1 then
		y= callOctave("fwht", x);
	case 2 then 
		y= callOctave("fwht",x, varagin(1));
	case 3 then
		y= callOctave("fwht",x, varargin(1), varargin(2));
end
endfunction


