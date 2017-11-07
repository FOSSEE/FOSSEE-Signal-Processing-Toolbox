function  [y, h] = resample( x, p, q, h )
//This function resamples in the input sequence x supplied by a factor of p/q.
//Calling Sequence
//y = resample(x, p, q)
//y = resample(x, p, q, h)
//[y, h] = resample(...)
//Parameters 
//x: scalar, vector or matrix of real or complex numbers
//p: positive integer value
//q: positive integer value
//h: scalar, vector or matrix of real or complex numbers
//Description
//This is an Octave function.
//This function resamples in the input sequence x supplied by a factor of p/q. If x is a matrix, then every column is resampled.hange the sample rate of x by a factor of p/q. 
//This is performed using a polyphase algorithm. The impulse response h, given as parameter 4, of the antialiasing filter is either specified or designed with a Kaiser-windowed sinecard. 
//Examples
//resample(1,2,3)
//ans =  0.66667

funcprot(0);
rhs = argn(2)
lhs = argn(1)
if(rhs<3 | rhs>4)
error("Wrong number of input arguments.")
end

	select(rhs)
	case 3 then
	if(lhs==1)
	y = callOctave("resample",x,p,q)
	elseif(lhs==2)
	[y,h] = callOctave("resample",x,p,q)
	end
	case 4 then
	if(lhs==1)
	y = callOctave("resample",x,p,q,h)
	elseif(lhs==2)
	[y,h] = callOctave("resample",x,p,q,h)
	end
	end
endfunction



