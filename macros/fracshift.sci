function  [y, h] = fracshift( x, d, h )
// This function shifts the series x supplied as input argument by a number of samples d.
//
// Syntax
//   y = fracshift(x, d)
//   y = fracshift(x, d, h)
//   [y, h] = fracshift(...)
//
// Parameters 
// x: Vector. The input series to be shifted.
// d: Scalar. The number of samples by which the input series `x` is shifted.
// h: Vector (optional). The interpolator used for shifting. If not supplied, a Kaiser-windowed sinc filter is used by default.
// y: Vector. The shifted series.
// h: Vector. The interpolator used for shifting.
//
// Description
// This function shifts the series `x` supplied as input argument by a number of samples `d`. 
// The third parameter is the interpolator, which is designed with a Kaiser-windowed sinc filter by default, if not supplied.
//
// Examples
// fracshift([1, 2, 3], 5)
// ans  =
//     1.    2.    3.  

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if(rhs<2 | rhs>3)
error("Wrong number of input arguments.")
end

	select(rhs)
	case 2 then
	if(lhs==1)
	y = callOctave("fracshift",x,d)
	elseif(lhs==2)
	[y,h] = callOctave("fracshift",x,d)
	end
	case 3 then
	if(lhs==1)
	[y] = callOctave("fracshift",x,d,h)
	elseif(lhs==2)
	[y,h] = callOctave("fracshift",x,d,h)
	end
	end
endfunction

