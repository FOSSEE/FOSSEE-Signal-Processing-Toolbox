function y = dst1(x, varargin)
//Computes the type I discrete sine transform of x
//Calling Sequence
//y= dst1(x)
//y= dst1(x,n)
//Parameters 
//x: real or complex valued vector
//n= Length to which x is trimmed before transform 
//Description
//This is an Octave function.
//Computes the type I discrete sine transform of x. If n is given, then x is padded or trimmed to length n before computing the transform. If x is a matrix, compute the transform along the columns of the the matrix.
funcprot(0);

lhs= argn(1);
rhs= argn(2);

if(rhs>2)
error("Wrong number of input arguments");
end

select(rhs)
	case 1 then
		y = callOctave("dst", x);
	case 2 then
		y = callOctave("dst", x, varargin(1));
end
endfunction

