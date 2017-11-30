function [B,A,C] = invfreqs(H,F,nB,nA,W,iter,tol,trace)
//Fit filter B(s)/A(s)to the complex frequency response H at frequency points F.  A and B are real polynomial coefficients of order nA and nB.
//Calling Sequence
//[B,A,C] = invfreqs(H,F,nB,nA,W,iter,tol,trace)
//[B,A,C] = invfreqs(H,F,nB,nA,W)
//[B,A,C] = invfreqs(H,F,nB,nA)
//Parameters
//H: desired complex frequency response.
//F: frequency (must be same length as H).
//nB: order of the numerator polynomial B.
//nA: order of the denominator polynomial A.
//W: vector of weights (must be same length as F).
//Description
//This is an Octave function.
//Fit filter B(s)/A(s)to the complex frequency response H at frequency points F.  A and B are real polynomial coefficients of order nA and nB.
//Optionally, the fit-errors can be weighted vs frequency according to the weights W.
//Note: all the guts are in invfreq.m 
//Examples
//B = [1/2 1];
//A = [1 1];
//w = linspace(0,4,128);
//H = freqs(B,A,w);
//[Bh,Ah, C] = invfreqs(H,w,1,1);
//Bh =
//
//   0.50000   1.00000
//
//Ah =
//
//   1.0000   1.0000
//
//C =   -3.0964e-15

funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 4 | rhs > 8)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 4 then
		if(lhs==1)
		B = callOctave("invfreqs",H,F,nB,nA)
		elseif(lhs==2)
		[B, A] = callOctave("invfreqs",H,F,nB,nA)
		elseif(lhs==3)
		[B, A, C] = callOctave("invfreqs",H,F,nB,nA)
		else
		error("Wrong number of output argments.")
		end

	case 5 then
		if(lhs==1)
		B = callOctave("invfreqs",H,F,nB,nA,W)
		elseif(lhs==2)
		[B, A] = callOctave("invfreqs",H,F,nB,nA,W)
		elseif(lhs==3)
		[B, A, C] = callOctave("invfreqs",H,F,nB,nA,W)
		else
		error("Wrong number of output argments.")
		end
	case 6 then
		if(lhs==1)
		B = callOctave("invfreqs",H,F,nB,nA,W,iter)
		elseif(lhs==2)
		[B, A] = callOctave("invfreqs",H,F,nB,nA,W,iter)
		elseif(lhs==3)
		[B, A, C] = callOctave("invfreqs",H,F,nB,nA,W,iter)
		else
		error("Wrong number of output argments.")
		end
	case 7 then
		if(lhs==1)
		B = callOctave("invfreqs",H,F,nB,nA,W,iter,tol)
		elseif(lhs==2)
		[B, A] = callOctave("invfreqs",H,F,nB,nA,W,iter,tol)
		elseif(lhs==3)
		[B, A, C] = callOctave("invfreqs",H,F,nB,nA,W,iter,tol)
		else
		error("Wrong number of output argments.")
		end
	case 8 then
		if(lhs==1)
		B = callOctave("invfreqs",H,F,nB,nA,W,iter,tol,trace)
		elseif(lhs==2)
		[B, A] = callOctave("invfreqs",H,F,nB,nA,W,iter,tol,trace)
		elseif(lhs==3)
		[B, A, C] = callOctave("invfreqs",H,F,nB,nA,W,iter,tol,trace)
		else
		error("Wrong number of output argments.")
		end
	end
endfunction

