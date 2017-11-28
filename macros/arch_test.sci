function [PVAL, LM]= arch_test(Y,X,P)
// perform a Lagrange Multiplier (LM) test of thenull hypothesis of no conditional heteroscedascity against the alternative of CH(P)
//Calling Sequence
//arch_test(Y,X,P)
//PVAL = arch_test(Y,X,P)
//[PVAL, LM]= arch_test(Y,X,P)
//Parameters 
//P: Degrees of freedom
//PVAL:PVAL is the p-value (1 minus the CDF of this distribution at LM) of the test
//Description
//perform a Lagrange Multiplier (LM) test of thenull hypothesis of no conditional heteroscedascity against the alternative of CH(P).
//
//I.e., the model is
//
//          y(t) = b(1) * x(t,1) + ... + b(k) * x(t,k) + e(t),
//
//given Y up to t-1 and X up to t, e(t) is N(0, h(t)) with
//
//          h(t) = v + a(1) * e(t-1)^2 + ... + a(p) *e(t-p)^2, and the null is a(1) == ... == a(p) == 0.
//
//If the second argument is a scalar integer, k,perform the sametest in a linear autoregression model of orderk, i.e., with
//
//          [1, y(t-1), ..., y(t-K)] as the t-th row of X.
//
// Under the null, LM approximatel has a chisquare distribution with P degrees of freedom and PVAL is the p-value (1 minus the CDF of this distribution at LM) of the test.
//
// If no output argument is given, the p-value is displayed.
	funcprot(0)
	rhs= argn(2);
	lhs= argn(1);
	if(rhs<3 | rhs>3)
		error("Wrong number of input arguments");
	end
	if(lhs<1 | lhs>2)
		error("Wrong number of output arguments");
	end
	select(rhs)
	case 3 then
		select(lhs)
		case 1 then
		PVAL= callOctave("arch_test", Y, X, P);
		case 2 then
		[PVAL,LM]= callOctave("arch_test", Y, X, P);
		end
	end
endfunction