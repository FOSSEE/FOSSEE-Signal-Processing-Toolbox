function y= ifftshift1(X,DIM)
//Undo the action of the 'fftshift1' function.
//Calling Sequence
// ifftshift1 (X)
// ifftshift1 (X, DIM)
//Parameters 
//X:It is a vector of N elements corresponding to time samples
//DIM: The optional DIM argument can be used to limit the dimension along which the permutation occurs
//Description
//This is an Octave function.
//Undo the action of the 'fftshift1' function.
//
//For even length X, 'fftshift1' is its own inverse, but odd lengths differ slightly.
	rhs= argn(2);
	if(rhs <1 | rhs >2)
		error('Wrong number of Input arguments');
	end
	select(rhs)
	case 1 then
		y=callOctave("ifftshift",X);
	case 2 then
		y=callOctave("ifftshift",X,DIM);
	end
endfunction