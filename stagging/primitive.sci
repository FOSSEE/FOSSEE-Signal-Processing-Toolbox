function y = primitive (f, t, x)
// Compute the primitive (indefinite integral) of a given function.
//
// Syntax
//   y = primitive(f, t)
//   y = primitive(f, t, x)
//
// Parameters
// f: Function handle or vector. The input function whose primitive is to be calculated.
// t: Vector. Points at which the output is evaluated. The vector should be ascending and ordered.
// x: (optional) Scalar. Constant of integration.
//
// Description
// The `primitive` function calculates the primitive (indefinite integral) of a given function `f`. 
// The second parameter `t` specifies the points at which the output is evaluated. If the optional 
// parameter `x` is provided, it is used as the constant of integration.
//
// Examples
// // Compute the primitive of a function:
//    y = primitive([1, 4, 5], 3, 9)
//    

funcprot(0);
rhs = argn(2)
if(rhs<2 | rhs>3)
error("Wrong number of input arguments.")
end
	select(rhs)
	case 2 then
	y = callOctave("primitive",f, t)
	case 3 then
	y = callOctave("primitive",f, t, x)
	end
endfunction

