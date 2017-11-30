function [B,A,C] = invfreqz(H,F,nB,nA,W,iter,tol,trace)
//Fit filter B(z)/A(z)to the complex frequency response H at frequency points F.  A and B are real polynomial coefficients of order nA and nB.
//Calling Sequence
//[B,A,C] = invfreqz(H,F,nB,nA,W,iter,tol,trace)
//[B,A,C] = invfreqz(H,F,nB,nA,W)
//[B,A,C] = invfreqz(H,F,nB,nA)
//Parameters
//H: desired complex frequency response.
//F: frequency (must be same length as H).
//nB: order of the numerator polynomial B.
//nA: order of the denominator polynomial A.
//W: vector of weights (must be same length as F).
//Description
//This is an Octave function.
//Fit filter B(z)/A(z)to the complex frequency response H at frequency points F.  A and B are real polynomial coefficients of order nA and nB.
//Optionally, the fit-errors can be weighted vs frequency according to the weights W.
//Note: all the guts are in invfreq.m 
//Examples
//[B,A] = butter(4,1/4);
//[H,F] = freqz(B,A);
//[Bh,Ah,C] = invfreq(H,F,4,4)
//Bh =
//
//   0.010209   0.040838   0.061257   0.040838   0.010209
//
//Ah =
//
//   1.00000  -1.96843   1.73586  -0.72447   0.12039
//
//C =   -7.7065e-15

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 4 | rhs > 8)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 4 then
		if(lhs==1)
		B = callOctave("invfreqz",H,F,nB,nA)
		elseif(lhs==2)
		[B, A] = callOctave("invfreqz",H,F,nB,nA)
		elseif(lhs==3)
		[B, A, C] = callOctave("invfreqz",H,F,nB,nA)
		else
		error("Wrong number of output argments.")
		end

	case 5 then
		if(lhs==1)
		B = callOctave("invfreqz",H,F,nB,nA,W)
		elseif(lhs==2)
		[B, A] = callOctave("invfreqz",H,F,nB,nA,W)
		elseif(lhs==3)
		[B, A, C] = callOctave("invfreqz",H,F,nB,nA,W)
		else
		error("Wrong number of output argments.")
		end
	case 6 then
		if(lhs==1)
		B = callOctave("invfreqz",H,F,nB,nA,W,iter)
		elseif(lhs==2)
		[B, A] = callOctave("invfreqz",H,F,nB,nA,W,iter)
		elseif(lhs==3)
		[B, A, C] = callOctave("invfreqz",H,F,nB,nA,W,iter)
		else
		error("Wrong number of output argments.")
		end
	case 7 then
		if(lhs==1)
		B = callOctave("invfreqz",H,F,nB,nA,W,iter,tol)
		elseif(lhs==2)
		[B, A] = callOctave("invfreqz",H,F,nB,nA,W,iter,tol)
		elseif(lhs==3)
		[B, A, C] = callOctave("invfreqz",H,F,nB,nA,W,iter,tol)
		else
		error("Wrong number of output argments.")
		end
	case 8 then
		if(lhs==1)
		B = callOctave("invfreqz",H,F,nB,nA,W,iter,tol,trace)
		elseif(lhs==2)
		[B, A] = callOctave("invfreqz",H,F,nB,nA,W,iter,tol,trace)
		elseif(lhs==3)
		[B, A, C] = callOctave("invfreqz",H,F,nB,nA,W,iter,tol,trace)
		else
		error("Wrong number of output argments.")
		end
	end
endfunction

