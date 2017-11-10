function y = wconv (type, x, f, shape)
//Performs 1D or 2D convolution.
//Calling Sequence
//y = wconv (type, x, f)
// y = wconv (type, x, f, shape)
//Parameters 
//type: convolution type.
//x: Signal vector or matrix.
//f: FIR filter coefficients.
//shape: Shape.
//Description
//This is an Octave function.
//It performs 1D or 2D convolution between the signal x and the filter coefficients f.
//Examples
//a = [1 2 3 4 5]
//b = [7 8 9 10]
//wconv(1,a,b) 
//ans =
//     7    22    46    80   114   106    85    50 

funcprot(0);
rhs = argn(2)
if(rhs<3 | rhs>4)
error("Wrong number of input arguments.")
end

select (rhs)
	case 3 then
		y = callOctave("wconv",type, x, f)
	case 4 then
		y = callOctave("wconv",type, x, f, shape)
	end
endfunction
