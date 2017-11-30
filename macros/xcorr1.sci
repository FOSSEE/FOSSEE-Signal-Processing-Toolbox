function [R, lag] = xcorr1 (X, Y, maxlag, scale)
//Estimates the cross-correlation.
//Calling Sequence
//[R, lag] = xcorr1 (X, Y, maxlag, scale)
//[R, lag] = xcorr1 (X, Y, maxlag)
//[R, lag] = xcorr1 (X, Y)
//Parameters
//X: [non-empty; real or complex; vector or matrix] data.
//Y: [real or complex vector] data.
//	If X is a matrix (not a vector), Y must be omitted. Y may be omitted if X is a vector; in this case xcorr estimates the autocorrelation of X.
//maxlag: [integer scalar] maximum correlation lag If omitted, the default value is N-1, where N is the greater of the lengths of X and Y or, if X is a matrix, the number of rows in X.
//scale: [character string] specifies the type of scaling applied to the correlation vector (or matrix). is one of:
//	‘none’ - return the unscaled correlation, R,
//‘biased’ - return the biased average, R/N,
//‘unbiased’ - return the unbiased average, R(k)/(N-|k|),
//‘coeff’ - return the correlation coefficient, R/(rms(x).rms(y)), where "k" is the lag, and "N" is the length of X. If omitted, the default value is "none". If Y is supplied but does not have the same
//	    length as X, scale must be "none".
//Description
//This is an Octave function.
//Estimate the cross correlation R_xy(k) of vector arguments X and Y or, if Y is omitted, estimate autocorrelation R_xx(k) of vector X, for a range of lags k specified by argument "maxlag". If X is a
//matrix, each column of X is correlated with itself and every other column.
//
//The cross-correlation estimate between vectors "x" and "y" (of length N) for lag "k" is given by
// 
//            N
// R_xy(k) = sum x_{i+k} conj(y_i),
//           i=1
// 
//where data not provided (for example x(-1), y(N+1)) is zero. Note the definition of cross-correlation given above. To compute a cross-correlation consistent with the field of statistics, see xcov.
//Examples
//[R, lag] = xcorr1 ( [5 5], [2 2], 2, 'biased' )
//
//R =
//
//    0    5   10    5    0
//
//lag =
//
//  -2  -1   0   1   2

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 1 | rhs > 4)
error("Wrong number of input arguments.")
end

select(rhs)

	case 2 then
		if(lhs==1)
		R = callOctave("xcorr", X)
		elseif(lhs==2)
		[R, lag] = callOctave("xcorr", X)
		else
		error("Wrong number of output argments.")
		end

	case 2 then
		if(lhs==1)
		R = callOctave("xcorr", X, Y)
		elseif(lhs==2)
		[R, lag] = callOctave("xcorr", X, Y)
		else
		error("Wrong number of output argments.")
		end

	case 3 then
		if(lhs==1)
		R = callOctave("xcorr", X, Y, maxlag)
		elseif(lhs==2)
		[R, lag] = callOctave("xcorr", X, Y, maxlag)
		else
		error("Wrong number of output argments.")
		end
	case 4 then
		if(lhs==1)
		R = callOctave("xcorr", X, Y, maxlag, scale)
		elseif(lhs==2)
		[R, lag] = callOctave("xcorr", X, Y, maxlag, scale)
		else
		error("Wrong number of output argments.")
		end

	end
endfunction
