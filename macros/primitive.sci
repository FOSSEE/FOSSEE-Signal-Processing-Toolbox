function y = primitive (f, t, x)
//This function calculates the primitive of a given function supplied as input.
//Calling Sequence
//y = primitive(f, t)
//y = primitive(f, t, x)
//Parameters 
//f:
//t:
//x
//Description
//This is an Octave function.
//This function calculates the primitive of a given function supplied as input.
//The second parameter t is a vector at which the output is evaluated (at the points t). This vector should be ascending and ordered. 
//The function approximates the primitive (indefinite integral) of the univariate function handle f with constant of integration x.
//Examples
//primitive([1,4,5],3,9)
//ans  =
//    9.  

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

