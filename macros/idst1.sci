function y = idst1(x,varargin)
//This function computes the inverse type I discrete sine transform.
//Calling Sequence
//Y = idst(X)
//Y = idst(X, N)
//Parameters
//X: Matrix or integer
//N: If N is given, then X is padded or trimmed to length N before computing the transform.
//Description
//This function computes the inverse type I discrete sine transform of Y. If N is given, then Y is padded or trimmed to length N before computing the transform. If Y is a matrix, compute the transform along the columns of the the matrix.
//Examples
//idst([1,3,6])
//ans = 
//     3.97487  -2.50000   0.97487 
funcprot(0);
rhs=argn(2);
if(rhs<1 | rhs>2) then
    error("Wrong number of input arguments.");
end
select(rhs)
case 1 then
    y=callOctave("idst",x);
case 2 then
    y=callOctave("idst",x,varargin(1));
end

endfunction
