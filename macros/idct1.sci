function y = idct1(x,n)
//Compute the inverse discrete cosine transform of input.
//Calling Sequence
//Y = idct1(X)
//Y = idct1(X, N)
//Parameters
//X: Matrix or integer
//N: If N is given, then X is padded or trimmed to length N before computing the transform.
//Description
// This function computes the inverse discrete cosine transform of input X.  If N is given, then X is padded or trimmed to length N before computing the transform.  If X is a matrix, compute the transform along the columns of the the matrix.  The transform is faster if X is real-valued and even length.
//Examples
//idct1([1,3,6])
//ans = 
//     5.1481604  - 4.3216292    0.9055197 
funcprot(0);
rhs=argn(2);
if (rhs<1 | rhs>2) then
    error("Wrong number of input arguments.");
end
select(rhs)
case 1 then
    y=callOctave("idct",x);
case 2 then 
    y=callOctave("idct",x,n);
end

endfunction
