function [B,A] = invfreq(H,F,nB,nA,W,iter,tol, plane)


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

 
