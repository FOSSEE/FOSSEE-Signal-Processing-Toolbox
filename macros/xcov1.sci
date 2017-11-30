function [R,lag] = xcov1(X, Y, biasflag)
// Compute covariance at various lags [=correlation(x-mean(x),y-mean(y))]. 
//Calling Sequence
//[R, lag] = xcov (X)
//... = xcov (X, Y)
//... = xcov (..., maxlag)
//... = xcov (..., scale)
//Parameters 
//X: Input vector
//Y: if specified, compute cross-covariance between X and Y, otherwise compute autocovariance of X.
//maxlag: is specified, use lag range [-maxlag:maxlag], otherwise use range [-n+1:n-1].
//scale:
//     'biased': for covariance=raw/N,
//     'unbiased': for covariance=raw/(N-|lag|),
//     'coeff': for covariance=raw/(covariance at lag 0),
//     'none': for covariance=raw
//     'none': is the default. 
//Description
//Compute covariance at various lags [=correlation(x-mean(x),y-mean(y))]. Returns the covariance for each lag in the range, plus an optional vector of lags.

funcprot(0);
rhs = argn(2)
if(rhs<1 | rhs>3)
error("Wrong number of input arguments.");
end

	select(rhs)
	case 1 then
	[R,lag] = callOctave("xcov",X);
	case 2 then
	[R,lag] = callOctave("xcov",X,Y);
	case 3 then
	[R,lag] = callOctave("xcov",X,Y,biasflag);
	end
endfunction
