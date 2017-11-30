function Y = unwrap2 (X, TOL, DIM)
//Unwrap radian phases by adding or subtracting multiples of 2*pi.
//Calling Sequence
//B = unwrap(X)
//B = unwrap(X, TOL)
//B = unwrap(X, TOL, DIM)
//Parameters
//Description
//This function unwraps radian phases by adding or subtracting multiples of 2*pi as appropriate to remove jumps greater than TOL.
//
//    TOL defaults to pi.
//
//Unwrap will work along the dimension DIM.  If DIM is unspecified it defaults to the first non-singleton dimension.
//Examples
//unwrap2([1,2,3])
//ans = 
//        1.    2.    3.  
funcprot(0);
lhs = argn(1);
rhs = argn(2);
if (rhs < 1 | rhs > 3)
error("Wrong number of input arguments.");
end

select(rhs)
	
	case 1 then
        Y = callOctave("unwrap",X);
	case 2 then
	Y = callOctave("unwrap",X,TOL);
        case 3 then
        Y = callOctave("unwrap",X,TOL,DIM);  
        end

endfunction
