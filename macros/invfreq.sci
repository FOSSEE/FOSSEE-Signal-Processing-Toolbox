function [B,A] = invfreq(H,F,nB,nA,W,iter,tol, plane)
// Calculates inverse frequency vectors
//
// Calling Sequence
//[B,A] = invfreq(H,F,nB,nA)
//[B,A] = invfreq(H,F,nB,nA,W)
//[B,A] = invfreq(H,F,nB,nA,W,[],[],plane)
//[B,A] = invfreq(H,F,nB,nA,W,iter,tol,plane)
// 
// Parameters
// H: desired complex frequency response,It is assumed that A and B are real polynomials, hence H is one-sided.
// F: vector of frequency samples in radians
// nA: order of denominator polynomial A
// nB: order of numerator polynomial B
//
// Description
//Fit filter B(z)/A(z) or B(s)/A(s) to complex frequency response at frequency points F. A and B are real polynomial coefficients of order nA and nB respectively.  Optionally, the fit-errors can be weighted vs frequency according to the weights W. Also, the transform plane can be specified as either 's' for continuous time or 'z' for discrete time. 'z' is chosen by default.  Eventually, Steiglitz-McBride iterations will be specified by iter and tol.
//
// Examples
//  [B,A] = butter(12,1/4);
//  [H,w] = freqz(B,A,128);
//  [Bh,Ah] = invfreq(H,F,4,4);
//  Hh = freqz(Bh,Ah);
//  disp(sprintf('||frequency response error|| = %f',norm(H-Hh)));
// 
funcprot(0);
lhs= argn(1);
rhs= argn(2);
if(rhs < 4 | rhs > 8 | rhs == 6 | rhs == 7 )
error("Wrong number of input arguments");
end

select(rhs)
	case 4 then
		[B,A]= callOctave("invfreq", H,F,nB,nA);
	case 5 then
		[B,A]= callOctave("invfreq", H,F,nB,nA, W);
	case 8 then
		[B,A]= callOctave("invfreq", H,F,nB, nA,iter, tol, plane);
end
endfunction

 
