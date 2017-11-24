function [y,c]= stft(x, varargin)
//Compute the short-time Fourier transform of the vector X
//Calling Sequence
//Y = stft (X)
//Y = stft (X, WIN_SIZE)
//Y = stft (X, WIN_SIZE, INC)
//Y = stft (X, WIN_SIZE, INC, NUM_COEF)
//Y = stft (X, WIN_SIZE, INC, NUM_COEF, WIN_TYPE)
//[Y,C] = stft (X)
//[Y,C] = stft (X, WIN_SIZE)
//[Y,C] = stft (X, WIN_SIZE, INC)
//[Y,C] = stft (X, WIN_SIZE, INC, NUM_COEF)
//[Y,C] = stft (X, WIN_SIZE, INC, NUM_COEF, WIN_TYPE)
//Parameters 
//X: Real scalar or vector
//WIN_SIZE: Size of the window used
//INC: Increment
//WIN_TYPE: Type of window
//Description
//Compute the short-time Fourier transform of the vector X with NUM_COEF coefficients by applying a window of WIN_SIZE data points and an increment of INC points.
//
//Before computing the Fourier transform, one of the following windows is applied:
//
//"hanning" -> win_type = 1
//
//"hamming" -> win_type = 2
//
//"rectangle" -> win_type = 3
//
//The window names can be passed as strings or by the WIN_TYPE number.
//
//The following defaults are used for unspecified arguments:WIN_SIZE= 80, INC = 24, NUM_COEF = 64, and WIN_TYPE = 1.
//
//Y = stft (X, ...)' returns the absolute values of the Fourier coefficients according to the NUM_COEF positive frequencies.
//
//'[Y, C] = stft (x, ...)' returns the entire STFT-matrix Y and a 3-element vector C containing the window size, increment, and window type, which is needed by the 'synthesis' function.

funcprot(0);
lhs= argn(1);
rhs= argn(2);

if(rhs <1 | rhs>5)
	error("Wrong number of input arguments");
end

if(lhs<1 | lhs>2)
	error("Wrong number of output arguments");
end

select(rhs)
	case 1 then
		select(lhs)
			case 1 then
				y= callOctave("stft", x);
			case 2 then
				[y,c]= callOctave("stft", x);
		end
	case 2 then
		select(lhs)
			case 1 then
				y= callOctave("stft", x,varargin(1));
			case 2 then
				[y,c]= callOctave("stft", x, varargin(1));
		end
	case 3 then
		select(lhs)
			case 1 then
				y= callOctave("stft", x,varargin(1), varargin(2));
			case 2 then
				[y,c]= callOctave("stft", x,varargin(1), varargin(2));
		end
	case 4 then
		select(lhs)
			case 1 then
				y= callOctave("stft", x,varargin(1), varargin(2), varargin(3));
			case 2 then
				[y,c]= callOctave("stft", x,varargin(1), varargin(2), varargin(3));
		end
	case 5 then
		select(lhs)
			case 1 then
				y= callOctave("stft", x,varargin(1), varargin(2), varargin(3), varargin(4));
			case 2 then
				[y,c]= callOctave("stft", x,varargin(1), varargin(2), varargin(3), varargin(4));
		end
end
endfunction


