function y= fftshift1(X,DIM)
//Perform a shift of the vector X, for use with the 'fft1' and 'ifft1' functions, in order the move the frequency 0 to the center of the vector or matrix.
//Calling Sequence
// fftshift1 (X)
// fftshift1 (X, DIM)
//Parameters 
//X:It is a vector of N elements corresponding to time samples
//DIM: The optional DIM argument can be used to limit the dimension along which the permutation occurs
//Description
//This is an Octave function.
//Perform a shift of the vector X, for use with the 'fft1' and 'ifft1' functions, in order the move the frequency 0 to the center of the vector or matrix.
//
//If X is a vector of N elements corresponding to N time samples spaced by dt, then 'fftshift1 (fft1 (X))' corresponds to frequencies
//
//f = [ -(ceil((N-1)/2):-1:1)*df 0 (1:floor((N-1)/2))*df ]
//
//where df = 1 / dt.
//
//If X is a matrix, the same holds for rows and columns.  If X is an array, then the same holds along each dimension.
//
//The optional DIM argument can be used to limit the dimension along
     which the permutation occurs.
	rhs= argn(2);
	if(rhs <1 | rhs >2)
		error('Wrong number of Input arguments');
	end
	select(rhs)
	case 1 then
		y=callOctave("fftshift",X);
	case 2 then
		y=callOctave("fftshift",X,DIM);
	end
endfunction
