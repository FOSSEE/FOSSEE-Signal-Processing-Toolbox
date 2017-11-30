function [A, B] = arch_fit(Y, varargin)
//This functions fits an ARCH regression model to the time series Y using the scoring algorithm in Engle's original ARCH paper.
//Calling Sequence
//[A, B] = arch_fit (Y, X, P, ITER, GAMMA, A0, B0)
//Parameters
//Description
//Fit an ARCH regression model to the time series Y using the scoring algorithm in Engle's original ARCH paper.
//
//The model is
//
//          y(t) = b(1) * x(t,1) + ... + b(k) * x(t,k) + e(t),
//          h(t) = a(1) + a(2) * e(t-1)^2 + ... + a(p+1) * e(t-p)^2
//
//in which e(t) is N(0, h(t)), given a time-series vector Y up to time t-1 and a matrix of (ordinary) regressors X up to t. The order of the regression of the residual variance is specified by P.
//
//If invoked as 'arch_fit (Y, K, P)' with a positive integer K, fit an ARCH(K, P) process, i.e., do the above with the t-th row of X given by
//
//          [1, y(t-1), ..., y(t-k)]
//
//Optionally, one can specify the number of iterations ITER, the updating factor GAMMA, and initial values a0 and b0 for the scoring algorithm.
funcprot(0);
rhs = argn(2);
lhs=argn(1);
if(rhs<7 | rhs>7)
error("Wrong number of input arguments.");
end
if (lhs<2 | lhs>2)
    error("Wrong number of output arguments.");
end

	select(rhs)
	case 7 then
	[A, B] = callOctave("arch_fit",Y, varargin(1), varargin(2), varargin(3), varargin(4), varargin(5), varargin(6));
	end
endfunction
