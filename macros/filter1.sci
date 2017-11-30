function [Y, SF] = filter1 (B, A, X, SI, DIM)
//Apply a 1-D digital filter to the data X.
//Calling Sequence
//Y = filter1(B, A, X)
//[Y, SF] = filter1(B, A, X, SI)
//[Y, SF] = filter1(B, A, X, [], DIM)
//[Y, SF] = filter1(B, A, X, SI, DIM)
//Parameters
//B: Matrix or Integer
//A: Matrix or Integer
//X: Matrix or Integer 
//Description
//'filter' returns the solution to the following linear, time-invariant difference equation:
//
//          N                   M
//
//         SUM a(k+1) y(n-k) = SUM b(k+1) x(n-k)    for 1<=n<=length(x)
//
//         k=0                 k=0
//
//where N=length(a)-1 and M=length(b)-1.  The result is calculated over the first non-singleton dimension of X or over DIM if supplied.
//
//An equivalent form of the equation is:
//
//                    N                   M
//
//          y(n) = - SUM c(k+1) y(n-k) + SUM d(k+1) x(n-k)  for 1<=n<=length(x)
//
//                   k=1                 k=0
//
//    where c = a/a(1) and d = b/a(1).
//Examples
//filter([1,2,3], [3,4,5], [5,6,7])
//ans = 
//    1.6666667    3.1111111    4.4074074  
funcprot(0);
lhs = argn(1)
rhs = argn(2)
if (rhs < 3 | rhs > 5)
error("Wrong number of input arguments.")
end

select(rhs)
	
	case 3 then
		if(lhs==1)
		Y=callOctave("filter",B,A,X)
		elseif(lhs==2)
		[Y, SF] = callOctave("filter",B,A,X)
		else
		error("Wrong number of output arguments.")
		end
	case 4 then
		if(lhs==2)
		[Y, SF] = callOctave("filter",B,A,X,SI)
		else
		error("Wrong number of output arguments.")
	    end
	case 5 then
		if(lhs==2)
		[Y, SF] = callOctave("filter",B,A,X,SI,DIM)
		else
		error("Wrong number of output arguments.")
	    end
	
	end
endfunction
